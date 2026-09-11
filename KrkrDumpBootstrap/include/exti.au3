#AutoIt3Wrapper_AU3Check_Parameters=-q -d -w 1 -w 2 -w 3 -w 4 -w 5 -w 6
#include <Array.au3>
#include <File.au3>
#include "ScanDirR.au3"
#include "KrkrDump.au3"

Global $listf = "R:\krdlist.txt"
Global $hf = FileOpen($listf, 2)
Global $dict = ObjCreate('Scripting.Dictionary')

_ScanDirR("Y:\TenShiSouZou_R18\KrkrDump", addtolist)
FileClose($hf)
ExtractByList($listf)

Func addtolist($in)
	Local $l = StringLower(StringRight($in, 4))
	If $l = ".ogg" Then Return
	If $l = ".sli" Then Return
	$l = StringLower(StringRight($in, 5))
	If $l = ".opus" Then Return
	$l = StringLower(StringRight($in, 7))
	If $l = ".struct" Then Return
	$l = StringLower(StringRight($in, 8))
	If $l = ".struct2" Then Return
	If $l = ".tlg.png" Then Return

;~ 	If FileExists($in & ".struct") Then Return
;~ 	If FileExists($in & ".struct2") Then Return
	Local $d, $p, $n, $x
	_PathSplit($in, $d, $p, $n, $x)
	Local $fpath = $p & $n & $x
	Local $s = $n
	$s = StringReplace($s, "_cn", "")
	$s = StringReplace($s, "_en", "")
	$s = StringReplace($s, "_tw", "")
	$s = StringReplace($s, "_jp", "")
	$s = StringReplace($s, "cn_", "")
	$s = StringReplace($s, "en_", "")
	$s = StringReplace($s, "tw_", "")
	$s = StringReplace($s, "jp_", "")
	If $dict.exists($s) Then Return

	ConsoleWrite('@@ Debug(' & @ScriptLineNumber & ') : $fpath = ' & $fpath & @CRLF) ;### Debug Console
	ConsoleWrite('@@ Debug(' & @ScriptLineNumber & ') : $s = ' & $s & @CRLF) ;### Debug Console
	FileWriteLine($hf, $s & "_cn" & $x)
	FileWriteLine($hf, $s & "_en" & $x)
	FileWriteLine($hf, $s & "_jp" & $x)
	FileWriteLine($hf, $s & "_tw" & $x)
	FileWriteLine($hf, "cn_" & $s & $x)
	FileWriteLine($hf, "en_" & $s & $x)
	FileWriteLine($hf, "jp_" & $s & $x)
	FileWriteLine($hf, "tw_" & $s & $x)
	FileWriteLine($hf, $s & $x)
EndFunc   ;==>addtolist
