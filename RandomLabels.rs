TaskBarSet:
	WinSet, Transparent, %TransparentStartMenu%, ahk_class Shell_TrayWnd
return

WarningGUI:
	Width :=210
	Gui, WarningGUI:New, +hwndWarningGUI
	Gui, +LastFound +ToolWindow
	WinSet, Transparent, 0
	Gui, Color, 2e2e2e
	Gui, Margin, 0, 0
	Gui, Font, s8 cFFFFFF Bold, Tahoma
	Gui, Add, Progress, % "x-1 y-1 w" (Width+2) " h31 Background2e2e2e Disabled hwndHPROG"
	Control, ExStyle, -0x20000, , ahk_id %HPROG% ; propably only needed on Win XP
	Gui, Add, Text, % "x0 y28 w" Width " r1 BackgroundTrans Center 0x200 gGuiFade cD0D0D0", Password needs to be a number.
	Gui, Add, Text, % "x+1 h46 vP"
	GuiControlGet, P, Pos
	H := PY + PH
	Gui, -Caption
	WinSet, Region, 0-0 w%Width% h%H% r12-12
	Gui, Show, % "w" Width  , Warning
	FadeIn(WarningGUI)
	SetTimer, FadeOutWarning, -1800
return
 
FadeOutWarning:
	FadeOut(WarningGUI)
return

PrInfo:
	Width :=330
	Gui, PrInfo:New, +hwndPrInfo
	Gui, +LastFound +ToolWindow
	WinSet, Transparent, 0
	Gui, Color, 2e2e2e
	Gui, Margin, 0, 0
	Gui, Font, s11 cFFFFFF Bold, Tahoma
	Gui, Add, Progress, % "x-1 y-1 w" (Width+2) " h31 Background2e2e2e Disabled hwndHPROG"
	Control, ExStyle, -0x20000, , ahk_id %HPROG% ; propably only needed on Win XP
	Gui, Add, Text, % "x0 y16 w" Width " r1 BackgroundTrans Center 0x200 gGuiMove cD0D0D0", RS-Guard is designed to protect your PC.
	Gui, Add, Text, % "x0 y+4 w" Width " r1 BackgroundTrans  Center 0x200 gGuiMove cD0D0D0", It is going to lock the computer after 
	Gui, Add, Text, % "x0 y+4 w" Width " r1 BackgroundTrans  Center 0x200 gGuiMove cD0D0D0", the amount of time you have set.
		Gui, Font, s11 cFFFFFF Bold, Tahoma
	Gui, Add, Text, % "x0 y+22 w" Width " r1 BackgroundTrans Center 0x200 gGuiMove cD0D0D0",  --- How to use it ---
		Gui, Font, s9 cFFFFFF Bold, Tahoma
	Gui, Add, Text, % "x0 y+4 w" Width " r1 BackgroundTrans Center 0x200 gGuiMove cD0D0D0",  Set a password.
	Gui, Add, Text, % "x0 y+4 w" Width " r1 BackgroundTrans Center 0x200 gGuiMove cD0D0D0",  Wait or press the lock button.
			Gui, Font, s11 cFFFFFF Bold, Tahoma
	Gui, Add, Text, % "x0 y+22 w" Width " r1 BackgroundTrans  Center 0x200 gGuiMove cD0D0D0", --- Requirements ---
		Gui, Font, s9 cFFFFFF Bold, Tahoma		
	Gui, Add, Text, % "x0 y+4 w" Width " r1 BackgroundTrans  Center 0x200 gGuiMove cD0D0D0", The password needs to be a number. 
	Gui, Add, Text, % "x0 y+4 w" Width " r1 BackgroundTrans  Center 0x200 gGuiMove cD0D0D0", You MUST set seconds and a password.
			Gui, Font, s11 cFFFFFF Bold, Tahoma
	Gui, Add, Text, % "x0 y+22 w" Width " r1 BackgroundTrans Center 0x200 gGuiMove cD0D0D0",  --- What some settings do ---
	Gui, Add, Text, % "x0 y+10 w" Width " r1 BackgroundTrans  Center 0x200 gGuiMove cD0D0D0", - Protected/Unprotected Dropdown -
			Gui, Font, s9 cFFFFFF Bold, Tahoma
	Gui, Add, Text, % "x0 y+4 w" Width " r1 BackgroundTrans  Center 0x200 gGuiMove cD0D0D0",  Toggles whether RS-Guard will lock the PC
	Gui, Add, Text, % "x0 y+4 w" Width " r1 BackgroundTrans  Center 0x200 gGuiMove cD0D0D0", after the amount of time or not.
	Gui, Add, Text, % "x0 y+4 w" Width " r1 BackgroundTrans  Center 0x200 gGuiMove cD0D0D0", You can still lock it with the select key
	Gui, Add, Text, % "x0 y+4 w" Width " r1 BackgroundTrans  Center 0x200 gGuiMove cD0D0D0", Note that the F1 button toggles this function.
			Gui, Font, s11 cFFFFFF Bold, Tahoma
	Gui, Add, Text, % "x0 y+10 w" Width " r1 BackgroundTrans  Center 0x200 gGuiMove cD0D0D0", - Lock After Full Screen -
			Gui, Font, s9 cFFFFFF Bold, Tahoma
	Gui, Add, Text, % "x0 y+4 w" Width " r1 BackgroundTrans  Center 0x200 gGuiMove cD0D0D0", This option controls whether the PC
	Gui, Add, Text, % "x0 y+4 w" Width " r1 BackgroundTrans  Center 0x200 gGuiMove cD0D0D0", will lock itself after you exit full screen. 
	Gui, Add, Text, % "x0 y+4 w" Width " r1 BackgroundTrans  Center 0x200 gGuiMove cD0D0D0", This is useful when you are watching a movie.
			Gui, Font, s11 cFFFFFF Bold, Tahoma
	Gui, Add, Text, % "x0 y+10 w" Width " r1 BackgroundTrans  Center 0x200 gGuiMove cD0D0D0", - Clock -
			Gui, Font, s9 cFFFFFF Bold, Tahoma
	Gui, Add, Text, % "x0 y+4 w" Width " r1 BackgroundTrans  Center 0x200 gGuiMove cD0D0D0", Controls whether a clock is displayed
	Gui, Add, Text, % "x0 y+4 w" Width " r1 BackgroundTrans  Center 0x200 gGuiMove cD0D0D0", on the lock screen. 

		Gui, Color, 2e2e2e
		Gui, Font, s11 cFFFFFF Bold, Tahoma

	Gui, Add, Button, % "x" (Width/2)-((Width*0.64)/2) " y+18 w" (Width*0.64) " gdestroyPrInfo hwndButt2 +Center +Default", Got it
	Opt1 := [6, 0x2e2e2e, 0x2e2e2e, "White"]
	Opt2 := [ , 0x2e2e2e, 0x444444, 0xffffff]
	Opt4 := [0, 0xC0A0A0A0, , 0xC0606000]
	ImageButton.Create(Butt2, Opt1, Opt2, "", Opt4)
	
	Gui, Add, Text, % "x+1 h46 vP"
	GuiControlGet, P, Pos
	H := PY + PH
	Gui, -Caption
	WinSet, Region, 0-0 w%Width% h%H% r12-12
	Gui, Show, % "w" Width  , RS-Guard Settings
	FadeIn(PrInfo)
	
return

destroyPrInfo:
	FadeOut(PrInfo)
return

UpdateCheck:
IniRead, ExitVar, build.ini, build, ExitVar
If ExitVar=1
ExitApp
return

SuspendScriptToggle:
Suspend, Toggle
If A_IsSuspended{
Menu, TRAY, Icon, RSStopped.ico,,1
RSNotify("Suspended", 126, 13)
If A_IsPaused
Pause, Off
}
If !A_IsSuspended{
Menu, TRAY, Icon, RSIcon.ico,,1
RSNotify("Released", 126, 13)
If A_IsPaused
Pause, Off
}
return

SwitchFacebookTitle:
	ProgWinTitle6 = Google Chrome
	SetTImer, SwitchBackTitle, -180
	return
	
SwitchBackTitle:
	ProgWinTitle6 = Why so many difficulties?
	SetTimer, SwitchFacebookTitle, -180
return

playpause:
	Send {Media_Play_Pause}
	RSNotify("Play/Pause", 115, 13)
return

stopbutton:
	Send {Media_Stop}
	RSNotify("Stopped", 100, 13)
return

CheckBreakLoop:
If BreakLoop=1
GoSub Protection
return

ws1:
Run, %ws1%
SetTimer, WebLGuiEscape, -100
return

ws2:
Run, %ws2%
SetTimer, WebLGuiEscape, -100
return

ws3:
Run, %ws3%
SetTimer, WebLGuiEscape, -100
return

ws4:
Run, %ws4%
SetTimer, WebLGuiEscape, -100
return

ws5:
Run, %ws5%
SetTimer, WebLGuiEscape, -100
return

ws6:
Run, %ws6%
SetTimer, WebLGuiEscape, -100
return

ws7:
Run, %ws7%
SetTimer, WebLGuiEscape, -100
return

ws8:
Run, %ws8%
SetTimer, WebLGuiEscape, -100
return

plus1:
Formula:= Formula*10+1
GoSub PasswordCover
Gosub UnlockPC
return

plus2:
Formula:= Formula*10+2
GoSub PasswordCover
Gosub UnlockPC
return

plus3:
Formula:= Formula*10+3
GoSub PasswordCover
Gosub UnlockPC
return

plus4:
Formula:= Formula*10+4
GoSub PasswordCover
Gosub UnlockPC
return

plus5:
Formula:= Formula*10+5
GoSub PasswordCover
Gosub UnlockPC
return

plus6:
Formula:= Formula*10+6
GoSub PasswordCover
Gosub UnlockPC
return

plus7:
Formula:= Formula*10+7
GoSub PasswordCover
Gosub UnlockPC
return

plus8:
Formula:= Formula*10+8
GoSub PasswordCover
Gosub UnlockPC
return

plus9:
Formula:= Formula*10+9
GoSub PasswordCover
Gosub UnlockPC
return

plus0:
Formula:= Formula*10+0
GoSub PasswordCover
Gosub UnlockPC
return

MouseIsOver(WinTitle) {
	MouseGetPos,,, Win
	return WinExist(WinTitle . " ahk_id " . Win)
}

vol_up:
	Suspend, Permit
	SoundSet, +2
	gosub, Volume_Show_OSD
return
vol_down:
	Suspend, Permit
	SoundSet, -2
	gosub, Volume_Show_OSD
return

NextSong:
	Send {Media_Next}
	RSNotify("Next", 95, 13)
return

PrevSong:
	Send {Media_Prev}
	RSNotify("Previous", 102, 13)
return

DontDoItLabel:
DontDoItTwice=0
return

GuiClose:
   Gui, Destroy
   CtlColors.Free()
GuiEscape:
	CtlColors.Free()
Return

GuiMove:
   PostMessage, 0xA1, 2
return

GuiFade:
	FadeOut(WarningGUI)
return

;=====------======------=====------======------=====------======------=====------======------=====------======------=====------======------
;=====------======------=====------======------=====------======------TRIGGERS-----======------======------=====------======------=====----
;=====------======------=====------======------=====------======------=====------======------=====------======------=====------======------

LabelCheckTrigger:
  While ( ProgWinTitle%A_Index% != "" && WinTrigger := WinTrigger%A_Index% )
    if ( !ProgRunning%A_Index% != !Win%WinTrigger%( ProgWinTitle := ProgWinTitle%A_Index% ) )
      GoSubSafe( "LabelTriggerO" ( (ProgRunning%A_Index% := !ProgRunning%A_Index%) ? "n" : "ff" ) A_Index )
Return

LabelTriggerOn1:
	If BreakLoop=1
	If SkypeLoop=1
	If SkypeWasOn=0
	{
		If !DontDoItTwice
		GoSub RSGuard
	}
	SkypeWasOn=1
	SetTimer, SkypeActivity, Off
Return

LabelTriggerOff1:
	SetTimer, SkypeActivity, -8000
	Return
	SkypeActivity:
	SkypeWasOn=0
	Return

LabelTriggerOn2:
If BreakLoop=1
If FacebookLoop=1
{
	sURL := GetActiveBrowserURL()
	IfInString, sURL, www.facebook.com
	{
		If FacebookWasOn=0
		{
			If !DontDoItTwice
			GoSub RSGuard
		}
	}
}
FacebookWasOn=1
SetTimer, FacebookActivity, Off
Return

LabelTriggerOff2:
	SetTimer, FacebookActivity, -8000
	Return
	FacebookActivity:
	FacebookWasOn=0
Return

LabelTriggerOn4:
LoginAvailable=1
Return

LabelTriggerOn6:
	sURL := GetActiveBrowserURL()
	If Facebookloop=1
	IfInString, sURL, facebook.com
	{
	WinGetTitle,FBTITLE,A
	IfNotInString, FBTITLE, Protected
	WinSetTitle,A,, %FBTITLE% - Protected Against Zombies
	}
return 



GoSubSafe(mySub)
{
  if IsLabel(mySub)
    GoSub %mySub%
}


KeepTrans:
	IniRead, TransparentStartMenu, settings.ini, settings, TransparentStartMenu, 191
	WinSet, Transparent, %TransparentStartMenu%, ahk_class Shell_TrayWnd
return

;--------------------------------------------------------------------------------------------------------------

; ----------------------------------------------------------------------------------------------------------------------
GuiSize:
   If (A_EventInfo != 1) {
      Gui, %A_Gui%:+LastFound
      WinSet, ReDraw
   }
Return
; ----------------------------------------------------------------------------------------------------------------------
STDRBG:
   GuiControlGet, STDRB1
   CtlColors.Change(RBID1, (STDRB1 ? "Lime" : ""), "006000")
   CtlColors.Change(RBID2, (STDRB1 ? "" : "Lime"), "006000")
Return
; ----------------------------------------------------------------------------------------------------------------------
STDCB1:
   GuiControlGet, STDCB1
   CtlColors.Change(CBID1, (STDCB1 ? "Lime" : "C0C0C0"), "Red")
   Return
; ----------------------------------------------------------------------------------------------------------------------
RBG:
   RBG := SubStr(A_GuiControl, 3)
   If (RBG != RBGA) {
      CtlColors.Detach(RTID%RBGA%)
      CtlColors.Attach(RTID%RBG%, "Yellow", "Blue")
      GuiControl, , RB%RBG%, 1
      RBGA := RBG
   }
Return
; ----------------------------------------------------------------------------------------------------------------------
LB1:
   GuiControlGet, LB1
   StringSplit, LC, LB1, %A_Space%
   If (%LC2%) {
      BG := %LC2%, TX := "White"
      CtlColors.Change(LBID1, BG, TX)
      SendMessage, LB_SETCURSEL, -1, 0, , ahk_id %LBID1%
   }
Return
; ----------------------------------------------------------------------------------------------------------------------
CB1:
   GuiControlGet, CB1
   If (A_GuiControl = "CT1")
      CB1 ^= True
   If (CB1)
      CtlColors.Change(CTID1, "Lime", "406060")
   Else
      CtlColors.Change(CTID1, "", "Green")
   GuiControl, , CB1, %CB1%
Return
; ----------------------------------------------------------------------------------------------------------------------
CBB1:
Return