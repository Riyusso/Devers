#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#NoTrayIcon
; #Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
ScriptName=Devers

IniWrite, 1, %A_MyDocuments%\%ScriptName%\build.ini, build, ExitVar
Sleep 1250
FileRemoveDir, %A_MyDocuments%\%ScriptName%, 1
FileDelete, %A_MyDocuments%\%ScriptName%\*.*
FileRemoveDir, %A_MyDocuments%\%ScriptName%

If(!A_IsCompiled)
    ExitApp

FileInstall, unin.bat, unin.bat
Run, unin.bat,, HIDE
ExitApp