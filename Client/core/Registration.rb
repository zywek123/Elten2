#Elten Code
#Copyright (C) 2014-2019 Dawid Pieper
#All rights reserved.


#Open Public License is used to licensing this app!

class Scene_Registration
  def main
    name = ""
    password = ""
    mail = ""
    while name == ""
    name = input_text(_("Registration:type_login"))
  end
  name.gsub("@") do
    alert(_("Registration:info_namenoats"))
  end    
  name.gsub("/") do
    alert(_("Registration:info_slashes"))
  end
    name.gsub("\\") do
    alert(_("Registration:info_slashes"))
  end
    name.gsub(" ") do
    alert(_("Registration:info_spaces"))
  end
          name.delete!("/ ,;@")
  name.delete!("\\")
  pswconfirm = ""
  while password == "" or password != pswconfirm
    password = input_text(_("Registration:type_pass"),"password")
    pswconfirm = input_text(_("Registration:type_passagain"),"password")
    if pswconfirm != password
      alert(_("Registration:error_difpass"))
      end
  end
  while mail.include?("@")==false
    mail = input_text(_("Registration:type_mail"))
    end
regtemp = srvproc("register", {"register"=>"1", "name"=>name, "password"=>password, "mail"=>mail})
id = regtemp[0].to_i
case id
when 0
  alert(_("Registration:info_registered"))
  when -1
    alert(_("Registration:error_unknown"))
    when -2
      alert(_("Registration:error_accountexists"))
      when -3
        alert(_("Registration:error_save"))
        when -4
          alert(_("Registration:error_connection"))
        end
        speech_wait
      $scene = Scene_Loading.new
      main if id != 0
  end
  end
#Copyright (C) 2014-2019 Dawid Pieper