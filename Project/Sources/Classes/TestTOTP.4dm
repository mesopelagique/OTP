Class extends TestCase

Class constructor
	Super:C1705()
	This:C1470.functions:=New collection:C1472(This:C1470.test_init; This:C1470.test_init_interval)
	
Function test_init
	var $o : Object
	$o:=OTP.TOTP.new("JDDK4U6G3BJLEZ7Y")
	
Function test_init_interval
	var $o : Object
	$o:=OTP.TOTP.new("JDDK4U6G3BJLEZ7Y"; New object:C1471("interval"; 60))
	ASSERT:C1129($o.interval=60)