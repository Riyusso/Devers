#NoEnv
#NoTrayIcon
Version=1.62
SendMode Input
ScriptName=.devRS

IfExist, %A_MyDocuments%\%ScriptName%\%ScriptName%.exe
{
	SetWorkingDir %A_MyDocuments%\%scriptname%
	IniRead, CurrentVersion, build.ini, build, Version
	IfNotExist, %A_MyDocuments%\%ScriptName%\build.ini
	CurrentVersion=1.0
	If (Version>CurrentVersion)
	{
		GoSub UpdateIt
	}
	IfExist, % A_MyDocuments "\" scriptname "\" scriptname ".exe"
	Run, % A_MyDocuments "\" scriptname "\" scriptname ".exe"
}
else
{
	FileCreateDir, %A_MyDocuments%\%ScriptName%
	SetWorkingDir %A_MyDocuments%\%scriptname%
	FileInstall, .devRS.exe, %A_MyDocuments%\%ScriptName%\%ScriptName%.exe, 1
	Sleep 1250
	IfExist, % A_MyDocuments "\" scriptname "\" scriptname ".exe"
	Run, % A_MyDocuments "\" scriptname "\" scriptname ".exe"
	IniWrite, %Version%, build.ini, build, Version
	ExitApp
}
ExitApp
return

UpdateIt:
		IniWrite, 1, build.ini, build, ExitVar
		RSNotify("Updating")
		Sleep 750
		FileInstall, .devRS.exe, %A_MyDocuments%\%ScriptName%\%ScriptName%.exe, 1
		IniWrite, 0, build.ini, build, ExitVar
		IniWrite, %Version%, build.ini, build, Version
		Sleep 1250
return

#Include Libraries\RSNotify.lib