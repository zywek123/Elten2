<?php
require("header.php");
if(file_exists("cache/forumlist.dat")) unlink("cache/forumlist.dat");
if(file_exists("cache/forumthread".$_GET['threadid'].".dat")) unlink("cache/forumthread".$_GET['threadid'].".dat");
$moderator=getprivileges($_GET['name'])[1];
if($_GET['delete'] == 1) {
$gr=mysql_fetch_row(mquery("select id,recommended,founder from forum_groups where id in (select groupid from forums where name in (select forum from forum_threads where id=".(int)$_GET['threadid']."))"));
$grm=mquery("select user,role from forum_groups_members where user='".$_GET['name']."' and groupid=".(int)$gr[0]);
if(mysql_num_rows($grm)>0)
$role=mysql_fetch_row($grm)[1];
if($role!=2 and !($moderator==1 and $gr[1]==1))
die("-3");
mquery("DELETE FROM `forum_threads` WHERE `id`=" . ((int) $_GET['threadid']));
mquery("INSERT INTO `forum_posts_deleted` SELECT * FROM `forum_posts` WHERE `thread`=" . (int)$_GET['threadid']);
mquery("DELETE FROM `forum_posts` WHERE `thread`=" . (int)$_GET['threadid']);
mquery("UPDATE `cache` SET `expiredate`=".time()." WHERE id=0 OR `forumname`='".mysql_real_escape_string($_GET['forumname'])."'");
mquery("DELETE FROM `followedthreads` WHERE `thread`=" . (int)$_GET['threadid']);
mquery("DELETE FROM forum_read WHERE `thread`=" . (int)$_GET['threadid']);
}
if($_GET['delete'] == 2) {
$gr=mysql_fetch_row(mquery("select id,recommended,founder from forum_groups where id in (select groupid from forums where name in (select forum from forum_threads where id=".(int)$_GET['threadid']."))"));
$grm=mquery("select user,role from forum_groups_members where user='".$_GET['name']."' and groupid=".(int)$gr[0]);
if(mysql_num_rows($grm)>0)
$role=mysql_fetch_row($grm)[1];
if($role!=2 and !($moderator==1 and $gr[1]==1))
die("-3");
$posts = (int) mysql_fetch_row(mquery("select count(*) from forum_posts where thread=".((int) $_GET['threadid'])))[0];
mquery("INSERT INTO `forum_posts_deleted` SELECT * FROM `forum_posts` WHERE `thread`=" . (int)$_GET['threadid'] . " AND `id`=" . (int)$_GET['postid']);
mquery("DELETE FROM `forum_posts` WHERE `thread`=" . (int)$_GET['threadid'] . " AND `id`=" . (int)$_GET['postid']);
mquery("UPDATE `cache` SET `expiredate`=".time()." WHERE id=0 OR `forumname`='".mysql_real_escape_string($_GET['forumname'])."'");
mquery("UPDATE `forum_read` SET `posts`=`posts`-1 WHERE `thread`=" . (int)$_GET['threadid']." and posts=".$posts);
}
if($_GET['edit'] == 1) {
$q = mquery("SELECT `id`, `author` FROM `forum_posts` WHERE `id`=".(int)$_GET['postid']);
$suc = false;
while($r = mysql_fetch_row($q)) {
if($r[0] == $_GET['postid']) {
$suc = true;
$gr=mysql_fetch_row(mquery("select id,recommended,founder from forum_groups where id in (select groupid from forums where name in (select forum from forum_threads where id=".(int)$_GET['threadid']."))"));
$grm=mquery("select user,role from forum_groups_members where user='".$_GET['name']."' and groupid=".(int)$gr[0]);
if(mysql_num_rows($grm)>0)
$role=mysql_fetch_row($grm)[1];
if($r[1]!=$_GET['name'] and $role!=2 and !($moderator==1 and $gr[1]==1))
die("-3");
}
}
if($suc == false) {
die("-4");
}
$post = "";
if($_GET['buffer'] == 0)
$post = $_GET['post'];
else {
$post=buffer_get($_GET['buffer']);
}
if($post == "") {
die("-1");
}
mquery("UPDATE `forum_posts` SET `post`='".mysql_real_escape_string($post)."' WHERE `thread`=".(int)$_GET['threadid']." AND `id`='".(int)$_GET['postid']."'");
}
if($_GET['move'] == 1) {
$gr=mysql_fetch_row(mquery("select id,recommended,founder from forum_groups where id in (select groupid from forums where name in (select forum from forum_threads where id=".(int)$_GET['threadid']."))"));
$grm=mquery("select user,role from forum_groups_members where user='".$_GET['name']."' and groupid=".(int)$gr[0]);
if(mysql_num_rows($grm)>0)
$role=mysql_fetch_row($grm)[1];
if($role!=2 and !($moderator==1 and $gr[1]==1))
die("-3");
mquery("UPDATE forum_threads SET forum='".mysql_real_escape_string($_GET['destination'])."' WHERE `id`=".(int)$_GET['threadid']);
}
if($_GET['move'] == 2) {
$gr=mysql_fetch_row(mquery("select id,recommended,founder from forum_groups where id in (select groupid from forums where name in (select forum from forum_threads where id in (select thread from forum_posts where id=".(int)$_GET['postid'].")))"));
$grm=mquery("select user,role from forum_groups_members where user='".$_GET['name']."' and groupid=".(int)$gr[0]);
if(mysql_num_rows($grm)>0)
$role=mysql_fetch_row($grm)[1];
if($role!=2 and !($moderator==1 and $gr[1]==1))
die("-3");
if(file_exists("cache/forumthread".((int) $_GET['destination']).".dat")) unlink("cache/forumthread".((int) $_GET['destination']).".dat");
mquery("UPDATE forum_posts SET thread=".((int) $_GET['destination'])." WHERE `id`=".(int)$_GET['postid']);
mquery("UPDATE `forum_read` SET `posts`=`posts`-1 WHERE `thread`=" . (int)$_GET['threadid']);
}
if($_GET['rename'] == 1) {
$gr=mysql_fetch_row(mquery("select id,recommended,founder from forum_groups where id in (select groupid from forums where name in (select forum from forum_threads where id=".(int)$_GET['threadid']."))"));
$grm=mquery("select user,role from forum_groups_members where user='".$_GET['name']."' and groupid=".(int)$gr[0]);
if(mysql_num_rows($grm)>0)
$role=mysql_fetch_row($grm)[1];
if($role!=2 and !($moderator==1 and $gr[1]==1))
die("-3");
mquery("UPDATE forum_threads SET name='".mysql_real_escape_string($_GET['threadname'])."' WHERE `id`=".(int)$_GET['threadid']);
}

if($_GET['move']==3) {
$srcthread=mysql_fetch_row(mquery("select thread from forum_posts where id=".(int)$_GET['source'].""))[0];
$gr=mysql_fetch_row(mquery("select id,recommended,founder from forum_groups where id in (select groupid from forums where name in (select forum from forum_threads where id=".(int)$srcthread."))"));
$grm=mquery("select user,role from forum_groups_members where user='".$_GET['name']."' and groupid=".(int)$gr[0]);
if(mysql_num_rows($grm)>0)
$role=mysql_fetch_row($grm)[1];
if($role!=2 and !($moderator==1 and $gr[1]==1))
die("-3");
$dstthread=mysql_fetch_row(mquery("select thread from forum_posts where id=".(int)$_GET['destination']));
if(file_exists("cache/forumthread".$dstthread.".dat")) unlink("cache/forumthread".$dstthread.".dat");
if(file_exists("cache/forumthread".$srcthread.".dat")) unlink("cache/forumthread".$srcthread.".dat");
$q=mquery("select id from forum_posts where thread=".(int)$srcthread);
$ids=array();
while($r=mysql_fetch_row($q))
array_push($ids,(int)$r[0]);
if($_GET['destination']!=0)
$pos=array_search($_GET['destination'],$ids)-1;
else
$pos=count($ids)-1;
$swaps=0;
$orig=null;
$oids=$ids;
while(($ids[$pos]!=$_GET['source']) and $swaps<10000) {
++$swaps;
$i=array_search($_GET['source'],$ids);
if($orig==null) {
$orig=$ids[$pos];
}
$swap=array($oids[$i]);
$t=$ids[$i];
if($i>$pos) {
$ids[$i]=$ids[$i-1];
$ids[$i-1]=$t;
$swap[1]=$oids[$i-1];
}
elseif($i<$pos) {
$ids[$i]=$ids[$i+1];
$ids[$i+1]=$t;
$swap[1]=$oids[$i+1];
}
if($swap[0]==null or $swap[1]==null) break;
while(mysql_num_rows(mquery("select id from forum_posts where id=0"))>0) sleep(0.5);
mquery("update forum_posts set id=0 where id=".$swap[0]."");
mquery("update forum_posts set id=".$swap[0]." where id=".$swap[1]);
mquery("update forum_posts set id=".$swap[1]." where id=0");
}
}
if($_GET['closing'] == 1) {
$gr=mysql_fetch_row(mquery("select id,recommended,founder from forum_groups where id in (select groupid from forums where name in (select forum from forum_threads where id=".(int)$_GET['threadid']."))"));
$grm=mquery("select user,role from forum_groups_members where user='".$_GET['name']."' and groupid=".(int)$gr[0]);
if(mysql_num_rows($grm)>0)
$role=mysql_fetch_row($grm)[1];
if($role!=2 and !($moderator==1 and $gr[1]==1))
die("-3");
mquery("update `forum_threads` set closed=".(int)$_GET['close']." WHERE `id`=" . ((int) $_GET['threadid']));
}
if($_GET['pinning'] == 1) {
$gr=mysql_fetch_row(mquery("select id,recommended,founder from forum_groups where id in (select groupid from forums where name in (select forum from forum_threads where id=".(int)$_GET['threadid']."))"));
$grm=mquery("select user,role from forum_groups_members where user='".$_GET['name']."' and groupid=".(int)$gr[0]);
if(mysql_num_rows($grm)>0)
$role=mysql_fetch_row($grm)[1];
if($role!=2 and !($moderator==1 and $gr[1]==1))
die("-3");
mquery("update `forum_threads` set pinned=".(int)$_GET['pin']." WHERE `id`=" . ((int) $_GET['threadid']));
}

echo "0";
?>