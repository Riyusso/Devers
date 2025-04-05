#NoEnv
#SingleInstance FORCE
SendMode Input
SetWorkingDir %A_ScriptDir%
commandName=%1%
GoSub AutoExecute
return

#Include *i Libraries\Functions.lib

/* ; --------------- HELP --------------------
Write your own commands which will be added to the Fast Search module. 

In the example below: 
	"if commandName = gmail" means that whenever you type "gmail",
	it will be colored in green and pressing Enter will open the Gmail website.
	
In addition to autohotkey's built-in functions, there are more functions available with Devers.
Press F1 while the search box is open to view them.
*/

AutoExecute:

	if commandName = config
	{
		OpenWithEditor(A_ScriptFullPath)
	}
	else if commandName = cmd
	{
		OpenCmd()
	}
	else if commandName = docs
	{
		ChangeOrOpenDir(A_MyDocuments)
	}
	else if commandName = gmail
	{
		Run, https://mail.google.com/mail/u/1/
	}
	else if commandName = hosts
	{
		Run, notepad.exe C:\Windows\System32\drivers\etc\hosts
	}
	
return


;-------------------- Helper functions --------------------
; You can also write your own helper functions here, for example:
; ClearInsideFolder( pathToFolder )
; {
;     FileDelete, %pathToFolder%\*.*
;     Loop, %pathToFolder%\*.*, 2, 1
; 		FileRemoveDir, %A_LoopFileFullPath%, 1
; } 