Class extends OTP

Class constructor($secret : Text; $opt : Object)
	Super:C1705($secret; $opt)
	This:C1470._optSet($opt; "interval"; Is real:K8:4; 30)
	
Function at($timestamp : Integer)->$return : Integer
	$return:=This:C1470.generateOTP(This:C1470.timecode($timestamp)); 
	
Function now()->$return : Integer
	$return:=This:C1470.generateOTP(This:C1470.timecode(timep()))
	
Function verify($otp : Integer; $timestamp : Integer)->$return : Boolean
	If ($timestamp=Null:C1517)
		$timestamp:=timep()
	End if 
	$return:=($otp=This:C1470.at($timestamp))
	
Function provisioningUri($issuer : Text)->$url : Text
	$url:="otpauth://totp/"+urlencode($issuer)+"?secret="+This:C1470.secret  // XXX could add optional period
	
Function timecode($timestamp : Integer)->$timecode : Integer
	$timecode:=((($timestamp*1000)/(This:C1470.interval*1000)))
	