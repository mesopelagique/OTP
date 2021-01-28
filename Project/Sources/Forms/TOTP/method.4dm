var $event : Object
$event:=FORM Event:C1606
Case of 
	: ($event.code=On Load:K2:1)
		
		If (Form:C1466.otp=Null:C1517)
			Form:C1466.otp:=OTP.TOTP.new("JDDK4U6G3BJLEZ7Y")
			Form:C1466.code:=Form:C1466.otp.now()
		End if 
		
		SET TIMER:C645(10)  // XXX cannot do with real time? Form.otp.period (30s)
		
	: ($event.code=On Timer:K2:25)
		
		Form:C1466.code:=Form:C1466.otp.now()
		
	Else 
		
End case 

