#NoEnv
#NoTrayIcon
SplitPath, A_ScriptDir,, MainDirectory
SetWorkingDir, %MainDirectory%

Loop %0%
{
    PluginCompilation := true

    GivenPath := %A_Index%
    Loop %GivenPath%, 1
    {
        PluginFullPath := A_LoopFileLongPath
        StringReplace, PluginFileName, A_LoopFileName, % "." . A_LoopFileExt
    }

    FileMove, %PluginFullPath%, Plugins/Plugin.ahk
    
    Run, Compiler/Compiler.exe /in "Plugins/installer" /out  "Plugins/%PluginFileName%.exe" /icon "Base/SinglePlugin.ico" /bin Compiler/AutoHotkeySC.bin

    While ! FileExist( "Plugins/" PluginFileName ".exe" )
	    Sleep 150
    FileMove, Plugins/Plugin.ahk, %PluginFullPath%

    Sleep 100
}

ExitApp