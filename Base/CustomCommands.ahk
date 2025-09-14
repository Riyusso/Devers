#NoEnv
#SingleInstance FORCE
SendMode Input
SetWorkingDir %A_ScriptDir%
commandName=%1%
param1=%2%
GoSub AutoExecute
return

#Include *i Libraries\Functions.lib

/* --------------- HELP --------------------
Write your own commands which will be added to the search module. 
Just add a new "else if commandName = YOUR_COMMAND_NAME"

There are helper functions available in "My Documents\Devers\Libraries\Functions.lib" 
Type help in the search to open the file and view them.
*/

AutoExecute:

	if commandName = cmd
	{
		OpenCmd() ; This will open the cmd in the active directory if your file explorer is open.
	}
	else if commandName = config
	{
		 ; This opens this configuration file. You should keep it.
		OpenWithEditor(A_ScriptFullPath)
	}
	else if commandName = help
	{
		OpenWithEditor("Libraries/Functions.lib")
	}
	else if commandName = docs
	{
		OpenFolder(A_MyDocuments)
	}
	else if commandName = gmail
	{
		Run, https://mail.google.com/mail/u/1/
	}
	else if commandName = ping[\s]
	{
		; You can also use regex if you want to pass multiple parameters. See "ping[\s]".
		ExecuteCmdCommand("ping " param1)
	}
	
return