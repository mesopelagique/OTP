Class extends OTP

// This.interval

Class constructor($secret : Text; $opt : Object)
	Super:C1705($secret; $opt)
	This:C1470._optSet($opt; "interval"; Is integer:K8:5; 30)
	
Function at($timestamp : Integer)->$return : Integer
	$return:=This:C1470.generateOTP($this->timecode($timestamp)); 
	
Function now()->$return : Integer
	$return:=This:C1470.generateOTP(This:C1470.timecode(This:C1470.nowTimeStamp()))
	
Function verify($otp : Integer; $timestamp : Integer)->$return : Boolean
	If ($timestamp=Null:C1517)
		$timestamp:=This:C1470.nowTimeStamp()
	End if 
	$return:=($otp=This:C1470.at($timestamp))
	
Function provisioning_uri($name : Text)->$url : Text
	$url:="otpauth://totp/"+This:C1470.urlencode($name)+"?secret="+This:C1470.secret
	
	
Function timecode($timestamp : Integer)->$timecode : Integer
	$timecode:=((($timestamp*1000)/(This:C1470.interval*1000)))
	
Function nowTimeStamp
	