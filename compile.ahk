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
Run, Compiler/Ahk2Exe.exe /in "Base.ahk" /icon "Base/RSIcon.ico"
While ! FileExist( "Base.exe" )
	Sleep 500
Run, Compiler/Ahk2Exe.exe /in "installer" /out "devRS-install.exe" /icon "Base/RSIcon.ico"
While ! FileExist( "devRS-install.exe" )
	Sleep 500
FileDelete, Base.exe

if libreturn
	FileCopy, Libraries/excluded, Libraries/developer.lib, 1

IniDelete, build.ini, build, Edition
ExitApp