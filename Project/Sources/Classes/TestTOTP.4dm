Class extends TestCase

Class constructor
	Super:C1705()
	This:C1470.functions:=New collection:C1472(This:C1470.test_init; This:C1470.test_init_interval; This:C1470.test_it_gets_the_good_code_at_given_times; This:C1470.test_it_verify_the_code)
	
Function test_init
	var $o : Object
	$o:=OTP.TOTP.new("JDDK4U6G3BJLEZ7Y")
	
Function test_init_interval
	var $o : Object
	$o:=OTP.TOTP.new("JDDK4U6G3BJLEZ7Y"; New object:C1471("period"; 60))
	ASSERT:C1129($o.period=60)
	
Function test_it_gets_the_good_code_at_given_times()
	var $o : Object
	$o:=OTP.TOTP.new("JDDK4U6G3BJLEZ7Y")
	This:C1470.assertEquals(855783; $o.at(0))
	This:C1470.assertEquals(762124; $o.at(319690800))
	This:C1470.assertEquals(139664; $o.at(1301012137))
	
Function test_it_verify_the_code()
	var $o : Object
	$o:=OTP.TOTP.new("JDDK4U6G3BJLEZ7Y")
	ASSERT:C1129($o.verify(855783; 0))
	ASSERT:C1129($o.verify(762124; 319690800))
	ASSERT:C1129($o.verify(139664; 1301012137))
	