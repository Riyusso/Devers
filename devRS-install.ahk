#NoEnv
#NoTrayIcon
Version=1.41
SendMode Input
ScriptName=.devRS

IfExist, %A_MyDocuments%\%ScriptName%\%ScriptName%.exe
{
	SetWorkingDir %A_MyDocuments%\%scriptname%
	IniRead, CurrentVersion, build.ini, build, Version
	IfNotExist, %A_MyDocuments%\%ScriptName%\build.ini
	CurrentVersion=1.0
	If (Version>CurrentVersion){
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

RSNotify(Text, controlwidth=0, fontsize=13, TitleSpace=0, Title="", NewY=9, Timed=1250) ;RSNotify
{
	global DontPause=1
	global SmartFade=0
	Gui, RSNotify:Destroy
	Gui,RSNotify:New, +hwndRSNotify
	Gui, +LastFound +ToolWindow
	WinSet, Transparent, 0
	Gui, Color, 008383
	Gui, Margin, 0, 0
	Gui, Font, s10 Bold w640, Verdana
	whc:=47

	If controlwidth=0
	{
	widthcontrolled:=false
	controlwidth=105
	}
	Else
	widthcontrolled:=true

	If (StrLen(Text)>9) && !widthcontrolled
	controlwidth:=controlwidth+((StrLen(Text)-9)*10)+10

	vhc:=A_ScreenHeight-100

	If TitleSpace
	{
	whc=48
	NewY=19
	controlwidth+=6
	Gui, Add, Progress, % "x-1 y-1 w" controlwidth " h22 Background1F2326 Disabled hwndHPROG"
	Control, ExStyle, -0x20000, , ahk_id %HPROG% ; propably only needed on Win XP
	Gui, Add, Text, % "x0 y1 w" controlwidth " r1 BackgroundTrans Center 0x200 gGuiMove c248a96", %Title%
	}
	averagex:=A_ScreenWidth-130-(controlwidth/2)
	Gui, Font, s%fontsize% w720, Verdana
	Gui, -Border -Caption +AlwaysOnTop +ToolWindow +E0x20
	Gui, Add, Text,cffffff x0 w%controlwidth% y%NewY% +Center, %Text%
	WinSet, Region, 0-0 w%controlwidth% h%whc% r3-3
	Gui, Show, x%averagex% y%vhc% h%whc% w%controlwidth% NoActivate
	GoSub SmartAppear
	SetTimer, SmartFade, -%Timed%
return
}

SmartAppear:
	SmartFade:=SmartFade+8
	WinSet, Transparent, %SmartFade%, ahk_id %RSNotify%
	SetTimer, SmartAppear, -8
	If (SmartFade>204)
	SetTimer, SmartAppear, Off
return

SmartFade:
		SmartFade:=SmartFade-8
		WinSet, Transparent, %SmartFade%, ahk_id %RSNotify%
		SetTimer, SmartFade, -8
		If (SmartFade<8){
			SetTimer, SmartFade, Off
			Gui, RSNotify:Destroy
			If TryPause
			Pause, On
			DontPause=0
		}
return
