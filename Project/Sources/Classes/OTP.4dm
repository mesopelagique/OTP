

/// Constructor for the OTP class
Class constructor($secret : Text; $opt : Object)
	This:C1470.secret:=$secret
	
	This:C1470._optSet($opt; "digest"; Is text:K8:3; "sha1")
	This:C1470._optSet($opt; "digits"; Is integer:K8:5; 6)
	
Function _optSet($opt : Object; $key : Text; $type : Integer; $defaulValue : Variant)
	If (Value type:C1509($opt[$key])=$type)
		This:C1470[$key]:=$opt[$key]
	Else 
		This:C1470[$key]:=$defaulValue
	End if 
	
	///Generate a one-time password
Function generateOTP($input : Integer)->$otp : Integer
	$hash:=hash_hmac(This:C1470.digest; This:C1470.intToBytestring($input); This:C1470.byteSecret())
	
	$hmac:=New collection:C1472()
	For each ($hex; str_split($hash; 2))
		$hmac.append(hexdec($hex))
	End for each 
	
	$offset:=$hmac[19] & 0x000F
	
	$code:=($hmac[$offset+0] & 0x007F) << 24 | \
		($hmac[$offset+1] & 0x00FF) << 16 | \
		($hmac[$offset+2] & 0x00FF) << 8 | \
		($hmac[$offset+3] & 0x00FF)
	
	$otp:=$code%(10^Int:C8(This:C1470.digits))
	
	
Function byteSecret()->$binary : Blob
	$binary:=cs:C1710.Base32.instance.decode(This:C1470.secret)
	
Function intToBytestring($int : Integer)->$blob : Blob
	INTEGER TO BLOB:C548($int; $blob; PC byte ordering:K22:3)
	