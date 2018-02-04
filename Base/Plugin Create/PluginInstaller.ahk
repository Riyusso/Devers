; Installs the plugin in the user's program directory
; Just compile, zip and send

#NoEnv
#NoTrayIcon
SendMode Input
SetWorkingDir %A_ScriptDir% 
ScriptName=.devRS
PluginNumber=1

Loop, Files, %A_MyDocuments%\%ScriptName%\*.ahk
PluginNumber+=1

FileInstall, Plugin.ahk, %A_MyDocuments%\%ScriptName%\Plugin%PluginNumber%.ahk

If(A_IsCompiled)
	IniWrite, %A_ScriptFullPath%, %A_MyDocuments%\%ScriptName%\build.ini, build, PluginPath
Else
	IniWrite, ERROR , %A_MyDocuments%\%ScriptName%\build.ini,build,PluginPath

IniWrite, 1, %A_MyDocuments%\%ScriptName%\build.ini, build, ReloadVar
IniWrite, 1, %A_MyDocuments%\%ScriptName%\settings.ini, settings, PluginSwitch
ExitApp
return