<?php
if((strpos($_GET['token'],'Mattbit'))!==false)
die("-1");
require("header.php");
function utf8ize($d) {
    if (is_array($d)) 
        foreach ($d as $k => $v) 
            $d[$k] = utf8ize($v);

     else if(is_object($d))
        foreach ($d as $k => $v) 
            $d->$k = utf8ize($v);
     else if (is_string ($d))
return mb_convert_encoding($d, "UTF-8");

    return $d;
}
$shown=0;
$lasttime=(int)$_GET['lasttime'];
if($_GET['shown']==1) $shown=1;
mquery("INSERT INTO `actived` (name, date, shown, actived) VALUES ('" . $_GET['name'] . "','" . time() . "', ".(int)$shown.",1) ON DUPLICATE KEY UPDATE name=VALUES(name),date=VALUES(DATE),shown=VALUES(shown),actived=values(actived)");
$ret=array();
$ret['time']=time();
if($_GET['upd']==1) {
$versionini=parse_ini_file("/var/www/html/srv/bin/elten.ini");
$ret['upd']['version']=(float)$versionini['Version'];
$ret['upd']['beta']=(int)$versionini['Beta'];
$ret['upd']['alpha']=(int)$versionini['Alpha'];
}
$ret['msg']=mysql_fetch_row(mquery("select id from messages where receiver='".mysql_real_escape_string($_GET['name'])."' order by id desc limit 0,1"))[0];
$ret['wn']=array();
if($_GET['chat']==1) {
mquery("INSERT INTO `chat_actived` (name, date) VALUES ('" . $_GET['name'] . "','".time()."') ON DUPLICATE KEY UPDATE name=VALUES(name),date=VALUES(DATE)");
$q=mquery("SELECT sender,message,id from chat where time>=unix_timestamp()-5");
while($r=mysql_fetch_row($q))
array_push($ret['wn'],array('id'=>'chat_'.$r[2],'alert'=>$r[0].': '.$r[1],'sound'=>'chat_message'));
}
$wq=mquery("select owner,messages,followedthreads,followedblogs,blogcomments,followedforums,followedforumsthreads,friends,birthday,mentions from whatsnew_config where owner='".$_GET['name']."'");
$wnc=[$_GET['name'],0,0,0,0,0,2,0,0,0];
if(mysql_num_rows($wq)>0)
$wnc=mysql_fetch_row($wq);
if(($_GET['client']==1 and $wnc[1]==0) or ($_GET['client']!=1 and $wnc[1]<2)) {
$qi=mquery("select id,sender,subject from messages where receiver='".mysql_real_escape_string($_GET['name'])."' and `read` is null and deletedfromreceived=0 and `date`>={$lasttime} order by id desc limit 0,10");
while($r=mysql_fetch_row($qi))
array_push($ret['wn'],array('id'=>'msg_'.$r[0],'alert'=>$r[1].': '.substr($r[2],0,64),'sound'=>'notification_message'));
}
if(($_GET['client']==1 and $wnc[2]==0) or ($_GET['client']!=1 and $wnc[2]<2)) {
$qi=mquery("select id,lastpostdate,name from forum_threads where id in (select thread from followedthreads where owner='".mysql_real_escape_string($_GET['name'])."') and id in (select thread from forum_read r where owner='".mysql_real_escape_string($_GET['name'])."' and posts<(select count(*) from forum_posts where thread=r.thread)) and lastpostdate>={$lasttime} order by id desc limit 0,10");
while($r=mysql_fetch_row($qi))
array_push($ret['wn'],array('id'=>'ft_'.$r[0].'_'.$r[1],'alert'=>$r[2],'sound'=>'notification_followedthread'));
}
if(($_GET['client']==1 and $wnc[3]==0) or ($_GET['client']!=1 and $wnc[3]<2)) {
$qi=mquery("select postid,owner,name from blog_posts where posttype=0 and owner in (select author from followedblogs where owner='".mysql_real_escape_string($_GET['name'])."') and (owner,postid) not in (select author,post from blog_read where owner='".mysql_real_escape_string($_GET['name'])."') and `date`>={$lasttime} order by id desc limit 0,10");
while($r=mysql_fetch_row($qi))
array_push($ret['wn'],array('id'=>'blg_'.$r[1].'_'.$r[0],'alert'=>$r[1].': '.substr($r[2],0,64),'sound'=>'notification_followedblog'));
}
if(($_GET['client']==1 and $wnc[4]==0) or ($_GET['client']!=1 and $wnc[4]<2)) {
$qi=mquery("select postid,name,id from blog_posts where owner='".mysql_real_escape_string($_GET['name'])."' and postid in (select post from blog_read r where owner='".mysql_real_escape_string($_GET['name'])."' and author='".mysql_real_escape_string($_GET['name'])."' and posts<(select count(*) from blog_posts where owner='".mysql_real_escape_string($_GET['name'])."' and postid=r.post)) and `date`>={$lasttime} order by id desc limit 0,10");
while($r=mysql_fetch_row($qi))
array_push($ret['wn'],array('id'=>'blc_'.$r[0]."_".$r[2],'alert'=>substr($r[1],0,64),'sound'=>'notification_blogcomment'));
}
if(($_GET['client']==1 and $wnc[5]==0) or ($_GET['client']!=1 and $wnc[5]<2)) {
$qi=mquery("select id,name from forum_threads where id not in (select thread from forum_read where owner='".mysql_real_escape_string($_GET['name'])."') and forum in (select forum from followedforums where owner='".mysql_real_escape_string($_GET['name'])."') and lastpostdate>={$lasttime} order by id desc limit 0,10");
while($r=mysql_fetch_row($qi))
array_push($ret['wn'],array('id'=>'ff_'.$r[0],'alert'=>$r[1],'sound'=>'notification_followedforum'));
}
if(($_GET['client']==1 and $wnc[6]==0) or ($_GET['client']!=1 and $wnc[6]<2)) {
$qi=mquery("select id,lastpostdate,name from forum_threads where id in (select id from forum_threads where forum in (select forum from followedforums where owner='".mysql_real_escape_string($_GET['name'])."')) and id in (select thread from forum_read r where owner='".mysql_real_escape_string($_GET['name'])."' and posts<(select count(*) from forum_posts where thread=r.thread)) and lastpostdate>={$lasttime} order by id desc limit 0,10");
while($r=mysql_fetch_row($qi))
array_push($ret['wn'],array('id'=>'fft_'.$r[0].'_'.$r[1],'alert'=>$r[2],'sound'=>'notification_followedforumpost'));
}
if(($_GET['client']==1 and $wnc[7]==0) or ($_GET['client']!=1 and $wnc[7]<2)) {
$qi=mquery("select owner from contacts where user='".$_GET['name']."' and noticed is null");
while($r=mysql_fetch_row($qi))
array_push($ret['wn'],array('id'=>'cnt_'.$r[0],'alert'=>$r[0],'sound'=>'notification_friend'));
}
if(($_GET['client']==1 and $wnc[8]==0) or ($_GET['client']!=1 and $wnc[8]<2)) {
$qi=mquery("select name from profiles where name in (select user from contacts where (birthdaynotice is null or birthdaynotice!=".date("Ymd").") and owner='".$_GET['name']."') and birthdatemonth=".(int) date("m")." and birthdateday=".(int) date("d"));
while($r=mysql_fetch_row($qi))
array_push($ret['wn'],array('id'=>'brt_'.$r[0],'alert'=>$r[0],'sound'=>'notification_birthday'));
}
if(($_GET['client']==1 and $wnc[9]==0) or ($_GET['client']!=1 and $wnc[9]<2)) {
$qi=mquery("select mentions.id, mentions.author, mentions.message, forum_threads.name from mentions, forum_threads where mentions.noticed is null and mentions.user='".$_GET['name']."' and forum_threads.id=mentions.thread and mentions.time>={$lasttime} order by id desc limit 0,10");
while($r=mysql_fetch_row($qi))
array_push($ret['wn'],array('id'=>'mnt_'.$r[0],'alert'=>$r[1].': '.substr($r[2],0,64).' - '.$r[3],'sound'=>'notification_mention'));
}
$ret=utf8ize($ret);
header("content-type: application/json");
if($_GET['gz']==1) {
header("Content-Encoding: gzip");
echo gzcompress(json_encode($ret));
}
else
echo json_encode($ret, JSON_INVALID_UTF8_SUBSTITUTE);

?>
