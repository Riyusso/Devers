#NoEnv
#SingleInstance FORCE
SendMode Input
SetWorkingDir %A_ScriptDir%
commandName=%1%
param1=%2%
param2=%3%
paramAll=
for i, arg in A_Args ; paramAll can be used if you want the param to be more than one word
    if (i > 1)
        paramAll .= (paramAll = "" ? "" : " ") . arg
GoSub AutoExecute
return

#Include *i Libraries\Functions.lib


/* --------------- INSTRUCTIONS --------------------
Write your own commands which will be added to the search module.
Add a command with "else if commandName = NAME". Text after the semicolon is its description (F1 in the search bar lists them all).
Add [\s] to take a parameter in param1, like "ping[\s]".
This file is never overwritten on update.
*/

AutoExecute:

	if commandName = cmd ; Open the command prompt in the current Explorer folder
	{
		OpenCmd()
	}
	else if commandName = docs ; Open the My Documents folder
	{
		OpenFolder(A_MyDocuments)
	}
	else if commandName = gmail ; Open Gmail in the browser
	{
		Run, https://mail.google.com/mail/u/1/
	}
	else if commandName = ping[\s] ; Ping a host, for example "ping google.com"
	{
		ExecuteCmdCommand("ping " param1)
	}
	else if commandName = emptybin ; Empty the Recycle Bin
	{
		FileRecycleEmpty
		ShowNotification("Recycle Bin emptied")
	}

return
