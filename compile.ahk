#NoEnv
#NoTrayIcon
SetWorkingDir %A_ScriptDir%
IniWrite, Regular, build.ini, build, Edition

; if the developer.lib exists, it will be excluded and then returned to normal for the uncompiled version, otherwise it will stay excluded
IfExist, Libraries/developer.lib 
{
	FileMove, Libraries/developer.lib, Libraries/excluded, 1
	libreturn:=true
}

FileDelete, Base.exe
FileDelete, devRS-install.exe
FileDelete, devRS-install-d.exe
Run, Compiler/Ahk2Exe.exe /in "Base.ahk" /icon "Base/RSIcon.ico"
While ! FileExist( "Base.exe" )
	Sleep 50
Run, Compiler/Ahk2Exe.exe /in "installer" /out "devRS-install.exe" /icon "Base/RSIcon.ico"
While ! FileExist( "devRS-install.exe" )
	Sleep 50
FileDelete, Base.exe

if libreturn
{
	FileCopy, Libraries/excluded, Libraries/developer.lib, 1
	Run, Compiler/Ahk2Exe.exe /in "Base.ahk" /icon "Base/RSIcon.ico"
	While ! FileExist( "Base.exe" )
		Sleep 50
	IniWrite, Developer, build.ini, build, Edition
	Run, Compiler/Ahk2Exe.exe /in "installer" /out "devRS-install-d.exe" /icon "Base/RSIcon.ico"
	While ! FileExist( "devRS-install-d.exe" )
		Sleep 50
}

If FileExist("devRS-install.exe") && FileExist("devRS-install-d.exe")
	FileDelete, Base.exe
	
IniDelete, build.ini, build, Edition
ExitApp