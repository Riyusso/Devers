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

!Q::
	Send {Ctrl}
	sleep 50
	Send {Ctrl}
	sleep 120
	Send {g}{Space}
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


; ------------------------------------------------------------------ Temporary ------------------------------------------------------------------------


; -----------------------------------------------------------------------------------------------------------------------------------------------------

~LWin Up::
If (A_PriorKey <> "LWin")
return
else{
	Send {Ctrl}
	sleep 50
	Send {Ctrl}
}
return
