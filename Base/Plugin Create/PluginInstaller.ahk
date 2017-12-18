; Installs the plugin in the user's program directory
; Just compile, zip and send

#NoEnv
#NoTrayIcon
SendMode Input
SetWorkingDir %A_ScriptDir% 

FileInstall, Plugin.ahk, %A_MyDocuments%\.devRS\Plugin.ahk

If(A_IsCompiled)
	IniWrite, %A_ScriptFullPath%, %A_MyDocuments%\.devRS\settings.ini, settings, PluginPath
Else
	IniWrite, ERROR , %A_MyDocuments%\.devRS\settings.ini,settings,PluginPath

IniWrite, 1, %A_MyDocuments%\.devRS\settings.ini, settings, ReloadVar
IniWrite, 1, %A_MyDocuments%\.devRS\settings.ini, settings, PluginSwitch
ExitApp
return