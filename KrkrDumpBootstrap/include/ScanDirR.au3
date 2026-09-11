Func _ScanDirR($idd, $callback)
	Local $hS = FileFindFirstFile($idd & "\*")
	If $hS = -1 Then
	Else
		While 1
			Local $sF = FileFindNextFile($hS)
			If @error Then ExitLoop
			If @extended Then
				_ScanDirR($idd & "\" & $sF, $callback)
				ContinueLoop
			EndIf
;~ 			ConsoleWrite('FileName = ' & $sF & @CRLF) ;### Debug Console
			$callback($idd & "\" & $sF)
		WEnd
	EndIf
EndFunc   ;==>_ScanDirR