

/// Constructor for the OTP class
Class constructor($secret : Text)
	var $2; $opt : Object  // optional param
	ASSERT:C1129(Count parameters:C259>=1)
	ASSERT:C1129(Count parameters:C259<=2)
	If (Count parameters:C259=2)
		$opt:=$2
	End if 
	
	This:C1470.secret:=$secret  // TODO encode cs.Base32.instance useless to encode/decode..., depend on passed format, add option?
	
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
	var $blobTmp : Blob
	LONGINT TO BLOB:C550($int; $blobTmp; Macintosh byte ordering:K22:2)
	var $size : Integer
	$size:=BLOB size:C605($blobTmp)
	
	SET BLOB SIZE:C606($blob; 8)
	COPY BLOB:C558($blobTmp; $blob; 0; 8-$size; $size)