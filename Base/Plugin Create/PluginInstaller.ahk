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
		MsgBox, 4, Replace %PluginName%?, The plugin is already installed, do you want to replace it?

	IfMsgBox No
	{
		ExitApp
		return
	}

	FileInstall, Plugin.ahk, %A_MyDocuments%\%ScriptName%\%PluginName%.ahk, 1

	If(A_IsCompiled)
		IniWrite, %A_ScriptFullPath%, %A_MyDocuments%\%ScriptName%\build.ini, build, PluginPath
	Else
		IniWrite, ERROR , %A_MyDocuments%\%ScriptName%\build.ini,build,PluginPath

	IniWrite, 1, %A_MyDocuments%\%ScriptName%\build.ini, build, ReloadVar
}
else
{
	MsgBox, .devRS is not installed on your computer.
}

ExitApp
return