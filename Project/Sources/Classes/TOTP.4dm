Class extends OTP

Class constructor($secret : Text)
	var $2; $opt : Object  // optional param
	ASSERT:C1129(Count parameters:C259>=1)
	ASSERT:C1129(Count parameters:C259<=2)
	If (Count parameters:C259=2)
		$opt:=$2
	End if 
	
	Super:C1705($secret; $opt)
	This:C1470._optSet($opt; "period"; Is real:K8:4; 30)
	This:C1470._optSet($opt; "before"; Is real:K8:4; 1)
	This:C1470._optSet($opt; "after"; Is real:K8:4; 1)
	
Function at($timestamp : Integer)->$return : Integer
	$return:=This:C1470.generateOTP(This:C1470.timecode($timestamp)); 
	
Function now()->$return : Integer
	$return:=This:C1470.generateOTP(This:C1470.timecode(time_()))
	
Function verify($otp : Integer)->$return : Boolean
	var $2; $timestamp : Integer  // optional param
	ASSERT:C1129(Count parameters:C259>=1)
	ASSERT:C1129(Count parameters:C259<=2)
	If (Count parameters:C259=2)
		$timestamp:=$2
	Else 
		$timestamp:=time_()
	End if 
	
	$return:=($otp=This:C1470.at($timestamp))
	If (Not:C34($return))
		If (This:C1470.before>0)  // support only one period for the moment
			$return:=($otp=This:C1470.at($timestamp-This:C1470.period))
			// Here we could register the drift for later call
		End if 
	End if 
	If (Not:C34($return))
		If (This:C1470.after>0)  // support only one period for the moment
			$return:=($otp=This:C1470.at($timestamp+This:C1470.period))
			// Here we could register the drift for later call
		End if 
	End if 
	
Function provisioningUri($issuer : Text)->$url : Text
	$url:="otpauth://totp/"+urlencode($issuer)+"?secret="+This:C1470.secret
	If (This:C1470.period#30)
		$url:=$url+"&period="+String:C10(This:C1470.period)  // not managed by all ap
	End if 
	
Function timecode($timestamp : Integer)->$timecode : Integer
	// REFERENCE: https://discuss.4d.com/t/capacity-of-a-real-compiled-or-interpreted/18937/14
	$timecode:=((($timestamp*1000)/(This:C1470.period*1000)))  // tests pass only if uncompiled
	$timecode:=($timestamp/This:C1470.period)  // tests pass compiled and uncompiled