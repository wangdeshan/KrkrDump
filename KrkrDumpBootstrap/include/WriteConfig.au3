Func WriteConfig($ConfigPath, $path = "R:/KrkrDump", $dumpkey = False, $hashnamepath = "R:/KrkrDump.hash.txt")
	If $dumpkey Then
		$dumpkey = "true"
	Else
		$dumpkey = "false"
	EndIf
	Local $Config = ""
	$Config &= '{' & @CRLF
	$Config &= '    "loglevel": 1,' & @CRLF
	$Config &= '    "enableExtract": true,' & @CRLF
	$Config &= '    "enablePatch": true,' & @CRLF
	$Config &= '    "truncateLog": true,' & @CRLF
	$Config &= '    "patchNoProtocol": true,' & @CRLF
	$Config &= '    "patchSbeam": false,' & @CRLF
	$Config &= '    "patchSignatureCheck": true,' & @CRLF
	$Config &= '    "SkipExists": true,' & @CRLF
	$Config &= '    "decryptSimpleCrypt": true,' & @CRLF
	$Config &= '    "dumpHxKey": ' & $dumpkey & ',' & @CRLF
	$Config &= '    "dumpHash": true,' & @CRLF
	$Config &= '    "dumpDir": true,' & @CRLF
	$Config &= '    "outputHxNameHash": "' & StringReplace($hashnamepath, "\", "/") & '",' & @CRLF
	$Config &= '    "outputDirectory": "' & StringReplace($path, "\", "/") & '",' & @CRLF
	$Config &= '    "rules": [' & @CRLF
	$Config &= '        "file://\\./.+?\\.xp3>(.+?\\..+$)",' & @CRLF
	$Config &= '        "archive://./(.+)",' & @CRLF
	$Config &= '        "arc://./(.+)",' & @CRLF
	$Config &= '        "bres://./(.+)"' & @CRLF
	$Config &= '    ],' & @CRLF
	$Config &= '    "patchProtocols": [' & @CRLF
	$Config &= '        "arc://",' & @CRLF
	$Config &= '        "archive://",' & @CRLF
	$Config &= '        "psb://"' & @CRLF
	$Config &= '    ],' & @CRLF
	$Config &= '    "patchArchives": [' & @CRLF
;~ 	$Config &= '        "my_patch.xp3"' & @CRLF
	$Config &= '    ],' & @CRLF
	$Config &= '    "patchDirectory": [' & @CRLF
	$Config &= '        "KrkrPatch",' & @CRLF
	$Config &= '        "raw:' & GetPatchPath() & '"' & @CRLF
	$Config &= '    ],' & @CRLF
	$Config &= '    "includeExtensions": [],' & @CRLF
	$Config &= '    "excludeExtensions": []' & @CRLF
	$Config &= '}'
	Local $fd = FileOpen($ConfigPath, 2)
	FileWrite($fd, $Config)
	FileClose($fd)
EndFunc   ;==>WriteConfig
Func GetPatchPath($ScriptDir = @ScriptDir)
	Local $drive = StringLower(StringLeft($ScriptDir, 1))
	Local $path = StringReplace(StringTrimLeft($ScriptDir, 2), "\", "/")
	Local $ret = "file://./" & $drive & $path & "/krkrpatch"
;~ 	ConsoleWrite('@@ Debug(' & @ScriptLineNumber & ') : $ScriptDir = ' & $ScriptDir & @CRLF) ;### Debug Console
;~ 	ConsoleWrite('@@ Debug(' & @ScriptLineNumber & ') : $drive = ' & $drive & @CRLF) ;### Debug Console
;~ 	ConsoleWrite('@@ Debug(' & @ScriptLineNumber & ') : $path = ' & $path & @CRLF) ;### Debug Console
;~ 	ConsoleWrite($ret & @CRLF) ;### Debug Console
	Return $ret
EndFunc   ;==>GetPatchPath