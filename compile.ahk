#NoEnv
#NoTrayIcon
SetWorkingDir %A_ScriptDir%

IfExist, Base.exe
	FileDelete, Base.exe
IfExist, devRS-install.exe
	FileDelete, devRS-install.exe
IfExist, devRS-install-d.exe
	FileDelete, devRS-install-d.exe
Sleep 500

IfExist, Libraries/developer.lib
	FileMove, Libraries/developer.lib, Libraries/excluded, 1

Sleep 500
Run, Compiler/Ahk2Exe.exe /in "Base.ahk" /icon "Base/RSIcon.ico"
While ! FileExist( "Base.exe" )
	Sleep 50
Run, Compiler/Ahk2Exe.exe /in "installer" /out "devRS-install.exe" /icon "Base/RSIcon.ico"
While ! FileExist( "devRS-install.exe" )
	Sleep 50
If FileExist("devRS-install.exe")
	FileDelete, Base.exe

IfExist, Libraries/excluded
{
	FileMove, Libraries/excluded, Libraries/developer.lib, 1
	Run, Compiler/Ahk2Exe.exe /in "Base.ahk" /icon "Base/RSIcon.ico"
	While ! FileExist( "Base.exe" )
		Sleep 50
	Run, Compiler/Ahk2Exe.exe /in "installer" /out "devRS-install-d.exe" /icon "Base/RSIcon.ico"
	While ! FileExist( "devRS-install-d.exe" )
		Sleep 50
	FileDelete, Base.exe
}

ExitApp