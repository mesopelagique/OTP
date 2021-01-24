//%attributes = {"invisible":true}
//%attributes = {}

C_OBJECT:C1216($1)  // new instance to singletonize
C_OBJECT:C1216($class)
$class:=OB Class:C1730($1)

If ($class.instance=Null:C1517)
	
	Use ($class)
		
		// $class.instance:=OB Copy($1; ck shared)  // work only if no sub obj or col, because this will create a shared ground
		$class.instance:=OB Copy:C1225($1; ck shared:K85:29; $class)
		
		Use ($class)
			$class._new:=This:C1470.new
			$class.new:=Formula:C1597(This:C1470.instance)
		End use 
		
	End use 
	
End if 