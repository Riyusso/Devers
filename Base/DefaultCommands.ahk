#NoEnv
#SingleInstance FORCE
SendMode Input
SetWorkingDir %A_ScriptDir%
commandName=%1%
param1=%2%
Loop, %0% ; the parameter can be more than one word
	if (A_Index > 2)
		param1 .= " " . %A_Index%
GoSub AutoExecute
return

#Include *i Libraries\Functions.lib

/* --------------- DEFAULT COMMANDS ----------------
Replaced on every update, so don't edit it - add your own commands in CustomCommands.ahk (type "config").
*/

AutoExecute:

	if commandName = config ; Open CustomCommands.ahk in the editor
	{
		OpenWithEditor(A_ScriptDir "\CustomCommands.ahk") ; not A_ScriptFullPath, that would open this file which gets replaced on update
	}

return
