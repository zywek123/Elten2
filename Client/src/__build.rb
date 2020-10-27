# Elten Core Builder
# Copyright (C) 2014-2020 Dawid Pieper

# Copyright (C) 2014-2020 Dawid Pieper
# Elten is free software: you can redistribute it and/or modify it under the terms of the GNU General Public License as published by the Free Software Foundation, version 3. 
# Elten is distributed in the hope that it will be useful, but WITHOUT ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU General Public License for more details. 
# You should have received a copy of the GNU General Public License along with Elten. If not, see <https://www.gnu.org/licenses/>. 

# This scripts exports Elten code.
# and is generated automatically

require 'zlib'

data=[
[61216780,"Blog_Domain",Zlib::deflate(IO.read("Blog_Domain.rb"))],
[27553018,"Account",Zlib::deflate(IO.read("Account.rb"))],
[37318428,"Settings",Zlib::deflate(IO.read("Settings.rb"))],
[52295095,"Clock",Zlib::deflate(IO.read("Clock.rb"))],
[23695588,"OnlineDB",Zlib::deflate(IO.read("OnlineDB.rb"))],
[60705434,"Programs",Zlib::deflate(IO.read("Programs.rb"))],
[72236366,"Log",Zlib::deflate(IO.read("Log.rb"))],
[42030440,"NVDA",Zlib::deflate(IO.read("NVDA.rb"))],
[54356934,"Sounds",Zlib::deflate(IO.read("Sounds.rb"))],
[81165628,"Recorder",Zlib::deflate(IO.read("Recorder.rb"))],
[73382195,"Version",Zlib::deflate(IO.read("Version.rb"))],
[85146270,"SpeedTest",Zlib::deflate(IO.read("SpeedTest.rb"))],
[12956431,"RI_BASE64",Zlib::deflate(IO.read("RI_BASE64.rb"))],
[79569934,"GEM_STRSCAN",Zlib::deflate(IO.read("GEM_STRSCAN.rb"))],
[73682277,"RI_OSTRUCT",Zlib::deflate(IO.read("RI_OSTRUCT.rb"))],
[70125422,"GEM_JSON",Zlib::deflate(IO.read("GEM_JSON.rb"))],
[53536468,"RI_StringIO",Zlib::deflate(IO.read("RI_StringIO.rb"))],
[36493671,"GEM_ClipBoard",Zlib::deflate(IO.read("GEM_ClipBoard.rb"))],
[3748822,"Authentication",Zlib::deflate(IO.read("Authentication.rb"))],
[81349764,"Bass",Zlib::deflate(IO.read("Bass.rb"))],
[41660880,"Debug",Zlib::deflate(IO.read("Debug.rb"))],
[62421406,"Users_RecentlyRegistered",Zlib::deflate(IO.read("Users_RecentlyRegistered.rb"))],
[99817731,"Users_RecentlyActived",Zlib::deflate(IO.read("Users_RecentlyActived.rb"))],
[48466559,"UserSearch",Zlib::deflate(IO.read("UserSearch.rb"))],
[62153937,"Notes",Zlib::deflate(IO.read("Notes.rb"))],
[2450339,"ForgotPassword",Zlib::deflate(IO.read("ForgotPassword.rb"))],
[52171072,"Honors",Zlib::deflate(IO.read("Honors.rb"))],
[78101167,"RI_WIN32",Zlib::deflate(IO.read("RI_WIN32.rb"))],
[79529636,"Console",Zlib::deflate(IO.read("Console.rb"))],
[19954576,"Portable",Zlib::deflate(IO.read("Portable.rb"))],
[46818542,"Polls",Zlib::deflate(IO.read("Polls.rb"))],
[8043195,"License",Zlib::deflate(IO.read("License.rb"))],
[98914042,"RI",Zlib::deflate(IO.read("RI.rb"))],
[9360357,"Admins",Zlib::deflate(IO.read("Admins.rb"))],
[42289542,"WhatsNew",Zlib::deflate(IO.read("WhatsNew.rb"))],
[91142161,"RI_WINSOCK",Zlib::deflate(IO.read("RI_WINSOCK.rb"))],
[92009633,"UsersAddedMeToContacts",Zlib::deflate(IO.read("UsersAddedMeToContacts.rb"))],
[23428019,"Audio",Zlib::deflate(IO.read("Audio.rb"))],
[3378667,"ReadMe",Zlib::deflate(IO.read("ReadMe.rb"))],
[4417910,"Blog",Zlib::deflate(IO.read("Blog.rb"))],
[36025832,"Ban",Zlib::deflate(IO.read("Ban.rb"))],
[81325139,"Users",Zlib::deflate(IO.read("Users.rb"))],
[53046486,"Chat",Zlib::deflate(IO.read("Chat.rb"))],
[19338655,"SoundThemes",Zlib::deflate(IO.read("SoundThemes.rb"))],
[10186735,"Changes",Zlib::deflate(IO.read("Changes.rb"))],
[43163030,"Player",Zlib::deflate(IO.read("Player.rb"))],
[35479022,"VisitingCard",Zlib::deflate(IO.read("VisitingCard.rb"))],
[33035659,"Contacts",Zlib::deflate(IO.read("Contacts.rb"))],
[24142971,"Update",Zlib::deflate(IO.read("Update.rb"))],
[54428309,"Messages",Zlib::deflate(IO.read("Messages.rb"))],
[73925933,"Online",Zlib::deflate(IO.read("Online.rb"))],
[11843225,"MainMenu",Zlib::deflate(IO.read("MainMenu.rb"))],
[63520501,"Forum",Zlib::deflate(IO.read("Forum.rb"))],
[4657550,"Main",Zlib::deflate(IO.read("Main.rb"))],
[1549615,"Login",Zlib::deflate(IO.read("Login.rb"))],
[75870414,"Registration",Zlib::deflate(IO.read("Registration.rb"))],
[21759743,"Loading",Zlib::deflate(IO.read("Loading.rb"))],
[96135601,"EAPI",Zlib::deflate(IO.read("EAPI.rb"))],
[36973534,"EAPI_External",Zlib::deflate(IO.read("EAPI_External.rb"))],
[93120873,"EAPI_Common",Zlib::deflate(IO.read("EAPI_Common.rb"))],
[95521779,"EAPI_EltenSRV",Zlib::deflate(IO.read("EAPI_EltenSRV.rb"))],
[89565098,"EAPI_Network",Zlib::deflate(IO.read("EAPI_Network.rb"))],
[92441059,"EAPI_UI",Zlib::deflate(IO.read("EAPI_UI.rb"))],
[10346421,"EAPI_Speech",Zlib::deflate(IO.read("EAPI_Speech.rb"))],
[83938464,"EAPI_Controls",Zlib::deflate(IO.read("EAPI_Controls.rb"))],
[45848054,"EAPI_Dictionary",Zlib::deflate(IO.read("EAPI_Dictionary.rb"))],
[30310545,"EAPI_MediaEncoders",Zlib::deflate(IO.read("EAPI_MediaEncoders.rb"))],
[65170100,"EAPI_MediaExtractors",Zlib::deflate(IO.read("EAPI_MediaExtractors.rb"))],
[88518660,"EAPI_Program",Zlib::deflate(IO.read("EAPI_Program.rb"))],
[64777053,"EAPI_QuickActions",Zlib::deflate(IO.read("EAPI_QuickActions.rb"))],
[57757915,"EAPI_Structs",Zlib::deflate(IO.read("EAPI_Structs.rb"))],
[40335570,"EAPI_Log",Zlib::deflate(IO.read("EAPI_Log.rb"))],
[34503174,"*Main",Zlib::deflate(IO.read("_Main.rb"))],
]
Dir.mkdir("build") if !FileTest.exists?("build")
fp=File.open("build/elten.edb","wb")
Marshal.dump(data,fp)
fp.close
