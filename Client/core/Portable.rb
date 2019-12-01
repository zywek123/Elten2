#Elten Code
#Copyright (C) 2014-2019 Dawid Pieper
#All rights reserved.


#Open Public License is used to licensing this app!

class Scene_Portable
  def main
    @form=Form.new([FilesTree.new(_("Portable:head_dest"),getdirectory(40),true,true,"Documents"),CheckBox.new(_("Portable:chk_settings")),CheckBox.new(_("Portable:chk_soundthemes")),CheckBox.new(_("Portable:chk_sfx")),Button.new(_("Portable:btn_continue")),Button.new(_("General:str_cancel"))])    
loop do
  loop_update
  @form.update
  if escape or ((enter or space) and @form.index==5)
    $scene=Scene_Main.new
    return
    break
  end
  if (enter or space) and @form.index==4
    break
    end
end
waiting
speak(_("Portable:wait"))
@destdir=@form.fields[0].path+"\\"+@form.fields[0].file+"\\Elten_#{$version.to_s}_#{if $alpha > 0;"_RC"+$alpha.to_s;elsif $beta > 0;"_B"+$beta.to_s;else;"";end}_portable"
copier
    loop_update
    speech_wait
        if @form.fields[1].checked==1 or @form.fields[2].checked==1 or @form.fields[3].checked==1
      Dir.mkdir("#{@destdir}/eltendata") if FileTest.exists?("#{@destdir}/eltendata")==false
    if @form.fields[1].checked == 1
  speak(_("Portable:wait_settings"))
  copyfile($eltendata+"\\elten.ini",@destdir+"\\eltendata/elten.ini")
  speech_wait
  if $voice != -1 and $voice != -3
    waiting_end
    dialog_open
  v = selector([_("Portable:opt_usedefault"),_("Portable:opt_synthreset"),_("Portable:opt_askeverytime"),_("Portable:opt_usecurrent")],_("Portable:head_synth"),0,3,1)
  value=0
  value=-1 if v==0
  value=-2 if v==1
  value=-3 if v==2
  writeini("#{@destdir}/eltendata/elten.ini","Voice","Voice",value.to_s) if value != 0
  if @form.fields[3].checked==0
    writeini("#{@destdir}/elten.ini","Interface","SoundTheme","")
  end
  dialog_close
  waiting
end
end
if @form.fields[2].checked == 1
  speak(_("Portable:wait_soundthemes"))
  copier(".","/eltendata/soundthemes","",$soundthemesdata+"/")
  speech_wait
  end
      end        
      writeini("#{@destdir}\\elten.ini","Elten","Portable","1")
      writeini("#{@destdir}\\elten.ini","Elten","SFX","2")
      if @form.fields[3].checked==1
 writefile($tempdir+"\\portxfs.tmp","sfx configuration
Setup="+File.basename(@destdir)+"\\"+File.basename($path)+"
TempMode
Silent=1
Overwrite=1
Title=Extracting Elten Temporary Files...
Text
{
Please wait while Elten files are being extracted...
}")
speak(_("Portable:wait_preparingfile"))
executeprocess("bin\\rar.exe a -r -ep1 -df -ma -sfx -z\"#{$tempdir}\\portxfs.tmp\" \"#{@destdir}.exe\" \"#{@destdir}\" -y",true)
speech_wait
        end
      waiting_end
        alert(_("Portable:info_created"))
      $scene=Scene_Main.new
    end
  def copier(dir=".",dest="",incl="",start="")
loop_update
    Dir.mkdir("#{@destdir}"+dest) if dir=="." and FileTest.exists?("#{@destdir}"+dest)==false
    Dir.mkdir("#{@destdir}"+dest+"/"+dir) if dir != "." and FileTest.exists?("#{@destdir}"+dest+"/"+dir)==false
                        dr=Dir.entries(start+dir)
    dr.delete(".")
    dr.delete("..")
    for t in dr
      f=dir+"/"+t
      f=t if dir=="."
      if File.file?(start+f)
      Win32API.new("kernel32","CopyFile",'ppi','i').call(start+f,"#{@destdir}"+dest+"/"+f,0) if f.include?("tmp")==false and f.include?($tempdir+"") == false and t.include?(incl)
    elsif File.directory?(start+f)
      if f!=$tempdir+"" and f.downcase.include?("kopia")==false
      copier(f,dest,incl,start)
      end
    end
    end
    end
  end
#Copyright (C) 2014-2019 Dawid Pieper