#NoEnv
#SingleInstance FORCE
SendMode Input
SetWorkingDir %A_ScriptDir%
commandName=%1%
GoSub AutoExecute
return

#Include *i Libraries\Functions.lib

/* ; --------------- HELP --------------------
Write your own AHK commands in this file. 
They will be automatically added to your Fast Search, which you can open by pressing Right Alt.

In the example below: 
	"if commandName = cmd" means that whenever you type "cmd" in your search window,
	it will be colored in green and pressing Enter will open the command prompt.

Note: Adding new commands does not require reloading the program.
*/

AutoExecute:

	if commandName = config
	{
		OpenWithVSCode(A_ScriptFullPath)
	}
	else if commandName = cmd
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
	else if commandName = docs
	{
		changeOrOpenDir(A_MyDocuments)
	}
	
return

;-------------------- Helper functions --------------------

changeOrOpenDir(path)
{
    WinGet, hWnd, ID, A
	
	if (WinActive("ahk_class Shell_TrayWnd") || WinActive("ahk_class Progman") || WinActive("ahk_class WorkerW"))
	{
		Run, %path%
	}
	else if WinActive("ahk_exe explorer.exe")
	{
		Send ^l
		Sleep 20
		ControlSetText, Edit1, %path%, ahk_id %hWnd%
		ControlSend, Edit1, {Enter}, ahk_id %hWnd%
	}
	else if WinActive("ahk_class #32770")
	{
		Send ^l 
		Sleep 20
		ControlSetText, Edit2, %path%, ahk_id %hWnd%
		ControlSend, Edit2, {Enter}, ahk_id %hWnd%
	}
	else
	{
		Run, %path%
	}
}

CmdCommandExists(command) {
    RunWait, %ComSpec% /c where %command%, , Hide UseErrorLevel
    return !ErrorLevel
}

OpenWithVSCode(filePath)
{
	if (!CmdCommandExists("code"))
	{
		ShellRun("OpenWith.exe", filePath)
		WinWaitActive, ahk_exe OpenWith.exe,, 3
		Sleep 120
		Send {Tab}
		return
	}
	
	Run, "code" %filePath%,,Hide
}