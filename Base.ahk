#NoEnv
#NoTrayIcon
#SingleInstance IGNORE
#WinActivateForce
#Persistent
#MaxHotkeysPerInterval 99000000
#HotkeyInterval 99000000
#KeyHistory
FileVersion=2.3.5
ScriptName=Devers
StartTime:=A_TickCount
IfNotExist, %A_MyDocuments%\%ScriptName%
FileCreateDir, %A_MyDocuments%\%ScriptName%
SetWorkingDir, %A_MyDocuments%\%ScriptName%
IfExist, settings.ini
{
	IniRead, InstalledFileVersion, build.ini, build, FileVersion, 1.0
	If % VersionCompare(FileVersion, InstalledFileVersion)=1
		GoSub UpdateFiles
}
#Include %A_ScriptDir%
GoSub Defaults
GoSub MenuInit
GoSub RunScript
return

;=====------======------=====------======------=====------======------=====------======------=====------======------=====------======------
;=====------======------=====------======------=====------======--MAIN FUNCTION--======------======------=====------======------=====------
;=====------======------=====------======------=====------======------=====------======------=====------======------=====------======------

RunScript: ; This is the beginning of the script
GoSub Config
GoSub Volume
IniRead, LockPwHash, settings.ini, settings, LockPwHash ; keep in a separate thread with passwordhash decryption
if LockPwHash!=ERROR || LockPwHash ; keep in a separate thread with passwordhash decryption
LockPw:=Crypt.Encrypt.StrDecrypt(LockPwHash,"KktgC3l0wR",7,3) ; keep in a separate thread with passwordhash decryption
SetTimer, CheckBreakLoop, -2500
SetTimer, RestartCheck, 800
SetTimer, AllowUpdateCheckInMenu, 3600000
IfExist, settings.ini
{
	If RunAsAdmin && !LockAfterRestart
		RunAsAdmin()

	If Reloaded=1
	{
		RSNotify("Reloaded")
		IniDelete, settings.ini, settings, Reloaded
	}
	If (CreateATask=1 || !FirstRun) && (A_IsCompiled) && (A_IsAdmin)
	{
			Run, %comspec% /c SchTasks /SC ONLOGON /F /Create /TN RSRunScript /RL HIGHEST /TR "%A_ScriptDir%\%ScriptName%".exe, , HIDE
			IniWrite, 0, settings.ini, settings, CreateATask
	}
	
	OnExit, ExitAppL

	IfNotExist, Libraries
		FileCreateDir, Libraries

	FileInstall, Libraries/Functions.lib, %A_MyDocuments%\%ScriptName%\Libraries\Functions.lib, 0
	FileInstall, Libraries/Packages.lib, %A_MyDocuments%\%ScriptName%\Libraries\Packages.lib, 0
	FileInstall, Libraries/Gdip_All.lib, %A_MyDocuments%\%ScriptName%\Libraries\Gdip_All.lib, 0
	FileInstall, Base/CustomCommands.ahk, %A_MyDocuments%\%ScriptName%\CustomCommands.ahk, 0
	FileInstall, Base/ExtensionsManager, %A_MyDocuments%\%ScriptName%\ExtensionsManager, 0

	; How to use the plugin system :
	; Just create a file with the extension .ahk in the Extensions directory and it will run next time you restart the script
	IfExist, Extensions/*.ahk
	{
		RunningPlugins := []
		Loop, Files, Extensions/*.ahk
		{
			SplitPath, A_LoopFileLongPath,,,, PluginName

			If RegExMatch(PluginName, "\W")
			{
				PluginName:=StrReplace(PluginName, A_Space, "_")
				PluginName := RegExReplace(PluginName, "\W")
				FileMove, %A_LoopFileLongPath%, %PluginName%.ahk, 1
			}

			IniRead, PluginState, settings.ini, plugins, PluginState%PluginName%, 1
			If(PluginState=1)
			{
				Run, "%A_MyDocuments%\%ScriptName%\ExtensionsManager" "%A_MyDocuments%\%ScriptName%\Extensions\%PluginName%.ahk",,, PID%PluginName% ; PluginID is the PID for the process. Required when you need to close/uninstall the program.
				RunningPlugins.Push("PID" PluginName)
			}
		}
	}

	GoSub InstallFiles

	If PluginInstalled=1
	{
		RSNotify("Plugin Added")
		IniDelete, settings.ini, plugins, PluginInstalled
	}
	If LockAfterRestart=1
	{
		GoSub Lockscreen
		If RunAsAdmin
			RunAsAdminAfterLock:=1
	}

	If hotkeysInFullscreen=2
		SetTimer, HotkeysSuspendCheck, 500

	LogTime(0)
	GoSub ButtonsLabel
	SetTimer, SetupGuiPreloading, 2700000
		
	If AfterInstallation=1
	{
		GoSub ScriptFunctions
	}
	Else if CreateExtensionAfterReload=1
	{
		IniWrite, 0, settings.ini, settings, CreateExtensionAfterReload
		GoSub CreateExtensionGUI
	}
}
IfNotExist, settings.ini
	Gosub Installation
return

Installation:
	FirstRun:=true
	GoSub Initiation
	FileCreateDir, %A_MyDocuments%\%ScriptName%
	SetWorkingDir, %A_MyDocuments%\%ScriptName%
	RSNotify("Installing",,750)
	sleep 1350
	GoSub InstallFiles
	Menu, Tray, Icon, Assets\TrayIcon.ico
	Menu, Tray, Icon
	GoSub NotAnAdmin ; lite installation override
	;GoSub AdminPrompt
return

InstallFiles:
	IfNotExist, ExtensionsManager
		FileInstall, Base\ExtensionsManager, %A_MyDocuments%\%ScriptName%\ExtensionsManager, 1

	IfNotExist, Assets
		FileCreateDir, Assets
	IfNotExist, Assets\Animation.mp4
		FileInstall, Base\Animation.mp4, %A_MyDocuments%\%ScriptName%\Assets\Animation.mp4, 1
	IfNotExist, Assets\TrayIconSuspended.ico
		FileInstall, Base\TrayIconSuspended.ico, %A_MyDocuments%\%ScriptName%\Assets\TrayIconSuspended.ico, 1
	IfNotExist, Assets\TrayIcon.ico
		FileInstall, Base\TrayIcon.ico, %A_MyDocuments%\%ScriptName%\Assets\TrayIcon.ico, 1
	IfNotExist, Assets\Tip_small.png
		FileInstall, Base\Tip_small.png, %A_MyDocuments%\%ScriptName%\Assets\Tip_small.png, 1
	IfNotExist, Assets\Tip_medium.png
		FileInstall, Base\Tip_medium.png, %A_MyDocuments%\%ScriptName%\Assets\Tip_medium.png, 1
	IfNotExist, Assets\Tip_large.png
		FileInstall, Base\Tip_large.png, %A_MyDocuments%\%ScriptName%\Assets\Tip_large.png, 1
	IfNotExist, Assets\SinglePlugin.ico
		FileInstall, Base\SinglePlugin.ico, %A_MyDocuments%\%ScriptName%\Assets\SinglePlugin.ico, 1
		
		
	IfNotExist, Libraries
		FileCreateDir, Libraries

	FileInstall, Libraries/Functions.lib, %A_MyDocuments%\%ScriptName%\Libraries\Functions.lib, 0
	FileInstall, Libraries/Packages.lib, %A_MyDocuments%\%ScriptName%\Libraries\Packages.lib, 0
	FileInstall, Libraries/Gdip_All.lib, %A_MyDocuments%\%ScriptName%\Libraries\Gdip_All.lib, 0
	FileInstall, Base/CustomCommands.ahk, %A_MyDocuments%\%ScriptName%\CustomCommands.ahk, 0
	FileInstall, Base/ExtensionsManager, %A_MyDocuments%\%ScriptName%\ExtensionsManager, 0

	IniWrite, %FileVersion%, build.ini, build, FileVersion
return

;=====------======------=====------======------=====------======------=====------======------=====------======------=====------======------
;=====------======------=====------======------=====------======------LABELS END-======------=====------======------=====------======------
;=====------======------=====------======------=====------======------=====------======------=====------======------=====------======------

;--------------------------------------------------------------------------------------------------------------
#Include Libraries/Config.lib
#Include Libraries/Functions.lib
#Include Libraries/Hotkeys.lib
#Include Libraries/Labels.lib
#Include Libraries/Menu.lib
#Include Libraries/Packages.lib
#Include Libraries/Protection.lib
#Include Libraries/Web.lib
#Include Libraries/Tip.lib
#Include Libraries/Updates.lib
#Include Libraries/Volume.lib