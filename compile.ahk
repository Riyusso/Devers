#NoEnv
#NoTrayIcon
SetWorkingDir %A_ScriptDir%

IfExist, Base.exe
	FileDelete, Base.exe
IfExist, Devers-install.exe
	FileDelete, Devers-install.exe
Sleep 500

Run, Compiler/Compiler.exe /in "Base.ahk" /icon "Base/Logo.ico" /bin Compiler/AutoHotkeySC.bin
While ! FileExist( "Base.exe" )
	Sleep 250
Run, Compiler/Compiler.exe /in "installer" /out "Devers-install.exe" /icon "Base/Logo.ico" /bin Compiler/AutoHotkeySC.bin
While ! FileExist( "Devers-install.exe" )
	Sleep 250
If FileExist("Devers-install.exe")
	FileDelete, Base.exe

ExitApp