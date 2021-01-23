Class extends TestCase

Class constructor
	Super:C1705()
	This:C1470.functions:=New collection:C1472()  // (This.test_it_decodes_the_secret; This.test_it_turns_an_int_into_bytestring; This.test_it_generate_otp)
	
Function test_it_decodes_the_secret
	var $o : Object
	$o:=cs:C1710.OTP.new("JDDK4U6G3BJLEZ7Y")
	This:C1470.assertEquals("H\\306\\256S\\306\\330R\\262g\\370"; $o.byteSecret())
	
Function test_it_turns_an_int_into_bytestring(){
	var $o : Object
	$o:=cs:C1710.OTP.new("JDDK4U6G3BJLEZ7Y")
	This:C1470.assertEquals("\\000\\000\\000\\000\\000\\000\\000\\000"; $o.intToBytestring(0))
	This:C1470.assertEquals("\\000\\000\\000\\000\\000\\000\\000\\001"; $o.intToBytestring(1))
	This:C1470.assertEquals("\\000\\000\\000\\000\\000\\000\\001\\364"; $o.intToBytestring(500))
	This:C1470.assertEquals("\\000\\000\\000\\000\\000\\000\\005\\334"; $o.intToBytestring(1500))
	
Function test_it_generate_otp()
	var $o : Object
	$o:=cs:C1710.OTP.new("JDDK4U6G3BJLEZ7Y")
	This:C1470.assertEquals(855783; $o.generateOTP(0))
	This:C1470.assertEquals(549607; $o.generateOTP(500))
	This:C1470.assertEquals(654666; $o.generateOTP(1500))
	