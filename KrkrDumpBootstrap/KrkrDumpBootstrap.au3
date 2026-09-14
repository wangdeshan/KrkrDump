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

Global $logfile = 'R:\KrkrDumpBootstrapRunlog.txt'
Global $hlogfile = -1
Global $loghasnew = False

AdlibRegister('_Flushlog', 500)
Func _Flushlog()
	If $loghasnew Then
		If $hlogfile = -1 Then $hlogfile = FileOpen($logfile, 1 + 8 + 256)
		FileFlush($hlogfile)
		$loghasnew = False
	EndIf
EndFunc   ;==>_Flushlog
Func _ConsoleWrite($data)
	If FileExists($logfile) = 0 Then
		FileClose($hlogfile)
		$hlogfile = -1
	EndIf
	If $hlogfile = -1 Then $hlogfile = FileOpen($logfile, 1 + 8 + 256)
	FileWrite($hlogfile, $data)
	$loghasnew = True
	Return ConsoleWrite($data)
EndFunc   ;==>_ConsoleWrite

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
	
	$ScriptTitle = "KrkrDumpWatcher_" & $gamename
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

	WriteConfig($cfgpath, $dumpdir, $dumpkey, $hxname)
	MoveLog($exepath, $logsdir)

	Local $pid = RunLoader($exename, $exepath, $usele)

	Watchlogs($pid, $KrkrDumplog, $hxname, $gamename)
	If $dumpkey Then ParseLog($cx_info, $exepath, $n, $exename)
	MoveLog($exepath, $logsdir)
	MergOne($n)
EndFunc   ;==>main
Func Watchlogs($pid, $log1, $log2, $gamename)
	Local $base = $HxNameGarbroBase & $gamename & ".txt"
	Local $dict = ObjCreate('Scripting.Dictionary')

	LoadListToDict($dict, $HxNamePublic)
	LoadListToDict($dict, $base)

	Local $flag = False
	Local $f1 = -1
	Local $f2 = -1
	Local $txt1
	Local $txt2
	While 1
		If $f1 = -1 Then $f1 = FileOpen($log1)
		If $f2 = -1 Then $f2 = FileOpen($log2)
		While 1
			$txt1 = FileReadLine($f1)
			If @error Then ExitLoop
			ConsoleWrite($txt1 & @CRLF)
		WEnd
		While 1
			$txt2 = FileReadLine($f2)
			If @error Then ExitLoop
			Local $key = StringStripWS($txt2, 1 + 2)
			If $key = "" Then ContinueLoop
			If $dict.exists($key) Then ContinueLoop
			$dict.add($key, 1)
			FileWriteLine($base, $key)
			ConsoleWrite($txt2 & @CRLF)
		WEnd
		If $txt1 = "" And $txt2 = "" Then
			If ProcessExists($pid) Then
				Sleep(1000)
			ElseIf $flag Then
				ExitLoop
			Else
				Sleep(1000)
				$flag = True
			EndIf
		EndIf
	WEnd
	FileClose($f1)
	FileClose($f2)
EndFunc   ;==>Watchlogs
Func RunLoader($exename, $exepath, $usele = False)
	FileChangeDir($exepath)
	FileDelete($KrkrDumplog)
	Local $pid
	If $usele Then
		$pid = Run($leproc & " " & $leguid & ' ' & $KrkrDumpbinpath & "\" & $KrkrDumpexe & ' "' & $exepath & "\" & $exename & '"', $exepath, @SW_HIDE)
	Else
		$pid = Run($KrkrDumpbinpath & "\" & $KrkrDumpexe & ' "' & $exepath & "\" & $exename & '"', $exepath, @SW_HIDE)
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


