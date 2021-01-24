//%attributes = {"invisible":true}
var $className : Text
var $cs : Object

$cs:=cs:C1710  // could comme from parameters if using external component

If (Shift down:C543)
	$className:="Test"+Request:C163("test class name")
	$cs[$className].new().run()
Else 
	For each ($className; $cs)
		If ($cs[$className].superclass#Null:C1517)
			If ($cs[$className].superclass.name=$cs.TestCase.name)  // work only at one level, no abstract class
				$cs[$className].new().run()
			End if 
		End if 
	End for each 
End if 