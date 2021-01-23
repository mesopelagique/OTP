
Class constructor
	This:C1470.functions:=New collection:C1472()  // CANNOT FIND autommatically test_ functions by name or annotation using 4d
	
Function beforeClass
	
Function afterClass
	
Function beforeTest
	
Function afterTest
	
Function run()
	This:C1470.beforeClass()
	For each ($function; This:C1470.functions)
		This:C1470.beforeTest()
		$function.call(This:C1470)
		This:C1470.afterTest()
	End for each 
	This:C1470.afterClass()
	
Function assertEquals
	var $1; $2 : Variant
	var $3; $message : Text
	
	If (Count parameters:C259>2)
		$message:=$3
	Else 
		$message:=""  // TODO default message ie. String or JSONStringify of parameters
	End if 
	If (Asserted:C1132(Value type:C1509($1)=Value type:C1509($2); $message))
		ASSERT:C1129($1=$2; $message)  // work only with primitive type, method must be enhanced for col or object etc...
	End if 