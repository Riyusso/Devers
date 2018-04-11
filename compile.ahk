#NoEnv
#NoTrayIcon
SetWorkingDir %A_ScriptDir%

; Important note : folder(Compile) cannot be renamed to (Compiler) or the default compiler installed with autohotkey will be used

IfExist, Base.exe
	FileDelete, Base.exe
IfExist, devRS-install.exe
	FileDelete, devRS-install.exe
Sleep 500

Run, Compiler/Compiler.exe /in "Base.ahk" /icon "Base/RSIcon.ico"
While ! FileExist( "Base.exe" )
	Sleep 250
Run, Compiler/Compiler.exe /in "installer" /out "devRS-install.exe" /icon "Base/RSIcon.ico"
While ! FileExist( "devRS-install.exe" )
	Sleep 250
If FileExist("devRS-install.exe")
	FileDelete, Base.exe

ExitApp