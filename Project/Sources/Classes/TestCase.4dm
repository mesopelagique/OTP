
Class constructor
	This:C1470.functions:=New collection:C1472()  // CANNOT FIND autommatically test_ functions by name or annotation using 4d
	
Function beforeClass
	
Function afterClass
	
Function beforeTest
	
Function afterTest
	
Function run()
	This:C1470.beforeClass()
	var $function : Object
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
		$message:="'"+This:C1470._toString($1)+"' not equals to expected '"+This:C1470._toString($2)+"'"
	End if 
	If (Asserted:C1132(Value type:C1509($1)=Value type:C1509($2); $message))
		ASSERT:C1129($1=$2; $message)  // work only with primitive type, method must be enhanced for col or object etc...
	End if 
	
Function _toString($var : Variant)->$result : Text
	Case of 
		: (Value type:C1509($var)=Is collection:K8:32)
			$result:=JSON Stringify:C1217($var)
		: (Value type:C1509($var)=Is object:K8:27)
			$result:=JSON Stringify:C1217($var)
		Else 
			$result:=String:C10($var)
	End case 
	
	