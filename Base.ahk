#NoEnv
#NoTrayIcon
#SingleInstance IGNORE
#WinActivateForce
#Persistent
#MaxHotkeysPerInterval 99000000
#HotkeyInterval 99000000
#KeyHistory
FileEncoding, UTF-8
FileVersion=2.0.1.5
SetTimer, UpdateCheck, 200
ListLines Off
Process, Priority, , H
SetBatchLines, -1
SetTitleMatchMode 2
SetTitleMatchMode Fast
SetKeyDelay, -1, -1, Play
SetMouseDelay, -1
Enabled := ComObjError(false)
ComObjError(false)
SetWinDelay, 0
SetControlDelay, 0
SendMode Event
ScriptName=.devRS
global logging
global dpi:=DpiFactor()
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
DetectHiddenWindows, on
#Include %A_ScriptDir%
GoSub MenuInit
GoSub RunScript
#Include *i Libraries/developer.lib
return


;=====------======------=====------======------=====------======------======------======------=====------======------=====------======------
;=====------======------=====------======------=====------======------======------======------=====------======------=====------======------
;=====------======------=====------======------=====------======------======------======------=====------======------=====------======------
;=====------======------=====------======------=====------======-------KEYS-------======------=====------======------=====------======------
;=====------======------=====------======------=====------======------======------======------=====------======------=====------======------
;=====------======------=====------======------=====------======------======------======------=====------======------=====------======------
;=====------======------=====------======------=====------======------======------======------=====------======------=====------======------

#If !isWindowFullscreen( "A" ) or SuspendFS=1 or WinActive("ahk_exe explorer.exe")

F4::
	ChoosingWebsite:=true
	GoSub RSWeb
return

F4 & 1::
Run, %ws1%
return

F4 & 2::
Run, %ws2%
return

F4 & 3::
Run, %ws3%
return

F4 & 4::
Run, %ws4%
return

F4 & 5::
Run, %ws5%
return

F4 & 6::
Run, %ws6%
return

F4 & 7::
Run, %ws7%
return

F4 & 8::
Run, %ws8%
return

~F6 & F9::
	Gosub Reinstall
return

~$LAlt Up::
	GetKeyState, state, Shift
	If state=D
	{
		Send {LAlt Down}{LShift Up}{LAlt Up}
		return
	}
	KeyWait, LAlt, U
	KeyWait, LAlt, D, T0.2
	If (ErrorLevel = 0) && A_PriorKey = "LAlt"
	IfWinNotActive, ahk_class WorkerW
	WinMinimize, A
return

~CapsLock::RapidHotkey("email", 2, 0.2, 1)
email:
	SendInput {Raw}%email%
return

#CapsLock::RapidHotkey("pw", 2, 0.2, 1)
pw:
	If password
	{
		If !Authorized
		{
			GoSub Authorization
			return
		}
		SendInput {Raw}%password%	
	}
return

~!SC013::
	If (!A_IsCompiled)
	{
		IntentReload:=true
		Reload
	}
return

#If

F9::
	GoSub playpause
return

F11::
	GoSub PrevSong
return

F12::
	GoSub NextSong
return

PgUp::
	Suspend, Permit
	GoSub vol_up
return

PgDn::
	Suspend, Permit
	GoSub vol_down
return

#If (A_IsCompiled)
~#!SC013::
	IntentReload:=true
	Reload
return
#If

~#!SC01F:: ; Win+Alt+S Suspends the script
	Suspend, Permit
	GoSub SuspendScriptToggle
return

LockLabel:
If (keysvar="" || keysvar="None" || keysvar="ERROR")
keysvar=None

#If (keysvar!="None") && !WinActive( "ahk_id" . ProtectionSettings )
	Hotkey, If, (keysvar!="None") && !WinActive( "ahk_id" . ProtectionSettings )
	If (keysvar!="None")
	{
		Hotkey, %keysvar%, LockNow
		Hotkey, %keysvar%, LockNow, On
	}
return

#If (ItsLocked = 1)
	RButton::Return
	LAlt::Return
	RAlt::Return
	F1::
		GoSub fadeinclock
	return
	F2::Return
	F3::Return
	F4::Return
	F5::Return
	F6::Return
	F7::Return
	F8::Return
	F10::Return
	CapsLock::Return
	LCtrl::Return
	RCtrl::Return
	Esc::Return
	Up::Return
	Down::Return
	Left::Return
	Right::Return
	Pause::Return
	LWin::return
	RWin::Return
	!F4::Return
	!SC013::Return ; Win+R
	#SC020::Return ; Win+ D
	!Tab::Return
	NumpadSub:: ; Initiates developer lock if the username is riyusso and its not locked by the developer yet.
	Suspend, Permit
	IniRead, username, settings.ini, settings, username
	if (username="Riyusso" && !devlock)
	{
		pwcover=
		Formula=0
		GuiControl, ProtectionAgainstZombies:Hide, LTxt
		GuiControl, ProtectionAgainstZombies:Show, TATxt
		GuiControl,  ProtectionAgainstZombies:, TATxt, Developer Lock.
		devlock:=True
	}
	return
	NumPad1::
	Suspend, Permit
	GoSub plus1
	return
	NumPad2::
	Suspend, Permit
	GoSub plus2
	return
	NumPad3::
	Suspend, Permit
	GoSub plus3
	return
	NumPad4::
	Suspend, Permit
	GoSub plus4
	return
	NumPad5::
	Suspend, Permit
	GoSub plus5
	return
	NumPad6::
	Suspend, Permit
	GoSub plus6
	return
	NumPad7::
	Suspend, Permit
	GoSub plus7
	return
	NumPad8::
	Suspend, Permit
	GoSub plus8
	return
	NumPad9::
	Suspend, Permit
	GoSub plus9
	return
	NumPad0::
	Suspend, Permit
	GoSub plus0
	return
	Delete::
	Suspend, Permit
	GoSub FormulaNull
	return
	NumpadDot::
	Suspend, Permit
	GoSub FormulaNull
	return
	~Enter::
	~NumpadEnter::
	If !Disablekeys
	{
		Suspend, Permit
		GoSub TryPw
	}
	return
	SC00E::
	Suspend, Permit
	GoSub FormulaNull
	return
#If

#If (VolumeTR=1)
	WheelUp::
	GoSub vol_up
	return
	WheelDown::
	GoSub vol_down
	return
#If

#If (ChoosingWebsite=1) && !WinActive("ahk_id" . WebL) && ItsLocked!=1
	1::
	GoSub ws1
	return
	2::
	GoSub ws2
	return
	3::
	GoSub ws3
	return
	4::
	GoSub ws4
	return
	5::
	GoSub ws5
	return
	6::
	GoSub ws6
	return
	7::
	GoSub ws7
	return
	8::
	GoSub ws8
	return
	~LButton Up::
			MouseGetPos, , , id, control
			if (id!=WebL && id!=WebEdit)
			SetTimer, WebLGuiEscape, -100
	return
	SC029:: 	; While RSWeb is opened, press the ` key to focus the search bar.
	WinActivate, ahk_id %WebL%
	return
	Esc::
	SetTimer, WebLGuiEscape, -100
	return
#If

#If (OopsMistake)
LALt::
Send +{Home}
Send {Delete}
return
#If

#If (DefaultFader=1)
~LButton Up::
MouseGetPos, , , id, control
WinGetClass, class, ahk_id %id%
if (class!="AutoHotkeyGUI" && class!="#32769")
	GoSub ExitDefMenu
return
~RButton Up::
MouseGetPos, , , id, control
WinGetClass, class, ahk_id %id%
if (class!="AutoHotkeyGUI")
GoSub ExitDefMenu
return
#If

;=====------======------=====------======------=====------======------=====------======------=====------======------=====------======------
;=====------======------=====------======------=====------======------=====------======------=====------======------=====------======------
;=====------======------=====------======------=====------======------=====------======------=====------======------=====------======------
;=====------======------=====------======------=====------======------=====------======------=====------======------=====------======------
;=====------======------=====------======------=====------======------LABELS-----======------======------=====------======------=====------
;=====------======------=====------======------=====------======------=====------======------=====------======------=====------======------
;=====------======------=====------======------=====------======------=====------======------=====------======------=====------======------
;=====------======------=====------======------=====------======------=====------======------=====------======------=====------======------
;=====------======------=====------======------=====------======------=====------======------=====------======------=====------======------

RunScript: ; This is the beginning of the script
GoSub VolTR
GoSub IniReads
IniRead, LockPwHash, settings.ini, settings, LockPwHash ; keep in a separate thread with passwordhash decryption
if LockPwHash!=ERROR || LockPwHas ; keep in a separate thread with passwordhash decryption
LockPw:=Crypt.Encrypt.StrDecrypt(LockPwHash,"KktgC3l0wR",7,3) ; keep in a separate thread with passwordhash decryption
SetTimer, CheckBreakLoop, -2500
IfExist, settings.ini
{
	If RunAsAdmin && !LockAfterRestart
	RunAsAdmin()

	If Reloaded=1
	{
		If !A_IsCompiled
		RSNotify("Reloaded")
		IniDelete, settings.ini, settings, Reloaded
	}
	
	WinSet, Transparent, %TransparentStartMenu%, ahk_class Shell_TrayWnd
	SetTimer, KeepTrans, 12000
	
	OnExit, ExitAppL

	; How to use the plugin system :
	; Just create a file with the extension .ahk in the Script directory and it will run next time you restart the script
	IfExist, *.ahk
	{
		IfNotExist, Extensions
			FileInstall, Base/Extensions, %A_MyDocuments%\%ScriptName%\Extensions, 1

		IfNotExist, Libraries
			FileCreateDir, Libraries
		IfNotExist, %A_WorkingDir%/Libraries/RSNotify.lib
			FileInstall, Libraries/RSNotify.lib, %A_MyDocuments%\%ScriptName%\Libraries\RSNotify.lib, 1
		IfNotExist, %A_WorkingDir%/Libraries/Functions.lib
			FileInstall, Libraries/Functions.lib, %A_MyDocuments%\%ScriptName%\Libraries\Functions.lib, 1
		IfNotExist, %A_WorkingDir%/Libraries/Library.lib
			FileInstall, Libraries/Library.lib, %A_MyDocuments%\%ScriptName%\Libraries\Library.lib, 1
			
		Loop, Files, *.ahk
		{
			SplitPath, A_LoopFileLongPath,,,, PluginName
			IniRead, PluginState, settings.ini, plugins, PluginState%PluginName%, 1
			If(PluginState=1)
				Run, %A_MyDocuments%\%ScriptName%\Extensions %A_LoopFileLongPath%,,, PID%PluginName% ; PluginID is the PID for the process. Required when you need to close/uninstall the program.
		}
	}
	
	GoSub InstallFiles
	GoSub GetLatestVersion
	
	Gosub defaultsettings
	If !LockAfterRestart
	{
		If A_IsCompiled
		SetTimer, RSRunScript, -25
	}
	If LockAfterRestart
	{
		GoSub RSGuard
		If RunAsAdmin
		RunAsAdminAfterLock:=1
	}
	LogTime(0)
	GoSub LockLabel
}
IfNotExist, settings.ini
Gosub Installation
return

Installation:
	FirstRun:=true
	FileCreateDir, %A_MyDocuments%\%ScriptName%
	SetWorkingDir, %A_MyDocuments%\%ScriptName%
	RSNotify("Installing",,750)
	sleep 1350
	GoSub InstallFiles
	Menu, Tray, Icon
	Menu, Tray, Icon, RSIcon.ico
	GoSub AdminPrompt
return

InstallFiles:
	IfNotExist, launcher.exe
		FileInstall, Base/launcher.exe, %A_MyDocuments%\%ScriptName%\launcher.exe, 1
	IfNotExist, segoeui.ttf
		FileInstall, Base/segoeui.ttf, %A_MyDocuments%\%ScriptName%\segoeui.ttf, 1
	IfNotExist, RS.png
		FileInstall, Base/RS.png, %A_MyDocuments%\%ScriptName%\RS.png, 1
	IfNotExist, RSAnimation.mp4
		FileInstall, Base/RSAnimation.mp4, %A_MyDocuments%\%ScriptName%\RSAnimation.mp4, 1
	IfNotExist, RSStopped.ico
		FileInstall, Base/RSStopped.ico, %A_MyDocuments%\%ScriptName%\RSStopped.ico, 1
	IfNotExist, RSIcon.ico
		FileInstall, Base/RSIcon.ico, %A_MyDocuments%\%ScriptName%\RSIcon.ico, 1
	IfNotExist, Base/RSStopped.ico
		FileInstall, Base/RSStopped.ico, %A_MyDocuments%\%ScriptName%\RSStopped.ico, 1
	IfNotExist, Extensions
			FileInstall, Base/Extensions, %A_MyDocuments%\%ScriptName%\Extensions, 1
	IniWrite, %FileVersion%, build.ini, build, FileVersion
return

UpdateFiles:
	FileInstall, Base/launcher.exe, %A_MyDocuments%\%ScriptName%\launcher.exe, 1
	FileInstall, Base/segoeui.ttf, %A_MyDocuments%\%ScriptName%\segoeui.ttf, 1
	FileInstall, Base/RS.png, %A_MyDocuments%\%ScriptName%\RS.png, 1
	FileInstall, Base/RSAnimation.mp4, %A_MyDocuments%\%ScriptName%\RSAnimation.mp4, 1
	FileInstall, Base/RSStopped.ico, %A_MyDocuments%\%ScriptName%\RSStopped.ico, 1
	FileInstall, Base/RSIcon.ico, %A_MyDocuments%\%ScriptName%\RSIcon.ico, 1
	FileInstall, Base/RSStopped.ico, %A_MyDocuments%\%ScriptName%\RSStopped.ico, 1
	FileInstall, Base/Extensions, %A_MyDocuments%\%ScriptName%\Extensions, 1

	IfExist, Runner.exe
		FileDelete, Runner.exe
	GoSub Migrations
	IniWrite, %FileVersion%, build.ini, build, FileVersion
return

Migrations:
	Migration1:
		IniRead, LockPw, settings.ini, settings, LockPw
		If LockPw is Digit
		{
			IniDelete, settings.ini, settings, LockPw
			LockPwHash:=Crypt.Encrypt.StrEncrypt(LockPw,"KktgC3l0wR",7,3)
			IniWrite, %LockPwHash%, settings.ini, settings, LockPwHash
		}
return

;--------------------------------------------------------------------------------------------------------------

RSRunScript:
	logofader=10
	xc:=A_ScreenWidth/2-223
	yc:=A_ScreenHeight/2-261
	RunScript := new GUI()
	RunScript.Color := "black"
	RunScript.SetTransparent("0")
	RunScript.SetStyle("-Caption +AlwaysOnTop -Border +ToolWindow -DPIScale")
	Gui, Add, Picture, x0 y0 w447 h523 vKC0, RS.png
	RunScript.Show("x" xc "y" yc "w447 h523")
	sleep 16
	RunScript.Aero.Set(500,500,0,0)
	Loop 25
	{
		RunScript.SetTransparent(logofader)
		sleep 16
		logofader:=logofader+10
	}
	SetTimer, FadeRSOut, -100
return

FadeRSOut:
sleep 350
GuiControl, Hide, MC0
logofader=250
Loop 25
{
	RunScript.SetTransparent(logofader)
	sleep 16
	logofader:=logofader-10
}
RunScript.Destroy()
If CreateATask=1
{
	If A_IsCompiled
	Run, %comspec% /c SchTasks /SC ONLOGON /F /Create /TN RSRunScript /RL HIGHEST /TR "%A_ScriptDir%\launcher.exe, , HIDE
	IniWrite, 0, settings.ini, settings, CreateATask
}
return

;--------------------------------------------------------------------------------------------------------------

defaultsettings:
	OSVer := GetOSVersion()
	DestroyEnded=1
	anvar = %A_MyDocuments%\%ScriptName%\rsanimation.mp4 ; location of gif you want to show
	html := "<html>`n<title>whateverrrr</title>`n<body bgcolor=black>`n<center>'n<img src=""" anvar """ width=""" awsize """ height=""" ahsize """>'n</center>`n</body>`n</html>"
	Formula=0
	ItsMeHaha=0
	vh:=A_ScreenHeight-92
	musique=0
	AlreadyLogged=0
;	SetTimer, LabelCheckTrigger, 200 ; if needed to recognise if particular windows are open
	idletimer=1000
	transitionended=1
	LB_SETCURSEL := 0x186
	CB_SETCURSEL := 0x14E
	Red   := "FF0000"
	Green := "00C000"
	Blue  := "0000FF"
	Pink  := "FF20FF"
	darkerc=D0D0D0
	lightc=F6F6F6
	idleseconds:=1000*(seconds)
	ItsLocked=0
return

Initiation:
	email=
	breakloop=2
	LockPw=
	seconds=120
	ClockWanted=1
	StartWithWindows=1
	keysvar=ScrollLock
	TransparentStartMenu=255
	CheckPeriod = 150
	lockkey=ScrollLock
	SuspendFS=1
	AfterFS=1
	AfterWU=2
	logging=2

	ws1=www.facebook.com
	ws2=www.youtube.com
	ws3=www.reddit.com
	ws4=www.9gag.com
	ws5=https://www.twitch.tv
	ws6=http://zamunda.net/bananas
	ws7=www.thepiratebay.org
	ws8=https://alpha.wallhaven.cc/

	WebNames=Facebook|YouTube|Reddit|9Gag|Twitch|Zamunda|PirateBay|WallHaven
	IniWrite, %WebNames%, settings.ini, Web, WebNames

	Loop, 8
	{
		IniWrite, % ws%A_Index% , settings.ini, Web, ws%A_Index%
	}

	IniWrite, %lockkey%, settings.ini, settings, lockkey
	IniWrite, %LockPwHash%, settings.ini, settings, LockPwHash
	IniWrite, %seconds%, settings.ini, settings, seconds
	IniWrite, %BreakLoop%, settings.ini, settings, breakloop
	IniWrite, %email%, settings.ini, settings, email
	IniWrite, %passwordhash%, settings.ini, settings, passwordhash
	IniWrite, %TransparentStartMenu%, settings.ini, settings, TransparentStartMenu
	IniWrite, %CheckPeriod%, settings.ini, settings, CheckPeriod
	IniWrite, %StartWithWindows%, settings.ini, settings, StartWithWindows
	IniWrite, %AfterFS%, settings.ini, settings, AfterFS
	IniWrite, %AfterWU%, settings.ini, settings, AfterWU
	IniWrite, %ClockWanted%, settings.ini, settings, ClockWanted
	IniWrite, %logging%, settings.ini, settings, LoggingLockTimes
	IniWrite, %SuspendFS%, settings.ini, settings, SuspendFS

	IniRead, LockPwHash, settings.ini, settings, LockPwHash
	IniRead, seconds, settings.ini, settings, seconds
	IniRead, BreakLoop, settings.ini, settings, BreakLoop
	IniRead, email, settings.ini, settings, email
	IniRead, passwordhash, settings.ini, settings, passwordhash
	IniRead, TransparentStartMenu, settings.ini, settings, TransparentStartMenu
	IniRead, CheckPeriod, settings.ini, settings, CheckPeriod
	IniRead, StartWithWindows, settings.ini, settings, StartWithWindows
	IniRead, AfterFS, settings.ini, settings, AfterFS
	IniRead, AfterWU, settings.ini, settings, AfterWU
	IniRead, logging, settings.ini, settings, LoggingLockTimes
	IniRead, ClockWanted, settings.ini, settings, ClockWanted

	GoSub defaultsettings
return

IniReads:
	IniRead, RunAsAdmin, settings.ini, settings, RunAsAdmin, 0
	IniRead, LockAfterRestart, settings.ini, settings, LockAfterRestart, 0
	IniRead, keysvar, settings.ini, settings, lockkey

	IniRead, ClockWanted, settings.ini, settings, ClockWanted
	IniRead, BreakLoop, settings.ini, settings, BreakLoop
	IniRead, email, settings.ini, settings, email
	IniRead, seconds, settings.ini, settings, seconds
	IniRead, StartWithWindows, settings.ini, settings, StartWithWindows
	IniRead, logging, settings.ini, settings, LoggingLockTimes
	IniRead, AfterFS, settings.ini, settings, AfterFS
	IniRead, AfterWU, settings.ini, settings, AfterWU
	IniRead, CreateATask, settings.ini, settings, CreateATask
	IniRead, TransparentStartMenu, settings.ini, settings, TransparentStartMenu, 255
	IniRead, SuspendFS, settings.ini, settings, SuspendFS, 1
	IniRead, Reloaded, settings.ini, settings, Reloaded, 0

	IniRead, passwordhash, settings.ini, settings, passwordhash ; keep in a separate thread with lockpwhash decryption
	if passwordhash!=ERROR || passwordhash ; keep in a separate thread with lockpwhash decryption
	password:=Crypt.Encrypt.StrDecrypt(passwordhash,"KktgC3l0wR",7,3) ; keep in a separate thread with lockpwhash decryption

	Loop, 8
	{
		IniRead, ws%A_Index% , settings.ini, Web, ws%A_Index%
	}

return

;=====------======------=====------======------=====------======------=====------======------=====------======------=====------======------
;=====------======------=====------======------=====------======------LABELS END-======------=====------======------=====------======------
;=====------======------=====------======------=====------======------=====------======------=====------======------=====------======------

;--------------------------------------------------------------------------------------------------------------
#Include Libraries/Functions.lib
#Include Libraries/Library.lib
#Include Libraries/RandomLabels.lib
#Include Libraries/updater.lib
#Include Libraries/RSNotify.lib
#Include Libraries/RSGuard.lib
#Include Libraries/RSWeb.lib
#Include Libraries/Menu.lib
#Include Libraries/Voltr.lib