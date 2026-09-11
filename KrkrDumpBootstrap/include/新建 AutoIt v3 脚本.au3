#AutoIt3Wrapper_AU3Check_Parameters=-q -d -w 1 -w 2 -w 3 -w 4 -w 5 -w 6
#include<config.au3>
#include<array.au3>

main()


Func main()
	Local $lst = "Y:\TenShiSouZou_R18\UnknownFileName.txt"
	Local $data = FileRead($lst)
	Local $re = StringRegExp($data, "UnknownFileName_(.{64})", 3)
;~ 	Local $re = StringRegExp($data, "UnknownDirName_(.{16})",3)
;~ _ArrayDisplay($re)
	If @error Then Return
	Local $count = UBound($re)
	If $count <= 0 Then Return
	
	Local $dir = $GarbroPath & "\GameData"
	FileChangeDir($dir)
	Local $hSearch = FileFindFirstFile("HxNames_*")
	If $hSearch = -1 Then
		ConsoleWrite('@@ Debug(' & @ScriptLineNumber & ') : EMPTY = ' & $dir & @CRLF)
		FileClose($hSearch)
		Return
	EndIf
	Local $dict = ObjCreate('Scripting.Dictionary')
	While 1
		Local $sFile = FileFindNextFile($hSearch)
		If @error Then ExitLoop
		If @extended Then ContinueLoop
		ConsoleWrite('@@ Debug(' & @ScriptLineNumber & ') : $sFile = ' & $sFile & @CRLF) ;### Debug Console
		loadtodict($dict, $sFile)
	WEnd
	
	For $i = 0 To $count - 1
		Local $key = $re[$i]
		If $dict.exists($key) Then
			ConsoleWrite($key & ":" & $dict.Item($key) & @CRLF)
		EndIf
	Next
EndFunc   ;==>main


Func loadtodict($dict, $file)
	Local $lines = FileReadtoArray($file)
	If @error Then
		ConsoleWrite('LoadListErr => ' & $file & @CRLF) ;### Debug Console
		Return $dict
	EndIf
	
	ConsoleWrite('LoadList => ' & $file & @CRLF) ;### Debug Console
	Local $lastcount = $dict.Count
	Local $count = UBound($lines)
	For $i = 0 To $count - 1
		Local $key = StringStripWS($lines[$i], 1 + 2)
		If $key = "" Then ContinueLoop
		Local $sp = StringSplit($key, ":")
		Switch StringLen($sp[1])
			Case 16, 64
				$dict.Item($sp[1]) = $sp[2]
			Case Else
				MsgBox(0, 0, $key)
		EndSwitch
	Next
	ConsoleWrite("LoadList => Add " & $dict.Count - $lastcount & " of " & $count & " Lines " & @CRLF)
EndFunc   ;==>loadtodict
