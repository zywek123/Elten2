#Elten Code
#Copyright (C) 2014-2019 Dawid Pieper
#All rights reserved.


#Open Public License is used to licensing this app!

class Scene_Authentication
  def main
    auth=srvproc("authentication",{"state"=>"1"})
    if auth[0].to_i<0
      speak(_("General:error"))
      speech_wait
      return $scene=Scene_Main.new
    end
    state=auth[1].to_i
    action=0
    if state==0
      action=selector([_("General:str_enable"),_("General:str_quit")],_("Authentication:head_enabled"),0,1,1)
    else
      action=selector([_("General:str_disable"),_("General:str_quit")],_("Authentication:head_disabled"),0,1,1)
    end
if action==0
  if state==0
password=""
suc=true
phone=""
  password=input_text(_("Authentication:type_pass"),"PASSWORD|ACCEPTESCAPE") while password==""
  return main if password=="\004ESCAPE\004"
phone=input_text(_("Authentication:type_phone"),"ACCEPTESCAPE") while (phone=="" or (phone[0..0]!="+" and phone[0..1]!="00") or phone.size<11 or (/[a-zA-Z,.\/;'\"\[\]!@\#\$%\^\&\*\(\)\_]/=~phone)!=nil) and phone!="\004ESCAPE\004"
return main if phone=="\004ESCAPE\004"
return main if confirm(_("Authentication:alert_support"))==0
return main if input_text(_("Authentication:alert_checkphone"),"ACCEPTESCAPE|READONLY",phone)=="\004ESCAPE\004"
if suc==true
alert(_("Authentication:wait"))
enb=srvproc("authentication",{"password"=>password, "phone"=>phone, "enable"=>"1", "lang"=>$language})
speech_wait
if enb[0].to_i<0||enb[0].include?("-")
  alert(_("General:error"))
else
  code=""
  tries=0
  label=_("Authentication:type_code")
  while tries<3
  code=input_text(label,"NUMBERS").delete("\r\n") while code==""
    cnf=srvproc("authentication",{"verify"=>"1", "code"=>code, "appid"=>$appid})
  if cnf[0].to_i<0||cnf[0].include?("-")
        tries+=1
        code=""
        if tries<3
          label=_("Authentication:type_wrongcode")
        else
          alert(_("Authentication:error_wrongcode"))
          end
    speech_wait
  else
    alert(_("Authentication:info_enabled"))
    break
  end
end
  end

  end
elsif state==1
  password=""
  password=input_text(_("Authentication:type_pass"),"PASSWORD|ACCEPTESCAPE") while password==""
  if password!="\004ESCAPE\004" and confirm(_("Authentication:alert_disable"))==1
    dsb=srvproc("authentication",{"disable"=>"1", "password"=>password})
    if dsb[0].to_i==0
      alert(_("Authentication:info_disabled"))
    elsif dsb[0].to_i==-2
      alert(_("Authentication:error_wrongpass"))
      else
      alert(_("General:error"))
    end
    speech_wait
    end
    end
  end
    $scene=Scene_Main.new if action==1
  end
  end
#Copyright (C) 2014-2019 Dawid Pieper