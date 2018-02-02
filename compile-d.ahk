#NoEnv
#NoTrayIcon
SetWorkingDir %A_ScriptDir%

IfExist, Libraries/developer.lib
{
	IniWrite, Developer, build.ini, build, Edition

	FileDelete, Base.exe
	FileDelete, devRS-install-d.exe
	Run, Compiler/Ahk2Exe.exe /in "Base.ahk" /icon "Base/RSIcon.ico"
	While ! FileExist( "Base.exe" )
		Sleep 500
	Run, Compiler/Ahk2Exe.exe /in "installer" /out "devRS-install-d.exe" /icon "Base/RSIcon.ico"
	While ! FileExist( "devRS-install-d.exe" )
		Sleep 500
	FileDelete, Base.exe

	IniDelete, build.ini, build, Edition
}
else
	MsgBox, developer.lib doesn't exist. Exiting.

ExitApp