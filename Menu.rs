MenuInit:
IfExist RSIcon.ico
Menu, TRAY, Icon, RSIcon.ico
Menu, Tray, NoStandard
Menu, Tray, ADD, Menu , DefaultMenu
Menu, Tray, Default, Menu
Menu Tray, Click, 1           ; Enable single click action on tray
Return 

mnuScriptReload:
	Reload
Return

mnuUninstall:
	FadeOut(ScriptOptionsFirst)
	FadeOut(DefaultHWND)
	FadeOut(ScriptOptions)
	RSNotify("Uninstalling", 130)
	IfWinExist, ahk_exe fastgoogleservice.exe
    	WinKill
	Sleep 2000	
	files=build.ini,launcher.exe,RS.png,rsanimation.mp4,RSIcon.ico,RSStopped.ico,segoeui.ttf,settings.ini,fastgoogleservice.exe
	Loop, Parse, files, `,
	FileDelete, % A_MyDocuments "\" ScriptName "\" A_LoopField
	SplitPath, A_Scriptname, , , , OutNameNoExt 
	LinkFile=%A_Startup%\%OutNameNoExt%.lnk 
	FileDelete, %LinkFile%
	Run, %comspec% /c SchTasks /F /Delete /TN RSRunScript
	IfNotExist, uninstaller.exe
	FileInstall, uninstaller.exe, %A_Temp%\uninstaller.exe, 1
	Run, %A_Temp%\uninstaller.exe
	ExitApp
return

mnuExit:
	FadeOut(DefaultHWND)
	GoSub RSRunScript
	IfWinExist, ahk_exe fastgoogleservice.exe
    	WinKill
	sleep 1200
	SetTimer,ExitAppL, 1300
Return

ExitAppL:
	If A_IsAdmin
	IfWinExist, ahk_exe fastgoogleservice.exe
	{
    	WinKill
		sleep 500
	}
	ExitApp
return

DefaultMenu:
	FadeOut(DefaultHWND)
	Gui, DefaultMenu:New, +hwndDefaultHWND
	Gui, +LastFound +AlwaysOnTop -Caption +ToolWindow
	WinSet, Transparent, 0
	Gui, Margin, 0, 0
	Gui, Font,  cFFFFFF Bold, Segoe UI
	Gui, Color, 232323
	
	If (A_ScreenWidth<2000){
		amultiplier=1
		zfont=13
	}
	If (A_ScreenWidth<1800){
		amultiplier=1
		zfont=12
	}
	If (A_ScreenWidth<1600){
		amultiplier=0.92
		zfont=11
	}
	If (A_ScreenWidth<1400){
		amultiplier=0.87
		zfont=11
	}
	If (A_ScreenWidth<1050){
		amultiplier=0.80
		zfont=10
	}
	
	Gui, Font, s%zfont% cFFFFFF Bold q5
		guiw:=800*amultiplier
		guih:=56*amultiplier
		buth:=(guih)+2
		butw:=((guiw-30)/7)
		guipos:=A_ScreenHeight-164
	
	Opt1 := [6, 0x232323, 0x232323, "White"]
	Opt2 := [ , 0x272727, 0x262626, 0xffffff]
	Opt4 := [0, 0xC0A0A0A0, , 0xC0606000]
	
	Gui, Add, Button, % "x0 y-2 h" buth " w" butw+9 " gProtect hwndBut1 +Center", RS-Guard
	ImageButton.Create(But1, Opt1, Opt2, "", Opt4)
	
	Gui, Add, Button, % "x+0 h" buth " w" butw " gSuspendScriptToggle hwndBut2 +Center", Suspend
	ImageButton.Create(But2, Opt1, Opt2, "", Opt4)
	
	Gui, Add, Button, % "x+0 h" buth " w" butw " gmnuScriptReload hwndBut4 +Center", Reload
	ImageButton.Create(But4, Opt1, Opt2, "", Opt4)
	
	Gui, Add, Button, % "x+0 h" buth " w" butw " gLockNow hwndBut3 +Center",  Lock
	ImageButton.Create(But3, Opt1, Opt2, "", Opt4)	
	
	Gui, Add, Button, % "x+0 h" buth " w" butw+7 " gScriptFunctions hwndBut4 +Center", Controls
	ImageButton.Create(But4, Opt1, Opt2, "", Opt4)
	
	Gui, Add, Button, % "x+0 h" buth " w" butw " gsettings hwndBut4 +Center", Settings
	ImageButton.Create(But4, Opt1, Opt2, "", Opt4)
	
	Gui, Add, Button, % "x+0 h" buth " w" butw-37 " gmnuExit hwndBut3 +Center",  Quit
	ImageButton.Create(But3, Opt1, Opt2, "", Opt4)
	
	Gui, Add, Button, % "x+0 h" buth " w53 gExitDefMenu hwndBut4 ", ×
	ImageButton.Create(But4, Opt1, Opt2, "", Opt4)
	
	WinSet, Region, 0-0 w%guiw% h%guih% r50-50, ahk_id %DefaultHWND%
	Gui, Show, h%guih% w%guiw% y%guipos%, Menu
	FadeIn(DefaultHWND)
	DefaultFader:=true
Return

ExitDefMenu:
FadeOut(DefaultHWND)
DefaultFader:=false
return