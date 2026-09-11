#AutoIt3Wrapper_AU3Check_Parameters=-q -d -w 1 -w 2 -w 3 -w 4 -w 5 -w 6
#include-once

Global $KrkrDumpRoot = "E:\WIN\KrkrDump\KrkrDumpBootstrap"
Global Const $GarbroPath = "E:\WIN\GARbro-mod\bin\Debug"
Global Const $GameDataDir = $GarbroPath & "\GameData"

Global Const $gamemapini = $KrkrDumpRoot & "\infos\GameMap.ini"
Global Const $HxNamePublic = $GameDataDir & "\HxNames.lst"

Global Const $tail = "D:\tools\Git\usr\bin\tail.exe"

Global Const $leproc = $KrkrDumpRoot & "\Locale.Emulator\LEProc.exe"
Global Const $leguid = "-runas 761cc51c-8d4b-4569-b25c-bcfe1e5104ec"

Global Const $KrkrDumpbinpath = $KrkrDumpRoot & "\bin"
Global Const $KrkrDumplog = "KrkrDump.log"
Global Const $KrkrDumpdll = "KrkrDump.dll"
Global Const $KrkrDumpcfg = "KrkrDump.json"
Global Const $KrkrDumpexe = "KrkrDumpLoader.exe"
Global Const $KrkrDumpName = "HxNamesKrkrDump_"
Global Const $HxNameGarbro = "HxNames_"
Global Const $HxInfoName = ".HxCryptInfo.ini"
Global Const $CxOrderName = "CxdecOrder.bin"
Global Const $CxTableName = "CxdecTable.bin"
Global Const $HxNameBase = $GameDataDir & "\KrkrDump\" & $KrkrDumpName
Global Const $HxNameGarbroBase = $GameDataDir & "\" & $HxNameGarbro
