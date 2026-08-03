#NoEnv
#SingleInstance FORCE
SendMode Input
SetWorkingDir %A_ScriptDir%
commandName=%1%
param1=%2%
GoSub AutoExecute
return

#Include *i Libraries\Functions.lib

/* --------------- INSTRUCTIONS --------------------
Write your own commands which will be added to the search module.
Just add a new "else if commandName = YOUR_COMMAND_NAME"

Anything written after a semicolon on the same line is used as the description of the command,
so it shows up in the built in command list. Press F1 while the search bar is open to see it.

There are some helper functions available to make your life easier as seen in the commands below.
Type "functions" to open a file which contains them, but please don't edit this file directly.
For example OpenCmd(), OpenWithEditor(), ExecuteCmdCommand() etc. are all helper functions that are not available in regular Autohotkey.

There are 5 example commands below:
cmd - simple command that opens the command prompt. If File Explorer is open it will use the current directory as it's base.
functions - opens a file which contains helper functions that are available in here. Please don't edit this file directly.
docs - Uses the helper function to open the folder My Documents. If your file explorer or a file dialog is open it will change it to the folder.
gmail - Self explanatory, but opens the browser at the url for gmail.
ping[\s] - This is an example command that enables you to pass an additional parameter. As you can see, regex is supported for commands. For example you can type "ping google.com" in your search bar.
*/

AutoExecute:

	if commandName = cmd ; Open the command prompt in the current Explorer folder
	{
		OpenCmd()
	}
	else if commandName = functions ; Open the list of helper functions available in CustomCommands.ahk
	{
		OpenWithEditor("Libraries/Functions.lib")
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

return
