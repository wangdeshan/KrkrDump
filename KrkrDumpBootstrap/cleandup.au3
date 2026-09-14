#include <crypt.au3>
#include <KrkrDump.au3>

Func md5($path)
	Return StringLower(StringTrimLeft(_Crypt_HashFile($path, $CALG_MD5), 2))
EndFunc   ;==>md5

Global $size_dict = ObjCreate('Scripting.Dictionary')
Global $hash_dict = ObjCreate('Scripting.Dictionary')

Global $scanedlist = FileOpen("R:\krdlist.txt", 2 + 128)

FileMove("R:\duplic.txt", "R:\duplic.old.txt", 1 + 8)
Global $duplist = FileOpen("R:\duplic.txt", 2 + 128)

Switch 3
	Case 0
		ScanDir("D:\user\Downloads\aria2-download\dav\妙啊")
		ScanDir("D:\Desktop\twi\gallery-dl")
		ScanDir("G:\Download\user", "G:\dup\user")
		ScanDir("D:\user\Downloads\aria2-download\dav\Download\user", "D:\dup\biliuser")
		ScanDir("D:\user\Pictures", "D:\dup\Pictures")
	Case 1
		Global $basepath = "I:\ryuu\瑠璃櫻"
		ScanDir($basepath & "\KrkrDump")
		ScanDir($basepath & "\KrkrDump0", "r:\KrkrDump_dup")
;~ 		ScanDir("I:\DC\DC5\KrkrDump", "r:\KrkrDump_dup")
;~ 		ScanDir("I:\DC\DC5FL\KrkrDump", "r:\KrkrDump_dup")
;~ 		ScanDir("I:\DC\DC5PH_M\KrkrDump", "r:\KrkrDump_dup")
	Case 3
		ScanDir("W:\とける風花とシロうさぎ")
		ScanDir("R:\新建文件夹", "r:\KrkrDump_dup")

EndSwitch
FileClose($scanedlist)
;~ ExtractByList("R:\krdlist.txt")
ShellExecute("R:\duplic.txt")
Func ScanDir($dir, $out = "")
;~ 	ConsoleWrite('@@ Debug(' & @ScriptLineNumber & ') : $dir = ' & $dir & @CRLF) ;### Debug Console
;~ 	ConsoleWrite('@@ Debug(' & @ScriptLineNumber & ') : $out = ' & $out & @CRLF) ;### Debug Console
	If Not FileExists($dir) Then Return
	FileChangeDir($dir)
	Local $hSearch = FileFindFirstFile("*.*")
	If $hSearch = -1 Then
		ConsoleWrite('@@ Debug(' & @ScriptLineNumber & ') : EMPTY = ' & $dir & @CRLF) ;### Debug Console
;~ 		MsgBox(4096, "错误", "没有文件/目录 匹配搜索")
;~ 		Exit
	EndIf
	
	While 1
		Local $sFile = FileFindNextFile($hSearch)
		If @error Then ExitLoop
		If @extended Then
			Local $zout = ""
			If $out <> "" Then $zout = $out & "\" & $sFile
			ScanDir($dir & "\" & $sFile, $zout)
			ContinueLoop
		EndIf
		FileWriteLine($scanedlist, $sFile)
		
		Local $res = ScanFile($dir & "\" & $sFile)
		If $res And $out <> "" Then
			ConsoleWrite('@@ Debug(' & @ScriptLineNumber & ') : $sFile = ' & $dir & "\" & $sFile & @CRLF) ;### Debug Console
			ConsoleWrite('@@ Debug(' & @ScriptLineNumber & ') : $res = ' & $res & @CRLF) ;### Debug Console
			FileWriteLine($duplist, $res & "->" & $out & "\" & $sFile)

			FileMove($dir & "\" & $sFile, $out & "\" & $sFile, 8)
		EndIf
	WEnd
	FileClose($hSearch)
EndFunc   ;==>ScanDir
Func ScanFile($path, $rname = True)
	Local $size = FileGetSize($path)
	Local $ks = "K" & $size
	If Not $size_dict.exists($ks) Then
		$size_dict.add($ks, $path)
		Return False
	EndIf
	
	Local $p1 = $size_dict.Item($ks)
	Local $hash
	Local $kh
	If $p1 <> "dummy" Then
		$size_dict.Item($ks) = "dummy"
		$hash = md5($p1)
		$kh = $ks & "_" & $hash
		$hash_dict.add($kh, $p1)
	EndIf
	$hash = md5($path)
	$kh = $ks & "_" & $hash
	If $hash_dict.exists($kh) Then
;~ 			$hash_dict.Item($kh) &= "|" & $path
		If $rname Then Return $hash_dict.Item($kh)
		Return True
	Else
		$hash_dict.add($kh, $path)
		Return False
	EndIf

	
EndFunc   ;==>ScanFile
