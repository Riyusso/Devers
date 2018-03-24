#NoEnv
#NoTrayIcon
SetWorkingDir %A_ScriptDir%

; Important note : folder(Compile) cannot be renamed to (Compiler) or the default compiler installed with autohotkey will be used

IfExist, Base.exe
	FileDelete, Base.exe
IfExist, devRS-install.exe
	FileDelete, devRS-install.exe
IfExist, devRS-install-d.exe
	FileDelete, devRS-install-d.exe
Sleep 500

IfExist, Libraries/developer.lib
	FileMove, Libraries/developer.lib, Libraries/excluded, 1

While FileExist( "Base.exe" ) or FileExist( "developer.lib" )
	Sleep 250

Run, Compiler/Compiler.exe /in "Base.ahk" /icon "Base/RSIcon.ico"
While ! FileExist( "Base.exe" )
	Sleep 250
Run, Compiler/Compiler.exe /in "installer" /out "devRS-install.exe" /icon "Base/RSIcon.ico"
While ! FileExist( "devRS-install.exe" )
	Sleep 250
If FileExist("devRS-install.exe")
	FileDelete, Base.exe

IfExist, Libraries/excluded
{
	FileMove, Libraries/excluded, Libraries/developer.lib, 1
	Run, Compiler/Compiler.exe /in "Base.ahk" /icon "Base/RSIcon.ico"
	While ! FileExist( "Base.exe" )
		Sleep 250
	Run, Compiler/Compiler.exe /in "installer" /out "devRS-install-d.exe" /icon "Base/RSIcon.ico"
	While ! FileExist( "devRS-install-d.exe" )
		Sleep 250
	FileDelete, Base.exe
}

ExitApp