; -----------AutoExecute------------
IfExist, C:\Program Files\Rainmeter\Rainmeter.exe
Run, C:\Program Files\Rainmeter\Rainmeter.exe
return

F22::
	GoSub LockNow
return

!S::
	Suspend, Permit
	GoSub SuspendScriptToggle
return

~SC027::RapidHotkey("coding", 2, 0.2, 1) ; semicolon
coding:
	Send {End}
	Send {;}
return


#If WinActive( "ahk_exe chrome.exe" ) && !isWindowFullScreen( "A" )

	F3::
	Send {Browser_back}
	return

#If

#If WinActive( "ahk_exe Messenger for Desktop.exe")

LAlt::
	GoSub WinMin
return

#If

RAlt::
	zfont=12
	amultiplier=1
	guiw:=704*amultiplier
	guih:=45
	buth:=(guih)/2-15
	butw:=(guiw)/4
	WSTog := !WSTog
	websearchvar=
	If !WSTog{
	SetTimer, CheckGoogleSearch, Off
	sleep 10
	FadeOut(FastGoogle)
		Gui, FastGoogle:Destroy
		return
	}

	Gui, FastGoogle:New, +hwndFastGoogle
	Gui, -Border -Caption +AlwaysOnTop +LastFound +ToolWindow
	Gui, Color,1e1e1e, 333333
	Gui, Font, w700 s%zfont% cD0D0D0, Segoe UI Black

	Gui, Add, Progress, % "x-1 y-1 w" guiw " h22 Background333333 Disabled hwndHPROG"

	Gui, Add, Edit, % "x0 y17 w" guiw-47 " h25 hwndWebSearch vwebsearchvar -E0x200 +Center -VScroll", %websearchvar%

	Gui, Add, Button, % "x+0 h25 w47 gFastGoogleSearch hwndSearchBut1 +Default", Go
	Opt1 := [6, 0x333333, 0x333333, 0x008383]
	Opt2 := [ , 0x333333, 0x333333, 0xffffff]
	Opt4 := [0, 0xC0A0A0A0, , 0xC0606000]
	ImageButton.Create(SearchBut1, Opt1, Opt2, "", Opt4)
	WinSet, Transparent, 0
	Gui, Show, y-14 h%guih% w%guiw%, .devRS Google Search

	wanimation=0
	animationhalf=330	
	counttimer=0
	transvalue=45
	SetTimer, animationtest, 0

	SetTimer, CheckGoogleSearch, 50
return

#If	WinActive( "ahk_id" . FastGoogle )
	ESC::
	FadeOut(FastGoogle)
	return
#If

	
return
SC045:: 	; pause/break button deletes the previous word 
	Send ^{Left}
	Send ^{Delete}
return

~LWin Up::
	If (A_PriorKey <> "LWin")
	return
	else{
		Send {Ctrl}
		sleep 50
		Send {Ctrl}
	}
return

; ------------------------------------------------------------------ Temporary ------------------------------------------------------------------------

; ------------------------------------------------------------------- LABELS --------------------------------------------------------------------------


FastGoogleSearch:
	Gui, Submit, NoHide
	if websearchvar!=""
	{
		WSTog:=!WSTog
		SetTimer, CheckGoogleSearch, Off
		websearchvar:="https://www.google.bg/search?q=" websearchvar
		Run, %websearchvar%,, UseErrorLevel
		websearchvar=
	}
	FadeOut(FastGoogle)
	Gui, FastGoogle:Destroy
return

CheckGoogleSearch:
	IfWinNotActive, ahk_id %FastGoogle%
	{
	WSTog:=!WSTog
	FadeOut(FastGoogle)
	Gui, FastGoogle:Destroy
	SetTimer, CheckGoogleSearch, Off
	sleep 10
	}
return

animationtest:
	wanimation:=wanimation+44
	if transvalue<230
	transvalue:=transvalue+22
	if (animationhalf-22)>0
		animationhalf:=animationhalf-22
	else
		animationhalf=0
	WinSet, Region, %animationhalf%-0 w%wanimation% h%guih% r18-18, ahk_id %FastGoogle%
	WinSet, Transparent, %transvalue%, ahk_id %FastGoogle%
	counttimer:=counttimer+1
	if counttimer=16
	SetTimer, animationtest, Off
return