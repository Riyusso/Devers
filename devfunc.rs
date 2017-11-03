; -----------AutoExecute------------
IfExist, C:\Program Files\Rainmeter\Rainmeter.exe
	Run, C:\Program Files\Rainmeter\Rainmeter.exe
IfNotExist, fastgoogleservice.exe
	FileInstall, Base/fastgoogleservice.exe, %A_MyDocuments%\%ScriptName%\fastgoogleservice.exe, 1
sleep 650
Run, fastgoogleservice.exe
return

F22::
	GoSub LockNow
return

SC045:: 	; pause/break button deletes the previous word 
	Send ^+{Left}
	Send {Delete}
return

~SC00E & SC00D::
	Send ^+{Left}
	Send {Delete}
return

!SC01F::
	Suspend, Permit
	GoSub SuspendScriptToggle
return

~SC027::RapidHotkey("coding", 2, 0.2, 1) ; semicolon
coding:
	Send {End}
	Send {;}
return


#If WinActive( "ahk_exe firefox.exe" ) && !isWindowFullScreen( "A" )

	F3::
	Send {Browser_back}
	return

#If

RAlt::
IniWrite, 1, settings.ini, settings, OpenGoogleNow
return


; ------------------------------------------------------------------ Temporary ------------------------------------------------------------------------


; ------------------------------------------------------------------- LABELS --------------------------------------------------------------------------

; ------------------------------------------------------------------ Turned Off --------------------------------------------------------------------------

; ~LWin Up::
; 	If (A_PriorKey <> "LWin")
; 	return
; 	else{
; 		Send {Ctrl}
; 		sleep 50
; 		Send {Ctrl}
; 	}
; return

