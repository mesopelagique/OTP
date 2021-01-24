

/// Constructor for the OTP class
Class constructor($secret : Text; $opt : Object)
	This:C1470.secret:=$secret  // TODO encode cs.Base32.instance useless to encode/decode..., depend on passed format
	
	This:C1470._optSet($opt; "digest"; Is text:K8:3; "sha1")
	This:C1470._optSet($opt; "digits"; Is real:K8:4; 6)
	
Function _optSet($opt : Object; $key : Text; $type : Integer; $defaulValue : Variant)
	If (Value type:C1509($opt[$key])=$type)
		This:C1470[$key]:=$opt[$key]
	Else 
		This:C1470[$key]:=$defaulValue
	End if 
	
	///Generate a one-time password
Function generateOTP($input : Integer)->$otp : Integer
	var $hash : Text
	$hash:=hash_hmac(This:C1470.digest; This:C1470.intToBytestring($input); This:C1470.byteSecret())
	
	var $hmac : Collection
	$hmac:=New collection:C1472()
	var $hex : Text
	For each ($hex; str_split($hash; 2))
		$hmac.push(hexdec($hex))
	End for each 
	
	var $offset : Integer
	$offset:=$hmac[19] & 0x000F
	
	var $code : Integer
	$code:=(($hmac[$offset+0] & 0x007F) << 24) | \
		(($hmac[$offset+1] & 0x00FF) << 16) | \
		(($hmac[$offset+2] & 0x00FF) << 8) | \
		($hmac[$offset+3] & 0x00FF)
	
	$otp:=$code%(10^Int:C8(This:C1470.digits))
	
Function byteSecret()->$binary : Blob
	$binary:=cs:C1710.Base32.instance.decode(This:C1470.secret)
	
Function intToBytestring($int : Integer)->$blob : Blob  // $text : Text
	INTEGER TO BLOB:C548($int; $blob; Macintosh byte ordering:K22:2)
	var $size; $i : Integer
	$size:=BLOB size:C605($blob)
	
	If ($size<8)
		SET BLOB SIZE:C606($blob; 8)
		// padding left (see if could do with offset or reverse blob after chosig pc byte ordering)
		For ($i; 0; $size-1; 1)
			
			$blob{$i+8-$size}:=$blob{$i}
			
		End for 
		For ($i; 0; 8-$size-1; 1)
			
			$blob{$i}:=0
			
		End for 
	End if 
	
/*var $result : Collection
$result:=New collection()
While ($int#0)
$result.push(Char($int & 0x00FF))
$int:=$int >> 8
End while 
$text:=str_pad($result.reverse().join(""); 8; "0"; 0)  // add padding*/
	