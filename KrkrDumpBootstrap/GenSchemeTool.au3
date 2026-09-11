#AutoIt3Wrapper_AU3Check_Parameters=-q -d -w 1 -w 2 -w 3 -w 4 -w 5 -w 6

#include<config.au3>

#include<array.au3>

FileChangeDir(@ScriptDir)

Global $ini = "E:\DC\DC5\DC5.HxCryptInfo.ini"
Const $Compiler = @ScriptDir & "\SchemeTool\Roslyn\csc.exe"
Const $reference[] = ["GameRes.dll", "ArcFormats.dll"]

If $cmdline[0] Then $ini = FileGetLongName($cmdline[1])

Global $Gname = IniRead($ini, "GameInfo", "Name", "HxCrypt")

Global $CS = "SchemeTool\SchemeTool." & $Gname & ".cs"
Global $EX = "SchemeTool." & $Gname & ".exe"
GenSchemeToolCs($ini, $CS)
CompileSchemeTool($CS, $EX)

Func CompileSchemeTool($source = "SchemeTool\SchemeTool.cs", $outname = "SchemeTool.HxCrypt.exe")
	If Not CheckGarbroPath() Then Return
	Local $cmd = StringFormat('"%s" "%s" -out:"%s\%s"', $Compiler, $source, $GarbroPath, $outname)
	For $r In $reference
		$cmd &= StringFormat(' -reference:"%s\%s"', $GarbroPath, $r)
	Next
	ConsoleWrite('@@ Debug(' & @ScriptLineNumber & ') : $cmd = ' & $cmd & @CRLF) ;### Debug Console
	RunWait($cmd)
EndFunc   ;==>CompileSchemeTool
Func CheckGarbroPath()
	For $r In $reference
		If FileGetSize($GarbroPath & "\" & $r) = 0 Then
			ConsoleWrite('@@ Debug(' & @ScriptLineNumber & ') : $r = ' & $r & @CRLF) ;### Debug Console
			Return False
		EndIf
	Next
	If FileGetSize($GarbroPath & "\GameData\Formats.orig.dat") = 0 Then
		If FileGetSize($GarbroPath & "\GameData\Formats.dat") = 0 Then
			Return False
		EndIf
		If FileCopy($GarbroPath & "\GameData\Formats.dat", $GarbroPath & "\GameData\Formats.orig.dat") = 0 Then
			Return False
		EndIf
	EndIf
	Return True
EndFunc   ;==>CheckGarbroPath
Func GenSchemeToolCs($ini = "KrkrDump.HxCryptInfo.ini", $out = "SchemeTool\SchemeTool.cs")
	Local $arcs = IniReadSection($ini, "Archives")
;~  _ArrayDisplay($arcs)
	Local $keys[$arcs[0][0] + 1][3] = [[$arcs[0][0]]]
	For $i = 1 To $arcs[0][0]
		Local $arc = $arcs[$i][0]
		Local $sp = StringSplit($arcs[$i][1], ",")
		$keys[$i][0] = $arc
		$keys[$i][1] = $sp[1]
		$keys[$i][2] = $sp[2]
	Next
;~ 	_ArrayDisplay($arcs)
	Local $mx = 0
	Local $mk = $arcs[1][1]
	Local $mki = 1
	Local $hash_dict = ObjCreate('Scripting.Dictionary')
	For $i = 1 To $arcs[0][0]
		Local $key = $arcs[$i][1]
		If $hash_dict.exists($key) Then
			$hash_dict.Item($key) += 1
		Else
			$hash_dict.add($key, 1)
		EndIf
		If $hash_dict.Item($key) > $mx Then
			$mx = $hash_dict.Item($key)
			$mk = $key
			$mki = $i
		EndIf
	Next
	ConsoleWrite('@@ Debug(' & @ScriptLineNumber & ') : $mx = ' & $mx & @CRLF) ;### Debug Console
	ConsoleWrite('@@ Debug(' & @ScriptLineNumber & ') : $mk = ' & $mk & @CRLF) ;### Debug Console

	Local $hf = FileOpen($out, 2)
	Local $Mask = IniRead($ini, "FilterInfo", "Mask", "0x000")
	Local $Offset = IniRead($ini, "FilterInfo", "Offset", "0x000")
	Local $name = IniRead($ini, "GameInfo", "Name", "[" & $Mask & "," & $Offset & "]")
	Local $exename = IniRead($ini, "GameInfo", "ExeName", $name)
	Local $oldname = IniRead($ini, "GameInfo", "OldName", "")
	Local $newname = IniRead($ini, "GameInfo", "NewName", "")
	Local $HxNamesList = IniRead($ini, "GameInfo", "HxNamesList", "")

	FileWriteLine($hf, 'using System;')
	FileWriteLine($hf, 'using System.Collections.Generic;')
	FileWriteLine($hf, 'using System.IO;')
	FileWriteLine($hf, 'using System.Linq;')
	FileWriteLine($hf, 'using System.Runtime.InteropServices;')
	FileWriteLine($hf, 'using System.Text;')
	FileWriteLine($hf, 'using System.Threading.Tasks;')
	FileWriteLine($hf, 'namespace SchemeTool')
	FileWriteLine($hf, '{')
	FileWriteLine($hf, '    class Program')
	FileWriteLine($hf, '    {')
	FileWriteLine($hf, '        public static byte[] HexStringToByteArray(string hexString)')
	FileWriteLine($hf, '        {')
	FileWriteLine($hf, '            hexString = hexString.Replace(" ", "").Replace(",", "");')
	FileWriteLine($hf, '            if (hexString.Length % 2 != 0)')
	FileWriteLine($hf, '                throw new ArgumentException("Hex string must have an even length.");')
	FileWriteLine($hf, '            byte[] returnBytes = new byte[hexString.Length / 2];')
	FileWriteLine($hf, '            for (int i = 0; i < returnBytes.Length; i++)')
	FileWriteLine($hf, '                returnBytes[i] = Convert.ToByte(hexString.Substring(i * 2, 2), 16);')
	FileWriteLine($hf, '            return returnBytes;')
	FileWriteLine($hf, '        }')
	FileWriteLine($hf, '        public static uint[] ByteArrayToUintArray(byte[] byteArray)')
	FileWriteLine($hf, '        {')
	FileWriteLine($hf, '            if (byteArray.Length % 4 != 0)')
	FileWriteLine($hf, '            {')
	FileWriteLine($hf, '                throw new ArgumentException("The length of byteArray must be a multiple of 4.");')
	FileWriteLine($hf, '            }')
	FileWriteLine($hf, '            int uintArrayLength = byteArray.Length / 4;')
	FileWriteLine($hf, '            uint[] uintArray = new uint[uintArrayLength];')
	FileWriteLine($hf, '            Buffer.BlockCopy(byteArray, 0, uintArray, 0, byteArray.Length);')
	FileWriteLine($hf, '            return uintArray;')
	FileWriteLine($hf, '        }')
	FileWriteLine($hf, '        public static void RenameKey<TKey, TValue>(Dictionary<TKey, TValue> dictionary, TKey oldKey, TKey newKey)')
	FileWriteLine($hf, '        {')
	FileWriteLine($hf, '            if (dictionary.ContainsKey(oldKey) && !dictionary.ContainsKey(newKey))')
	FileWriteLine($hf, '            {')
	FileWriteLine($hf, '                TValue value = dictionary[oldKey];')
	FileWriteLine($hf, '                dictionary.Remove(oldKey);')
	FileWriteLine($hf, '                dictionary.Add(newKey, value);')
	FileWriteLine($hf, '            }')
	FileWriteLine($hf, '        }')
	FileWriteLine($hf, '')
	FileWriteLine($hf, '        static void Main(string[] args)')
	FileWriteLine($hf, '        {')
	FileWriteLine($hf, '            Console.WriteLine("Add Scheme KiriKiri HxCrypt_' & $name & '");')
	FileWriteLine($hf, '            using (Stream stream = File.OpenRead(".\\GameData\\Formats.orig.dat"))')
	FileWriteLine($hf, '            {')
	FileWriteLine($hf, '                GameRes.FormatCatalog.Instance.DeserializeScheme(stream);')
	FileWriteLine($hf, '            }')
	FileWriteLine($hf, '')
	FileWriteLine($hf, '            GameRes.Formats.KiriKiri.Xp3Opener format = GameRes.FormatCatalog.Instance.ArcFormats')
	FileWriteLine($hf, '                .FirstOrDefault(a => a is GameRes.Formats.KiriKiri.Xp3Opener) as GameRes.Formats.KiriKiri.Xp3Opener;')
	FileWriteLine($hf, '            if (format != null)')
	FileWriteLine($hf, '            {')
	FileWriteLine($hf, '                GameRes.Formats.KiriKiri.Xp3Scheme scheme = format.Scheme as GameRes.Formats.KiriKiri.Xp3Scheme;')
	FileWriteLine($hf, '')
	FileWriteLine($hf, "                var CxScheme = new GameRes.Formats.KiriKiri.CxScheme")
	FileWriteLine($hf, '                {')
	FileWriteLine($hf, '                    Mask   = ' & $Mask & ',')
	FileWriteLine($hf, '                    Offset = ' & IniRead($ini, "FilterInfo", "Offset", "0x000") & ',')
	FileWriteLine($hf, '                    PrologOrder = new byte[] { ' & IniRead($ini, "FilterInfo", "PrologOrder", "0,1,2") & ' },')
	FileWriteLine($hf, '                    OddBranchOrder = new byte[] { ' & IniRead($ini, "FilterInfo", "OddBranchOrder", "0,1,2,3,4,5") & ' },')
	FileWriteLine($hf, '                    EvenBranchOrder = new byte[] { ' & IniRead($ini, "FilterInfo", "EvenBranchOrder", "0,1,2,3,4,5,6,7") & ' },')
	FileWriteLine($hf, '                    ControlBlock = ByteArrayToUintArray(HexStringToByteArray("' & IniRead($ini, "FilterInfo", "ControlBlock", "") & '"))')
	FileWriteLine($hf, '                };')
	FileWriteLine($hf, '')
	FileWriteLine($hf, "                GameRes.Formats.KiriKiri.HxCrypt crypt = new GameRes.Formats.KiriKiri.HxCrypt(CxScheme)")
	FileWriteLine($hf, '                {')
	FileWriteLine($hf, '                    RandomType  = ' & IniRead($ini, "FilterInfo", "RandomType", "0") & ',')
	FileWriteLine($hf, '                    FilterKey   = ' & IniRead($ini, "FilterInfo", "FilterKey", "0x0000000000000000") & ',')
	FileWriteLine($hf, '                    IndexKey1 = HexStringToByteArray("' & $keys[$mki][1] & '"),')
	FileWriteLine($hf, '                    IndexKey2 = HexStringToByteArray("' & $keys[$mki][2] & '")')
	FileWriteLine($hf, '                };')
	If $mx < $arcs[0][0] Then
		FileWriteLine($hf, "                var IndexKeyDict = new Dictionary<string, GameRes.Formats.KiriKiri.HxIndexKey>();")
		For $i = 1 To $arcs[0][0]
			If $arcs[$i][1] = $mk Then ContinueLoop
			FileWriteLine($hf, '                IndexKeyDict["' & $arcs[$i][0] & '"]=  new GameRes.Formats.KiriKiri.HxIndexKey')
			FileWriteLine($hf, '                {')
			FileWriteLine($hf, '                    Key1 = HexStringToByteArray("' & $keys[$i][1] & '"),')
			FileWriteLine($hf, '                    Key2 = HexStringToByteArray("' & $keys[$i][2] & '")')
			FileWriteLine($hf, '                };')
		Next
		FileWriteLine($hf, "                crypt.IndexKeyDict = IndexKeyDict;")
	EndIf
	If $HxNamesList <> "" Then
		FileWriteLine($hf, '                crypt.NamesFile = "' & $HxNamesList & '";')
	Else
		FileWriteLine($hf, '                crypt.NamesFile = "HxNames_' & $name & '.txt";')
	EndIf
	FileWriteLine($hf, '                scheme.KnownSchemes.Remove("HxCrypt_' & $name & '");')
	FileWriteLine($hf, '                scheme.KnownSchemes.Add("HxCrypt_' & $name & '", crypt);')
	FileWriteLine($hf, '')
	FileWriteLine($hf, '            }')
	FileWriteLine($hf, '            var gameMap = typeof(GameRes.FormatCatalog).GetField("m_game_map", System.Reflection.BindingFlags.Instance | System.Reflection.BindingFlags.NonPublic)')
	FileWriteLine($hf, '                .GetValue(GameRes.FormatCatalog.Instance) as Dictionary<string, string>;')
	FileWriteLine($hf, '            if (gameMap != null)')
	FileWriteLine($hf, '            {')
;~ 	FileWriteLine($hf, '                // gameMap["game.exe"] = "HxCrypt_' & $name & '";')
;~ 	FileWriteLine($hf, '                // RenameKey(gameMap,"game_old.exe", "game_new.exe");')
;~ 	FileWriteLine($hf, '                // gameMap.Add("game.exe", "HxCrypt_Scheme");')
	Local $sp = StringSplit($exename, "|")
	$exename = $sp[1]
	
	If $oldname <> "" And $newname <> "" Then
		FileWriteLine($hf, '                RenameKey(gameMap,"' & $exename & '", "' & $oldname & '");')
		FileWriteLine($hf, '                gameMap.Remove("' & $newname & '");')
		FileWriteLine($hf, '                gameMap.Add("' & $newname & '", "HxCrypt_' & $name & '");')
	Else
		FileWriteLine($hf, '                gameMap.Remove("' & $exename & '");')
		FileWriteLine($hf, '                gameMap.Add("' & $exename & '", "HxCrypt_' & $name & '");')
	EndIf
	If $sp[0] > 1 Then
		For $i = 2 To $sp[0]
			FileWriteLine($hf, '                gameMap.Remove("' & $sp[$i] & '");')
			FileWriteLine($hf, '                gameMap.Add("' & $sp[$i] & '", "HxCrypt_' & $name & '");')
		Next
	EndIf
	FileWriteLine($hf, '            }')
	FileWriteLine($hf, '            using (Stream stream = File.Create(".\\GameData\\Formats.dat"))')
	FileWriteLine($hf, '            {')
	FileWriteLine($hf, '                GameRes.FormatCatalog.Instance.SerializeScheme(stream);')
	FileWriteLine($hf, '            }')
	FileWriteLine($hf, '        }')
	FileWriteLine($hf, '    }')
	FileWriteLine($hf, '}')
	FileClose($hf)
EndFunc   ;==>GenSchemeToolCs


