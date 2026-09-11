#include-once
#include"config.au3"


Func GetGameName($gamename)
	Local $targetname = IniRead($gamemapini, "gamemap", $gamename, "null")
	If $targetname = "null" Then
		IniWrite($gamemapini, "gamemap", $gamename, $gamename)
		$targetname = $gamename
	EndIf
	Return $targetname
EndFunc   ;==>GetGameName


Func GetGameNameFromDumpName($name)
	Local $gamename = StringTrimRight(StringTrimLeft($name, StringLen($KrkrDumpName)), 4)
	Return GetGameName($gamename)
EndFunc   ;==>GetGameNameFromDumpName
