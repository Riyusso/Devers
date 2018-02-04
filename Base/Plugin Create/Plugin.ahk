#NoEnv
#NoTrayIcon
#SingleInstance FORCE
SendMode Input
SetWorkingDir %A_ScriptDir%
; The code below suspends the plugin when the script is suspended.
SetTimer, Checks, 100
Checks:
    IniRead, State, settings.ini, plugins, State
    If(State="Suspended")
	    Suspend, On
    else
        Suspend, Off
return

; ----------- User functions here -------------
