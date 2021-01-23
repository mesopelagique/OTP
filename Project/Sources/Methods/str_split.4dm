//%attributes = {}


C_TEXT:C284($1)
C_LONGINT:C283($2)
C_COLLECTION:C1488($0)

$0:=New collection:C1472()

C_TEXT:C284($text)
$text:=$1
C_LONGINT:C283($begin; $end)
$begin:=0
$end:=$2

While ($end<=Length:C16($text))
	$0.append(Substring:C12($text; 0; $2))
	$begin:=$begin+$2
	$end:=$end+$2
End while 

