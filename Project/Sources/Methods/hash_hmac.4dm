//%attributes = {}
#DECLARE ($algoName : Text; $data : Variant; $secret : Variant)->$hash : Text

C_BLOB:C604($outerKey; $innerKey; $b)
C_LONGINT:C283($blockSize; $i; $byte; $algo)

C_BLOB:C604($key; $message)

Case of 
		
		//________________________________________
	: (Value type:C1509($secret)=Is text:K8:3)
		
		TEXT TO BLOB:C554($secret; $key; UTF8 text without length:K22:17)
		
		//________________________________________
	: (Value type:C1509($secret)=Is BLOB:K8:12)
		
		$key:=$secret
		
		//________________________________________
End case 

Case of 
		
		//________________________________________
	: (Value type:C1509($data)=Is text:K8:3)
		
		TEXT TO BLOB:C554($data; $message; UTF8 text without length:K22:17)
		
		//________________________________________
	: (Value type:C1509($data)=Is BLOB:K8:12)
		
		$message:=$data
		
		//________________________________________
End case 

Case of 
		
		//________________________________________
	: ($algoName="SHA1")
		
		$algo:=SHA1 digest:K66:2
		$blockSize:=64
		
		//________________________________________
	: ($algoName="SHA256")
		
		$algo:=SHA256 digest:K66:4
		$blockSize:=64
		
		//________________________________________
	: ($algoName="SHA512")
		
		$algo:=SHA512 digest:K66:5
		$blockSize:=128
		
		//________________________________________
	: ($algoName="MD5")
		
		$algo:=MD5 digest:K66:1
		$blockSize:=64
		
		//________________________________________
	Else 
		
		ASSERT:C1129(False:C215; "bad hash algo")
		
		//________________________________________
End case 

If (BLOB size:C605($key)>$blockSize)
	
	BASE64 DECODE:C896(Generate digest:C1147($key; $algo; *); $key; *)
	
End if 

If (BLOB size:C605($key)<$blockSize)
	
	SET BLOB SIZE:C606($key; $blockSize; 0)
	
End if 

ASSERT:C1129(BLOB size:C605($key)=$blockSize)

SET BLOB SIZE:C606($outerKey; $blockSize)
SET BLOB SIZE:C606($innerKey; $blockSize)

//%r-
For ($i; 0; $blockSize-1; 1)
	
	$byte:=$key{$i}
	$outerKey{$i}:=$byte ^| 0x005C
	$innerKey{$i}:=$byte ^| 0x0036
	
End for 

//%r+

// append $message to $innerKey
COPY BLOB:C558($message; $innerKey; 0; $blockSize; BLOB size:C605($message))
BASE64 DECODE:C896(Generate digest:C1147($innerKey; $algo; *); $b; *)

// append hash(innerKey + message) to outerKey
COPY BLOB:C558($b; $outerKey; 0; $blockSize; BLOB size:C605($b))
$hash:=Generate digest:C1147($outerKey; $algo; *)

//BASE64 DECODE($hash; $b; *)
//$hash:=BLOB to text($b; UTF8 text with length)

