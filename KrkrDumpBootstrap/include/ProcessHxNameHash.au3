#AutoIt3Wrapper_AU3Check_Parameters=-q -d -w 1 -w 2 -w 3 -w 4 -w 5 -w 6
#include"config.au3"
#include"GetGameName.au3"

#include <Array.au3>

Global $dict2 = ObjCreate('Scripting.Dictionary')

If @ScriptName = 'ProcessHxNameHash.au3' Then
	LoadBaseList($HxNamePublic)
;~ 	SaveBaseList($public & ".new.txt")
;~ 	MergAllinOne()
	MergListAll()
EndIf

Func MergAllinOne()
	Local $dir = $GameDataDir
	FileChangeDir($dir)
	Local $hSearch = FileFindFirstFile("HxNames*")
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
		LoadListToDict($dict, $sFile)
	WEnd
	SaveList($dict, "HxNameAllInOne.txt")
EndFunc   ;==>MergAllinOne

Func MergOne($gamename)
	LoadBaseList($HxNamePublic)
	Local $targetname = GetGameName($gamename)
	ConsoleWrite('@@ Debug(' & @ScriptLineNumber & ') : $gamename = ' & $gamename & @CRLF) ;### Debug Console
	ConsoleWrite('@@ Debug(' & @ScriptLineNumber & ') : $targetname = ' & $targetname & @CRLF) ;### Debug Console
	MergList($targetname)
EndFunc   ;==>MergOne

Func MergListAll()
	Local $dir = $GameDataDir
	FileChangeDir($dir)
	Local $hSearch = FileFindFirstFile($KrkrDumpName & "*.txt")
	If $hSearch = -1 Then
		ConsoleWrite('@@ Debug(' & @ScriptLineNumber & ') : EMPTY = ' & $dir & @CRLF)
		FileClose($hSearch)
		Return
	EndIf

	While 1
		Local $sFile = FileFindNextFile($hSearch)
		If @error Then ExitLoop
		If @extended Then ContinueLoop
		Local $targetname = GetGameNameFromDumpName($sFile)
		ConsoleWrite('@@ Debug(' & @ScriptLineNumber & ') : $sFile = ' & $sFile & @CRLF) ;### Debug Console
		ConsoleWrite('@@ Debug(' & @ScriptLineNumber & ') : $targetname = ' & $targetname & @CRLF) ;### Debug Console
		MergList($targetname)
	WEnd
EndFunc   ;==>MergListAll

Func MergList($gamename)
	Local $base = $HxNameGarbroBase & $gamename & ".txt"
	Local $dest = $HxNameBase & $gamename & "_out.txt"
	If FileExists($HxNameGarbroBase & $gamename & "_out.txt") Then FileMove($HxNameGarbroBase & $gamename & "_out.txt", $dest, 8 + 1)

	Local $fold = $HxNameBase & $gamename & "_old.txt"
	If FileExists($HxNameGarbroBase & $gamename & "_old.txt") Then FileMove($HxNameGarbroBase & $gamename & "_old.txt", $fold, 8 + 1)

	Local $dump = $HxNameBase & $gamename & ".txt"
	Local $dumx = $HxNameBase & $gamename & ".prev"

	Local $dict = ObjCreate('Scripting.Dictionary')
	LoadListToDict($dict, $base)
	LoadListToDict($dict, $fold)
	LoadListToDict($dict, $dest)
	LoadListToDict($dict, $dump)
	SaveList($dict, $dest)
	FileMove($base, $fold, 8 + 1)
	FileMove($dest, $base, 8 + 1)
	FileMove($dump, $dumx, 8 + 1)
EndFunc   ;==>MergList
Func LoadBaseList($file)
	ConsoleWrite('LoadBaseList => ' & $file & @CRLF) ;### Debug Console
	$dict2 = ObjCreate('Scripting.Dictionary')
	
	Local $lines = ReadToArray($file, 256)
	For $i = 0 To UBound($lines) - 1
		Local $k = StringStripWS($lines[$i], 1 + 2)
		If $k = "" Then ContinueLoop
		If $dict2.exists($k) Then ContinueLoop
		$dict2.add($k, 1)
	Next
EndFunc   ;==>LoadBaseList
Func LoadListToDict($dict, $file)
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
		If $dict2.exists($key) Then ContinueLoop
		If $dict.exists($key) Then ContinueLoop
		$dict.add($key, 1)
	Next
	ConsoleWrite("LoadList => Add " & $dict.Count - $lastcount & " of " & $count & " Lines " & @CRLF)
	Return $dict
EndFunc   ;==>LoadListToDict
Func SaveList($dict, $dest = "R:\HxNames.lst")
	ConsoleWrite('SaveList => ' & $dest & @CRLF) ;### Debug Console
	Local $lines = $dict.Keys
	SortNameHash($lines)
	WriteArray($dest, $lines)
EndFunc   ;==>SaveList
Func SaveBaseList($dest = "R:\HxNames.lst")
	ConsoleWrite('SaveBaseList => ' & $dest & @CRLF) ;### Debug Console
	Local $lines = $dict2.Keys
	SortNameHash($lines)
	WriteArray($dest, $lines)
EndFunc   ;==>SaveBaseList
Func SortNameHash(ByRef $array)
	ConsoleWrite('SortNameHash Start' & @CRLF) ;### Debug Console
	
	Local $count = UBound($array)
	
	ConsoleWrite('SortNameHash -> ' & $count & " Lines" & @CRLF) ;### Debug Console
	
	Local $ar[$count][2]
	For $i = 0 To $count - 1
		Local $sp = StringSplit($array[$i], ":")
		Switch StringLen($sp[1])
			Case 16
				$ar[$i][0] = "0|" & $sp[2]

			Case 64
				$ar[$i][0] = "1|" & $sp[2]

			Case Else
				MsgBox(0, 0, $array[$i])
		EndSwitch
		$ar[$i][1] = $sp[1]
	Next
	_ArraySort($ar, 0, 0, 0, 0)
	For $i = 0 To $count - 1
		$array[$i] = $ar[$i][1] & ":" & StringTrimLeft($ar[$i][0], 2)
	Next
	ConsoleWrite('SortNameHash End' & @CRLF) ;### Debug Console
	Return $array
EndFunc   ;==>SortNameHash

Func WriteArray($dest, $array)
	ConsoleWrite('WriteArray => ' & $dest & @CRLF) ;### Debug Console
	Local $hf = FileOpen($dest, 2 + 256)
	Local $count = UBound($array)
	ConsoleWrite('WriteArray => ' & $count & " Lines" & @CRLF) ;### Debug Console

	For $i = 0 To $count - 1
		FileWriteLine($hf, $array[$i])
	Next
	FileClose($hf)
EndFunc   ;==>WriteArray
Func ReadToArray($file, $enc = 0)
	Local $ar[0]
	Local $hf = FileOpen($file, $enc)
	If $hf = -1 Then
		FileClose($hf)
		Return SetError(@error, 1, $ar)
	EndIf
	Local $lines = FileReadtoArray($hf)
	If @error Then
		FileClose($hf)
		Return SetError(@error, 2, $ar)
	EndIf
	FileClose($hf)
	Return $lines
EndFunc   ;==>ReadToArray
