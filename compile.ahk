#NoEnv
#NoTrayIcon
SetWorkingDir %A_ScriptDir%

FileDelete, Base.exe
FileDelete, devRS-install.exe
Sleep 500
Run, Compiler/Ahk2Exe.exe /in "Base.ahk" /icon "Base/RSIcon.ico"
While ! FileExist( "Base.exe" )
	Sleep 50
Run, Compiler/Ahk2Exe.exe /in "installer" /out "devRS-install.exe" /icon "Base/RSIcon.ico"
While ! FileExist( "devRS-install.exe" )
	Sleep 50
FileDelete, Base.exe

If FileExist("devRS-install.exe")
	FileDelete, Base.exe
ExitApp