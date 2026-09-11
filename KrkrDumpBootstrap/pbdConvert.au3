#AutoIt3Wrapper_AU3Check_Parameters=-q -d -w 1 -w 2 -w 3 -w 4 -w 5 -w 6
#include <Array.au3>
#include "include\ScanDirR.au3"

If @ScriptName = 'pbdConvert.au3' Then
	Global $array[] = [0]
	pbdConvertmain()
	_ArrayDisplay($array)
EndIf

Func pbdConvertmain()
	_ScanDirR("Y:\TenShiSouZou_R18\KrkrDump", addtolist)
	BatchConvertPBDbyList($array)
EndFunc   ;==>pbdConvertmain

Func addtolist($in)
	If StringLower(StringRight($in, 4)) <> ".pbd" Then Return
	If FileExists($in & ".struct") Then Return
	If FileExists($in & ".struct2") Then Return

	_ArrayAdd($array, $in)
	$array[0] += 1
EndFunc   ;==>addtolist
Func BatchConvertPBDbyList($array)
	Local $thdr = FileRead("E:\WIN\KrkrDump\KrkrDumpBootstrap\pbd2json\pbd2convert.tjs")
	Local $tlist = ""
	If IsArray($array) Then
;~ 		_ArrayDisplay($array)
		For $i = 1 To $array[0]
			$tlist &= @CRLF & 'convertpbd("' & $array[$i] & '");'
		Next
	Else
;~ 		ConsoleWrite('@@ Debug(' & @ScriptLineNumber & ') : $array = ' & $array & @CRLF) ;### Debug Console
		$tlist = @CRLF & 'convertpbd("' & $array & '");'
	EndIf

	If $tlist = "" Then Return
	$tlist = StringReplace($tlist, "\", "/")

	Local $of = FileOpen("R:\pbd2json\startup.tjs", 2 + 8 + 128)
	FileWrite($of, $thdr)
	FileWrite($of, $tlist)
	FileClose($of)
	RunWait("E:\WIN\KrkrDump\KrkrDumpBootstrap\pbd2json\tvpwin32.exe" & ' ' & "R:\pbd2json")
EndFunc   ;==>BatchConvertPBDbyList

Func convertPBD($fn, $fn2 = '')
	Local $jsonstr = FileRead($fn)
	If Not StringInStr($jsonstr, "layer_type") Then Return SetError(1, 0, "")
	Local $oScript = ObjCreate("MSScriptControl.ScriptControl.1")
	$oScript.language = 'JavaScript'
	Local $sc = ''
	$sc &= 'function main(json) {                     ' & @CRLF
	$sc &= '    var txt = "layer_type\tname\tleft\ttop\twidth\theight\ttype\topacity\tvisible\tlayer_id\tgroup_layer_id\tbase\timages";' & @CRLF
	$sc &= '    var keys = txt.split("\t");           ' & @CRLF
	$sc &= '    txt = "#"+txt+"\t\r\n";               ' & @CRLF
	$sc &= '    var oj = eval(json);                  ' & @CRLF
	$sc &= '    for (var i = 0; i < oj.length; i++) { ' & @CRLF
	$sc &= '        var lyr = oj[i];                  ' & @CRLF
	$sc &= '        for (var ik = 0; ik < keys.length; ik++) {' & @CRLF
	$sc &= '            if (typeof lyr[keys[ik]] == "undefined") {' & @CRLF
	$sc &= '                txt += "\t";              ' & @CRLF
	$sc &= '            } else {                      ' & @CRLF
	$sc &= '                txt += lyr[keys[ik]] + "\t";' & @CRLF
	$sc &= '            }                             ' & @CRLF
	$sc &= '        }                                 ' & @CRLF
	$sc &= '        txt += "\r\n";                    ' & @CRLF
	$sc &= '    }                                     ' & @CRLF
	$sc &= '    return txt                            ' & @CRLF
	$sc &= '}'
	$oScript.AddCode($sc)

	Local $TK = $oScript.Run('main', "(" & $jsonstr & ")")
	If $fn2 <> '' Then
		Local $of = FileOpen($fn2, 2)
		FileWrite($of, $TK)
		FileClose($of)
	EndIf
	Return $TK
;~ 	RunWait('D:\tools\Nodejs\node.exe "E:\ATRI.My.Dear.Moments\KrkrExtract_Output\fgimage\¥¢¥È¥ê\pbdjson.bat" "' & $fn & '"')
EndFunc   ;==>convertPBD
