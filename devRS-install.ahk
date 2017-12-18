#NoEnv
#NoTrayIcon
Version=1.64
SendMode Input
ScriptName=.devRS
global dpi:=DpiFactor()

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

DPIFactor()
{ 
RegRead, DPI_value, HKEY_CURRENT_USER, Control Panel\Desktop\WindowMetrics, AppliedDPI 
; the reg key was not found - it means default settings 
; 96 is the default font size setting 
if (errorlevel=1) OR (DPI_value=96 )
	return 1
else
	Return  DPI_Value/96
}

#Include Libraries\RSNotify.lib