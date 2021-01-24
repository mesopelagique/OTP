Class extends TestCase

Class constructor
	Super:C1705()
	This:C1470.functions:=New collection:C1472(This:C1470.test_init; This:C1470.test_it_gets_the_good_code; This:C1470.test_it_verify_the_code)
	
Function test_init
	var $o : Object
	$o:=OTP.HOTP.new("JDDK4U6G3BJLEZ7Y")
	
Function test_it_gets_the_good_code
	var $o : Object
	$o:=OTP.HOTP.new("JDDK4U6G3BJLEZ7Y")
	This:C1470.assertEquals(855783; $o.at(0))
	This:C1470.assertEquals(549607; $o.at(500))
	This:C1470.assertEquals(654666; $o.at(1500))
	
Function test_it_verify_the_code
	var $o : Object
	$o:=OTP.HOTP.new("JDDK4U6G3BJLEZ7Y")
	ASSERT:C1129($o.verify(855783; 0))
	ASSERT:C1129($o.verify(549607; 500))
	ASSERT:C1129($o.verify(654666; 1500))
	