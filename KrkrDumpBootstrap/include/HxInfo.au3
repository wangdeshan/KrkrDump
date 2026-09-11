#include-once
Func ConvertCxOrder($bin, $flag = False)
	Local $f = FileOpen($bin, 16)
	Local $ds = DllStructCreate("align 1;byte order[17];")
	DllStructSetData($ds, 1, FileRead($f))
	FileClose($f)
	Local $tbl[3][8] = [[0, 2, 3, 1, 5, 6, 7, 4],[2, 5, 3, 4, 1, 0],[0, 1, 2]]
	Local $order[3][8]
	Local $x
	For $i = 1 To 8
		$x = DllStructGetData($ds, 1, $i)
		$order[0][$x] = $tbl[0][$i - 1]
	Next
	For $i = 1 To 6
		$x = DllStructGetData($ds, 1, $i + 8)
		$order[1][$x] = $tbl[1][$i - 1]
	Next
	For $i = 1 To 3
		$x = DllStructGetData($ds, 1, $i + 8 + 6)
		$order[2][$x] = $tbl[2][$i - 1]
	Next
	If $flag Then Return $order
	Local $sorder[3]
	Local $s = ""
	For $i = 0 To 7
		$s &= "," & $order[0][$i]
	Next
	$s = StringTrimLeft($s, 1)
	$sorder[0] = $s
	$s = ""
	For $i = 0 To 5
		$s &= "," & $order[1][$i]
	Next
	$s = StringTrimLeft($s, 1)
	$sorder[1] = $s
	$s = ""
	For $i = 0 To 2
		$s &= "," & $order[2][$i]
	Next
	$s = StringTrimLeft($s, 1)
	$sorder[2] = $s
	Return $sorder
EndFunc   ;==>ConvertCxOrder
Func ConvertCxTable($bin)
	Local $f = FileOpen($bin, 16)
	Local $ds = DllStructCreate("align 1;byte order[4096];")
	DllStructSetData($ds, 1, FileRead($f))
	For $i = 1 To 4096
		Local $x = DllStructGetData($ds, 1, $i)
		$x = BitXOR($x, 0xff)
		DllStructSetData($ds, 1, $x, $i)
	Next
	Local $d = StringTrimLeft(String(DllStructGetData($ds, 1)), 2)
	Return $d
EndFunc   ;==>ConvertCxTable