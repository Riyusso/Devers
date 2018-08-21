#NoEnv
#NoTrayIcon
#SingleInstance FORCE
SendMode Input
SetWorkingDir %A_ScriptDir%
Plugin.Properties()
Plugin.AssignHotkey()
return

#Include *i Libraries\Functions.lib
#Include *i Libraries\Library.lib

; ----------- User functions here -------------

Function:
return

class Plugin 
{
	static guicolor := "07868f"
	static btnhovercolor := "01a1ab"

	Properties()
	{
		Menu, Tray, Icon, OptionsIcon.ico
	}

	AssignHotkey()
	{
		global PluginName
		SplitPath, A_ScriptName,,,, PluginName
		IniRead, Hotkey, plugin-settings.ini, %PluginName%, key, UNASSIGNED
		If Hotkey=UNASSIGNED
			Plugin.ChooseHotkey()
		else
			Hotkey, %Hotkey%, Function
	}

	ChooseHotkey()
	{
		global ChooseHotkeyGUI
		Gui, ChooseHotkeyGUI:New, +hwndChooseHotkeyGUI
		Gui, +LastFound
		width=235
		height=80
		WinSet, Transparent, 0
		Gui, Margin, 0, 0
		Gui, -Caption
		Gui, Color, % this.guicolor
		Gui, Font, s10 Bold, Tahoma
		Opt1 := [6, "0x" . this.guicolor, "0x" . this.guicolor, "White"]
		Opt2 := [ , "0x" . this.guicolor, "0x" . this.btnhovercolor, 0xffffff]
		Opt4 := [0, 0xC0A0A0A0, , 0xC0606000]
		Gui, Add, Progress, % "x-1 y-1 w" width " h26 Background1F2326 Disabled hwndHPROG"
		Gui, Add, Text, x0 y4 w%width% Center BackgroundTrans +0x200 c228a96, Choose your desired hotkey!
		Gui, Add, Hotkey, % "x" Width/10 " y+18 w" (Width/2) " Center vHotkey ",
		Gui, Add, Button, x+12 w70 h25 +default gCHSubmitButton hwndBut1 +Center, Ready
		ImageButton.Create(But1, Opt1, Opt2, "", Opt4)
		WinSet, Region, % "0-0 w" width*DpiFactor() " h" height*DpiFactor() " r6-6"
		Gui, Show, w%width% h%height%, Desired hotkey?
		FadeIn(ChooseHotkeyGUI)
	}
}
CHSubmitButton:
    Gui, Submit, NoHide
    If (Hotkey!="None" && Hotkey!="" && Hotkey!=UNASSIGNED) {
        FadeOut(ChooseHotkeyGUI)
		IniWrite, %Hotkey%, plugin-settings.ini, %PluginName%, key
        Plugin.AssignHotkey()
    }
    else
        RSNotify("Not possible")
return
ChooseHotkeyGUIGuiEscape:
	FileDelete, %A_ScriptFullPath%
    FadeOut(ChooseHotkeyGUI)
	RSNotify("Canceled")
	Sleep 1500
    ExitApp
return