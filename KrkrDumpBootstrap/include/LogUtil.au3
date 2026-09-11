#include-once
#include"config.au3"
#include"HxInfo.au3"


Func ParseLog($ini, $exepath, $name, $exename)
	FileChangeDir($exepath)
;~ 	ConsoleWrite('@@ Debug(' & @ScriptLineNumber & ') : $ini = ' & $ini & @CRLF) ;### Debug Console
	If FileExists($KrkrDumplog) Then
		If FileGetSize($CxTableName) <> 4096 Then Return
		If FileGetSize($CxOrderName) <> (8 + 6 + 3) Then Return
		
		IniWrite($ini, "GameInfo", "Name", $name)
		IniWrite($ini, "GameInfo", "ExeName", $exename)
		IniWrite($ini, "GameInfo", "HxNamesList", "HxNames_" & $name & ".txt")
		IniWrite($ini, "GameInfo", "OldName", "")
		IniWrite($ini, "GameInfo", "NewName", "")

		Local $order = ConvertCxOrder($exepath & "\" & $CxOrderName)
		IniWrite($ini, "FilterInfo", "EvenBranchOrder", $order[0])
		IniWrite($ini, "FilterInfo", "OddBranchOrder", $order[1])
		IniWrite($ini, "FilterInfo", "PrologOrder", $order[2])
		
		Local $table = ConvertCxTable($exepath & "\" & $CxTableName)
		IniWrite($ini, "FilterInfo", "ControlBlock", $table)

		Local $lines = FileReadtoarray($KrkrDumplog)
		Local $arcname = "dummy"
		Local $key1 = ""
		Local $key2 = ""
		Local $RandomType = 0
		Local $Offset = 0
		Local $Mask = 0
		Local $FilterKey = 0
		For $i = 0 To UBound($lines) - 1
			Local $line = $lines[$i]
			If StringInStr($line, "Parsing archive:") = 23 Then
				$arcname = StringMid($line, 40)
				ContinueLoop
			EndIf
			If StringInStr($line, "IndexKey:") = 23 Then
				$key1 = StringMid($line, 33)
				ContinueLoop
			EndIf
			If StringInStr($line, "IndexNonce:") = 23 Then
				$key2 = StringMid($line, 35)
				IniWrite($ini, "Archives", $arcname, $key1 & "," & $key2)
				ContinueLoop
			EndIf
			If StringInStr($line, "Filter Key:") = 23 Then
				$FilterKey = StringMid($line, 35)
				IniWrite($ini, "FilterInfo", "FilterKey", "0x" & $FilterKey)
				ContinueLoop
			EndIf
			If StringInStr($line, "Split Pos Mask:") = 23 Then
				$Mask = StringMid($line, 39)
				IniWrite($ini, "FilterInfo", "Mask", "0x" & $Mask)
				ContinueLoop
			EndIf
			If StringInStr($line, "Split Pos:") = 23 Then
				$Offset = StringMid($line, 34)
				IniWrite($ini, "FilterInfo", "Offset", "0x" & $Offset)
				ContinueLoop
			EndIf
			If StringInStr($line, "Random Type:") = 23 Then
				$RandomType = StringMid($line, 36)
				IniWrite($ini, "FilterInfo", "RandomType", $RandomType)
				ContinueLoop
			EndIf
		Next
		
		FileDelete($exepath & "\" & $CxTableName)
		FileDelete($exepath & "\" & $CxOrderName)
		
	EndIf
EndFunc   ;==>ParseLog
Func MoveLog($exepath, $logpath)
	ConsoleWrite('@@ Debug(' & @ScriptLineNumber & ') : $logpath = ' & $logpath & @CRLF) ;### Debug Console
	FileChangeDir($exepath)
	If FileExists($KrkrDumplog) Then
		Local $line = FileRead($KrkrDumplog, 38)
		ConsoleWrite('@@ Debug(' & @ScriptLineNumber & ') : $line = >' & $line & @CRLF) ;### Debug Console
		Local $mid = StringMid($line, 23, 16)
		If $mid <> "KrkrDump Startup" Then Return
		$mid = StringMid($line, 1, 19)
		$mid = StringReplace($mid, " ", "_")
		$mid = StringReplace($mid, ":", "-")
		ConsoleWrite('@@ Debug(' & @ScriptLineNumber & ') : $mid = >' & $mid & @CRLF) ;### Debug Console
		Local $dst = $logpath & "\KrkrDump_" & $mid & ".log"
		ConsoleWrite('@@ Debug(' & @ScriptLineNumber & ') : $dst = ' & $dst & @CRLF) ;### Debug Console
		FileMove($KrkrDumplog, $dst, 8)
	EndIf
EndFunc   ;==>MoveLog