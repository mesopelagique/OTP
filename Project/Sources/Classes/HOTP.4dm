Class extends OTP

Function at($count : Integer)->$return : Text
	$return:=This:C1470.generateOTP($count)
	
Function verify($otp : Integer; $counter : Integer)->$return : Boolean
	$return:=($otp=This:C1470.at($counter))
	
Function provisioning_uri($name : Text; $initial_count : Integer)->$url : Text
	$url:="otpauth://hotp/"+This:C1470.urlencode($name)+"?secret="+This:C1470.secret+"&counter="+String:C10($initial_count)
	