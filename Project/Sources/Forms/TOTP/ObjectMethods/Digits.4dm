
var $event : Object
$event:=FORM Event:C1606

Case of 
	: ($event.code=On Data Change:K2:15)
		
		Form:C1466.code:=Form:C1466.otp.now()
		
	Else 
		
End case 