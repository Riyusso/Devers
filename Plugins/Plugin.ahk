#NoEnv
#NoTrayIcon
#SingleInstance FORCE
SendMode Input
SetWorkingDir %A_ScriptDir%
GoSub AssignHotkey
return

#Include Libraries\RSPlugin.lib

; ----------- User functions here -------------

Function:
return