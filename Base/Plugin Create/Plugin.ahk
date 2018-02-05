#NoEnv
#NoTrayIcon
#SingleInstance FORCE
SendMode Input
SetWorkingDir %A_ScriptDir%
; The code below suspends the plugin when the script is suspended.
IniWrite, Released, settings.ini, plugins, State
SetTimer, Checks, 100
Checks:
    IniRead, State, settings.ini, plugins, State
    If(State="Suspended") && !A_IsSuspended
	    Suspend, On
    else if (State="Exit")
        ExitApp
    else if A_IsSuspended
        Suspend, Off
return

; ----------- User functions here -------------
