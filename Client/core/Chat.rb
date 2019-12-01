#Elten Code
#Copyright (C) 2014-2019 Dawid Pieper
#All rights reserved.


#Open Public License is used to licensing this app!

class Scene_Chat
  def main
    if $name=="guest"
      alert(_("General:error_guest"))
      $scene=Scene_Main.new
      return
      end
    if isbanned($name)
      alert(_("Chat:error_banned"))
      $scene=Scene_Main.new
      return
      end
    if $ruby == true
      alert(_("General:error_platform"))
      $scene=Scene_Main.new
      return
      end
    $agent.write(Marshal.dump({'func'=>'chat_open'}))
    ct=srvproc("chat",{"recv"=>"1"})
    if ct[0].to_i<0
      alert(_("General:error"))
      $scene=Scene_Main.new
      return
    end
    @msg=ct[1]
    if $chat != true
    play("chat_message")
    speech("#{_("Chat:info_phr_lastmessage")}: #{@msg}")
              ct=srvproc("chat",{"send"=>"1", "text"=>_("Chat:joined")})
    if ct[0].to_i<0
      alert(_("General:error"))
      $scene=Scene_Main.new
      return
    end   
          end
    @lastmsg=@msg
    speech_wait if $chat!=true
        @form=Form.new([Edit.new(_("Chat:type_message"),"","",true),Edit.new(_("Chat:read_history"),"MULTILINE|READONLY"," ",true),Select.new([],true,0,_("Chat:opt_users"),true),Button.new(_("Chat:btn_hide")),Button.new(_("General:str_quit"))])
        @form.fields[1].silent=true
        @form.fields[1].update
        @form.fields[1].silent=false
        ct=srvproc("chat",{"hst"=>"1"})
        if ct[0].to_i<0
          alert(_("General:error"))
          $scene=Scene_Main.new
          return
        end
        hs=ct[1..ct.size-1].join
        @form.fields[1].settext(hs)
        @form.fields[1].index=@form.fields[1].text.size
        onl=srvproc("chat_online",{})
        if onl[0].to_i<0
          alert(_("General:error"))
          $scene=Scene_Main.new
          return
        end
        @form.fields[2].commandoptions=[]
                for o in onl[1..onl.size-1]
          @form.fields[2].commandoptions.push(o.delete("\r\n")) if o.size>2
          end
        upd=0
    loop do
      loop_update
      @form.update
      if (escape and $chat!=true) or ((enter or space) and @form.index==4)
        $chat=false
        $agent.write(Marshal.dump({'func'=>'chat_close'}))
        break
        end
      if (((enter or space) and @form.index == 3)) or (escape and $chat==true)
                play("signal")
                $chat=true
                $agent.write(Marshal.dump({'func'=>'chat_open'}))
                                break
        end
      upd+=1
      if upd > 120
                upd=0 
                if @form.index == 1
                          ct=srvproc("chat",{"hst"=>"1"})
        if ct[0].to_i<0
          alert(_("General:error"))
          $scene=Scene_Main.new
          return
        end
        hs=ct[1..ct.size-1].join
        @form.fields[1].settext(hs,false)
                        elsif @form.index == 2
                                onl=srvproc("chat_online",{})
        if onl[0].to_i<0
          alert(_("General:error"))
          $scene=Scene_Main.new
          return
        end
        @form.fields[2].commandoptions=[]
        for o in onl[1..onl.size-1]
          @form.fields[2].commandoptions.push(o.delete("\r\n")) if o.size>2
                        end
        end
            end
     if enter
       if @form.index == 0 and @form.fields[0].text!=""
       txt=@form.fields[0].text_str
       @form.fields[0].settext("")
       ct=srvproc("chat",{"send"=>"1", "text"=>txt})
       if ct[0].to_i < 0
         alert(_("General:error"))
       else
         play("signal")
                end
                              elsif @form.index == 2
                usermenu(@form.fields[2].commandoptions[@form.fields[2].index])
              end
              end
                end
          if $chat!=true
            ct=srvproc("chat", {"send"=>"1", "text"=>_("Chat:left")})
    if ct[0].to_i<0
      alert(_("General:error"))
      $scene=Scene_Main.new
      return
    end   
    end
         $scene=Scene_Main.new
  end
end
#Copyright (C) 2014-2019 Dawid Pieper