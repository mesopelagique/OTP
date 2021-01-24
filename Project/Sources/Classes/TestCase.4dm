
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
		$message:="'"+This:C1470._toString($2)+"' not equals to expected '"+This:C1470._toString($1)+"'"
	End if 
	
	Case of 
		: (Value type:C1509($1)=Is object:K8:27)
			ASSERT:C1129(Value type:C1509($2)=Is object:K8:27; $message)
			ASSERT:C1129(New collection:C1472($1).equal(New collection:C1472($2)); $message)
		: (Value type:C1509($2)=Is object:K8:27)
			ASSERT:C1129(False:C215; $message)
		: (Value type:C1509($1)=Is collection:K8:32)
			ASSERT:C1129(Value type:C1509($2)=Is collection:K8:32)
			ASSERT:C1129($1.equal($2); $message)
		: (Value type:C1509($2)=Is collection:K8:32)
			ASSERT:C1129(False:C215; $message)
		Else 
			ASSERT:C1129($1=$2; $message)
	End case 
	
	
Function _toString($var : Variant)->$result : Text
	Case of 
		: (Value type:C1509($var)=Is collection:K8:32)
			$result:=JSON Stringify:C1217($var)
		: (Value type:C1509($var)=Is object:K8:27)
			$result:=JSON Stringify:C1217($var)
		: (Value type:C1509($var)=Is BLOB:K8:12)
			$result:="Blob[size="+String:C10(BLOB size:C605($var))+",utf8"+BLOB to text:C555($var; UTF8 text without length:K22:17)+"]"
		Else 
			$result:=String:C10($var)
	End case 
	
	