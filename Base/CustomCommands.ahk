#NoEnv
#SingleInstance FORCE
SendMode Input
SetWorkingDir %A_ScriptDir%
commandName=%1%
GoSub RunCommand
return

#Include *i Libraries\Functions.lib

/* ; --------------- HELP --------------------
Write your own AHK commands in this file. 
They will be automatically added to your Fast Search, which you can open by pressing Right Alt.

For example: 
	"if commandName = cmd" means that whenever you type "cmd" 
	in your search window it will be colored in green and pressing Enter will open the command prompt.

Note: Adding new commands does not require reloading the program.
*/

RunCommand:

	if commandName = cmd
	{
		folderPath := ExplorerGetActiveFolderPath()
		run, %comspec%, % folderPath ? folderPath : "C:\Users\" A_UserName
	}
	else if commandName = mail
	{
		Run, https://mail.google.com/mail/u/1/
	}
	else if commandName = hosts
	{
		Run, notepad.exe C:\Windows\System32\drivers\etc\hosts
	}
	else if commandName = opencommands
	{
		ShellRun("OpenWith.exe", A_ScriptFullPath)
		WinWaitActive, ahk_exe OpenWith.exe,, 3
		Sleep 100
		Send {Tab}
	}

return