; Installs the plugin in the user's program directory
; Just compile, zip and send
; Don't forget to rename the PluginInstaller.exe to whatever the plugin name is going to be.

#NoEnv
#NoTrayIcon
SendMode Input
SetWorkingDir %A_ScriptDir% 
ScriptName=.devRS

IfExist, %A_MyDocuments%\%ScriptName%\settings.ini
{
	SplitPath, A_ScriptName,,,, PluginName
	IfExist, %A_MyDocuments%\%ScriptName%\%PluginName%.ahk
		MsgBox, 4, Replace %PluginName%?, The plugin is already installed, do you want to reinstall it?

	IfMsgBox No
	{
		ExitApp
		return
	}

	IniDelete, %A_MyDocuments%\%ScriptName%\plugin-settings.ini, %PluginName%
	FileInstall, Plugin.ahk, %A_MyDocuments%\%ScriptName%\%PluginName%.ahk, 1

	IniWrite, 1, %A_MyDocuments%\%ScriptName%\build.ini, build, ReloadVar
	IniWrite, 1, %A_MyDocuments%\%ScriptName%\settings.ini, plugins, PluginInstalled
}
else
{
	MsgBox, .devRS is not installed on your computer.
}

ExitApp
return