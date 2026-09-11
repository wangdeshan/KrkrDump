#AutoIt3Wrapper_AU3Check_Parameters=-q -d -w 1 -w 2 -w 3 -w 4 -w 5 -w 6
#include-once
#include<array.au3>

Global $exts[] = ["txt", "pbd"];, "tlg", "ogg", "ogg.sli", "opus", "opus.sli", "mpg", "wmv"]

If @ScriptName = 'KrkrDump.au3' Then
	KrkrDumpExtractmain()
EndIf
Func DumpByCGlistCsv($cglist)
	Local $listf = "R:\krdlist.bycglist.txt"
	Local $hf = FileOpen($listf, 2)
	Local $lines = FileReadtoarray($cglist)
	For $i = 0 To UBound($lines) - 1
		Local $line = StringStripWS($lines[$i], 3)
		If StringLeft($line, 1) = "#" Then ContinueLoop
		ConsoleWrite('@@ Debug(' & @ScriptLineNumber & ') : $line = ' & $line & @CRLF) ;### Debug Console
		Local $sp = StringSplit($line, "," & @TAB)
		If @error Then ContinueLoop
;~ 		_ArrayDisplay($sp)
		For $x = 1 To $sp[0]
			Local $sub = StringStripWS($sp[$x], 3)
			If $sub = "" Then ContinueLoop
			FileWriteLine($hf, $sub & ".png")
		Next
	Next
	FileClose($hf)
	ExtractByList($listf)
EndFunc   ;==>DumpByCGlistCsv
Func KrkrDumpExtractmain()
;~ 	DumpKname()
;~ 	DumpByStand()
	DumpByCGlistCsv("Y:\doinaka_brother\KrkrDump\data\cglist.csv")
;~ 	ExecScript("krdscr.tjs")
	; Local $listf = "R:\krdlist.txt"
	; Local $hf = FileOpen($listf, 2)
	; For $i = 1 To 6
	; FileWriteLine($hf, StringFormat("_thum_bs_face_hy_a_%02d.png", $i))
	; Next
;~ 	Local $dir = "Y:\kakenuke_R18\KrkrDump\upgrade"
;~ 	FileChangeDir($dir)
;~ 	Local $hSearch = FileFindFirstFile("*.png")
;~ 	If $hSearch = -1 Then
;~ 		ConsoleWrite('@@ Debug(' & @ScriptLineNumber & ') : EMPTY = ' & $dir & @CRLF)
;~ 		FileClose($hSearch)
;~ 		Return
;~ 	EndIf

;~ 	While 1
;~ 		Local $sFile = FileFindNextFile($hSearch)
;~ 		If @error Then ExitLoop
;~ 		If @extended Then ContinueLoop
;~ 		ConsoleWrite('@@ Debug(' & @ScriptLineNumber & ') : $sFile = ' & $sFile & @CRLF) ;### Debug Console
;~ 		KrkrDumpExtract($sFile)
;~ 		FileWriteLine($hf,)
;~ 		Local $s = $sFile
;~ 		$s = StringReplace($s, "_cn.png", "")
;~ 		$s = StringReplace($s, "_en.png", "")
;~ 		$s = StringReplace($s, "_tw.png", "")
;~ 		$s = StringReplace($s, ".png", "")
;~ 		FileWriteLine($hf, $s & "_cn.png")
;~ 		FileWriteLine($hf, $s & "_en.png")
;~ 		FileWriteLine($hf, $s & "_tw.png")
;~ 		FileWriteLine($hf, $s & ".png")
;~ 	WEnd
	; FileClose($hf)
	; ExtractByList($listf)

EndFunc   ;==>KrkrDumpExtractmain
Func DumpKname()
	Local $p1 = ["hi", "ki", "ri", "si", "na", "rr"]
	Local $p2 = ["op", "ed"]
	Local $p3 = ["", "_cn", "_tw", "_en", "_jp", "_ja"]
	
	ReDim $p3[1]
	$p3[0] = ""
	ReDim $p1[36]
	For $i = 0 To 35
		$p1[$i] = StringFormat("%02d", $i)
	Next
	ReDim $p2[21]
	For $i = 0 To 20
		$p2[$i] = StringFormat("%04d", $i)
	Next
	Local $exts[] = [".ogg"]
	
	For $prt1 In $p1
		For $prt2 In $p2
			For $prt3 In $p3
				For $e In $exts
					Local $name = StringFormat("sys%s_%s%s%s", $prt1, $prt2, $prt3, $e)
					ConsoleWrite($name & @CRLF) ;### Debug Console
;~ 					KrkrDumpExtract($name)
				Next
			Next
		Next
	Next
EndFunc   ;==>DumpKname
Func DumpByStand()
	FileChangeDir("Y:\TenShiSouZou_R18\KrkrDump\fgimage")
	Local $hSearch = FileFindFirstFile("*.stand")
	If $hSearch = -1 Then
		MsgBox(4096, "错误", "没有文件/目录 匹配搜索")
		Exit
	EndIf
	While 1
		Local $sFile = FileFindNextFile($hSearch)
		If @error Then ExitLoop
		If @extended Then ContinueLoop
		ConsoleWrite('@@ Debug(' & @ScriptLineNumber & ') : $sFile = ' & $sFile & @CRLF) ;### Debug Console
		Local $txt = FileRead($sFile)
;~ 		ConsoleWrite('@@ Debug(' & @ScriptLineNumber & ') : $txt = ' & $txt & @CRLF) ;### Debug Console
		Local $re = StringRegExp($txt, '"filename"=>"(.*)"', 3)
		If @error Then
			$re = StringRegExp($txt, "filename:'(.*)'", 3)
			If @error Then
				MsgBox(0, 0, 0)
				Exit
			EndIf
		EndIf
		
		For $k In $re
			For $e In $exts
				KrkrDumpExtract(StringFormat("%s_0.%s", $k, $e))
			Next
		Next
;~ 		ExitLoop
	WEnd
	FileClose($hSearch)
EndFunc   ;==>DumpByStand
Func ExtractByList($path)
	$path = StringReplace($path, "\", "/")
	KrkrDumpExtract("ExtractByList:" & $path)
EndFunc   ;==>ExtractByList
Func ExecScript($path)
	$path = StringReplace($path, "\", "/")
	KrkrDumpExtract("ExecScript:" & $path)
EndFunc   ;==>ExecScript
Func KrkrDumpExtract($name)
	ConsoleWrite('@@ Debug(' & @ScriptLineNumber & ') : $name = ' & $name & @CRLF) ;### Debug Console
	WinWait("KrkrDumpInput", "LastMSG")
	ControlSetText("KrkrDumpInput", "LastMSG", "[CLASS:Edit; INSTANCE:1]", $name)
	ControlClick("KrkrDumpInput", "LastMSG", "[CLASS:Button; INSTANCE:1]")
	WinWait("KrkrDumpInput", "LastMSG")
EndFunc   ;==>KrkrDumpExtract
