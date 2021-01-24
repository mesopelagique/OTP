Class extends OTP

Function at($count : Integer)->$return : Integer
	$return:=This:C1470.generateOTP($count)
	
Function verify($otp : Integer; $counter : Integer)->$return : Boolean
	$return:=($otp=This:C1470.at($counter))
	
Function provisioningUri($issuer : Text; $initialCount : Integer)->$url : Text
	$url:="otpauth://hotp/"+urlencode($issuer)+"?secret="+This:C1470.secret+"&counter="+String:C10($initialCount)
	