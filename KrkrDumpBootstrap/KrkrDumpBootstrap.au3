#region ;**** 参数创建于 ACNWrapper_GUI ****
#PRE_Outfile=KrkrDumpBootstrap.exe
#PRE_UseUpx=n
#PRE_UseX64=n
#PRE_Change2CUI=y
#PRE_Res_requestedExecutionLevel=None
#PRE_NoBuild=y
#PRE_AU3Check_Parameters=-q -d -w 1 -w 2 -w 3 -w 4 -w 5 -w 6
#endregion ;**** 参数创建于 ACNWrapper_GUI ****

#include"include\config.au3"

#include"include\GetGameName.au3"
#include"include\ProcessHxNameHash.au3"
#include"include\WriteConfig.au3"
#include"include\LogUtil.au3"

#include<file.au3>
#include<array.au3>


Global $ScriptTitle = "KrkrDumpBootstrap"
If WinExists($ScriptTitle) Then
	MsgBox(0, 0, "KrkrDumpBootstrap 运行中")
	Exit 128
EndIf
AutoItWinSetTitle($ScriptTitle)

main()

Func main()
	Local $d, $p, $n, $x
	Local $logname = ""
	If $cmdline[0] Then
		$logname = FileGetLongName($cmdline[1])
		If Not FileExists($logname) Then
			_PathSplit($logname, $d, $p, $n, $x)
			Local $fpath = $p & $n & $x
			For $i = 65 To 90 ;A-Z
				Local $tpath = Chr($i) & ":" & $fpath
				ConsoleWrite('@@ Debug(' & @ScriptLineNumber & ') : $tpath = ' & $tpath & @CRLF) ;### Debug Console
				If FileExists($tpath) Then
					$logname = $tpath
					ExitLoop
				EndIf
			Next
			
			If Not FileExists($logname) Then
				$logname = FileOpenDialog($logname & "未找到 请选择新位置", "", " (*.exe)", 1 + 2, $n & $x)
				If @error Then
					MsgBox(4096, "", "没有选择文件!")
					Exit
				EndIf
			EndIf
		EndIf
	EndIf
	
	If $logname = "" Then
		$logname = FileOpenDialog("", "", " (*.exe)", 1 + 2, "tvpwin32.exe")
		If @error Then
			MsgBox(4096, "", "没有选择文件!")
			Exit
		EndIf
	EndIf

	ConsoleWrite('@@ Debug(' & @ScriptLineNumber & ') : $logname = ' & $logname & @CRLF) ;### Debug Console
	_PathSplit($logname, $d, $p, $n, $x)
	Local $exename = $n & $x
	Local $exepath = $d & $p
	Local $gamename = GetGameName($n)
	Local $logsdir = $exepath & "Logs"
	Local $dumpdir = $exepath & "KrkrDump"
	Local $cfgpath = $exepath & $KrkrDumpcfg
	Local $cx_info = $exepath & $gamename & $HxInfoName
	Local $hxname = $HxNameBase & $gamename & ".txt"
	
	FileChangeDir($exepath)
	
	$ScriptTitle = "KrkrDumpWatcher_" & $exename
	If WinExists($ScriptTitle) Then
		MsgBox(0, 0, $exename & " 运行中 请先关闭后重试")
		Exit 128
	EndIf
	AutoItWinSetTitle($ScriptTitle)
	
;~ 	ConsoleWrite('@@ Debug(' & @ScriptLineNumber & ') : $d = ' & $d & @CRLF) ;### Debug Console
;~ 	ConsoleWrite('@@ Debug(' & @ScriptLineNumber & ') : $p = ' & $p & @CRLF) ;### Debug Console
;~ 	ConsoleWrite('@@ Debug(' & @ScriptLineNumber & ') : $n = ' & $n & @CRLF) ;### Debug Console
;~ 	ConsoleWrite('@@ Debug(' & @ScriptLineNumber & ') : $x = ' & $x & @CRLF) ;### Debug Console
	ConsoleWrite('@@ Debug(' & @ScriptLineNumber & ') : $exename = ' & $exename & @CRLF) ;### Debug Console
	ConsoleWrite('@@ Debug(' & @ScriptLineNumber & ') : $exepath = ' & $exepath & @CRLF) ;### Debug Console
	ConsoleWrite('@@ Debug(' & @ScriptLineNumber & ') : $dumpdir = ' & $dumpdir & @CRLF) ;### Debug Console
	ConsoleWrite('@@ Debug(' & @ScriptLineNumber & ') : $logsdir = ' & $logsdir & @CRLF) ;### Debug Console
	
	If FileExists(@DesktopDir & "\KrkrDump_" & $n & ".lnk") Then
		FileCreateShortcut(@ScriptFullPath, @DesktopDir & "\KrkrDump_" & $n, $exepath, $logname, "Run " & $n & " With KrkrDump", $logname)
	Else
		FileCreateShortcut(@ScriptFullPath, $exepath & "\KrkrDump_" & $n, $exepath, $logname, "Run " & $n & " With KrkrDump", $logname)
	EndIf
	Local $usele = IsNeedLocaleEmulator($logname)
	Local $dumpkey = True
	If FileExists($cx_info) Then $dumpkey = False
	If FileExists($hxname) Then MergOne($n)
	
	CopyBinaryToGamePath($exepath)
	WriteConfig($cfgpath, $dumpdir, $dumpkey, $hxname)
	MoveLog($exepath, $logsdir)

	Local $pid = RunLoader($exename, $exepath, $usele)
	Watchlogs($pid, $exepath, $KrkrDumplog)
	If $dumpkey Then ParseLog($cx_info, $exepath, $n, $exename)
	MoveLog($exepath, $logsdir)
	MergOne($n)
EndFunc   ;==>main
Func Watchlogs($pid, $exepath, $log1)
	Local $pid2 = Run($tail & " " & "-n +0 -F " & $log1 & "", $exepath, @SW_HIDE)
	While ProcessExists($pid)
		Sleep(1000)
	WEnd
	ProcessClose($pid2)
EndFunc   ;==>Watchlogs
Func CopyBinaryToGamePath($exepath)
;~ 	FileInstall("KrkrDump.dll", $exepath & $KrkrDumpdll, 1)
;~ 	FileInstall("KrkrDumpLoader.exe", $exepath & $KrkrDumpexe, 1)
	FileCopy($KrkrDumpbinpath & "\" & $KrkrDumpdll, $exepath & $KrkrDumpdll, 1 + 8)
	FileCopy($KrkrDumpbinpath & "\" & $KrkrDumpexe, $exepath & $KrkrDumpexe, 1 + 8)
EndFunc   ;==>CopyBinaryToGamePath
Func RunLoader($exename, $exepath, $usele = False)
	FileChangeDir($exepath)
	FileDelete($KrkrDumplog)
	Local $pid
	If $usele Then
		$pid = Run($leproc & " " & $leguid & " " & $KrkrDumpexe & ' "' & $exename & '"', $exepath, @SW_HIDE)
	Else
		$pid = Run($exepath & "\" & $KrkrDumpexe & ' "' & $exename & '"', $exepath, @SW_HIDE)
	EndIf
	ConsoleWrite('@@ Debug(' & @ScriptLineNumber & ') : $pid = ' & $pid & @CRLF) ;### Debug Console
	Local $rc = 0
	While 1
		If $rc > 100 Then Exit
		If ProcessExists($pid) = 0 Then Exit
		If FileExists($KrkrDumplog) Then ExitLoop
		Sleep(100)
		$rc += 1
	WEnd
	
	Return $pid

EndFunc   ;==>RunLoader

Func IsNeedLocaleEmulator($logname)
	If FileExists($logname & ".le.config") Then Return True
	Return False
EndFunc   ;==>IsNeedLocaleEmulator
