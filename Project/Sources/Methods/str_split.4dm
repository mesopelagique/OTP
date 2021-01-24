//%attributes = {"invisible":true}

#DECLARE ($text : Text; $size : Integer)->$splitted : Collection

$splitted:=New collection:C1472()

C_LONGINT:C283($begin; $limit)
$begin:=1
$limit:=(Length:C16($text)+1)
While (($begin+$size)<=$limit)
	$splitted.push(Substring:C12($text; $begin; $size))
	$begin:=$begin+$size
End while 

