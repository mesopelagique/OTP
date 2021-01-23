//%attributes = {}

var $className : Text
var $cs : Object

$cs:=cs:C1710  // could comme from parameters if using external component

For each ($className; $cs)
	If ($cs[$className].superclass#Null:C1517)
		If ($cs[$className].superclass.name=$cs.TestCase.name)  // work only at one level, no abstract class
			$cs[$className].new().run()
		End if 
	End if 
End for each 