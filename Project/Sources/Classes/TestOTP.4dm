Class extends TestCase

Class constructor
	Super:C1705()
	This:C1470.functions:=New collection:C1472(This:C1470.test_init_digest; This:C1470.test_init_digits; This:C1470.test_generate_otp)
	
Function test_init_digest
	var $o : Object
	
	$o:=OTP.OTP.new("JDDK4U6G3BJLEZ7Y")
	ASSERT:C1129($o.digest="sha1")
	
	$o:=OTP.OTP.new("JDDK4U6G3BJLEZ7Y"; New object:C1471("digest"; "md5"))
	ASSERT:C1129($o.digest="md5")
	
Function test_init_digits
	var $o : Object
	
	$o:=OTP.OTP.new("JDDK4U6G3BJLEZ7Y")
	ASSERT:C1129($o.digits=6)
	
	$o:=OTP.OTP.new("JDDK4U6G3BJLEZ7Y"; New object:C1471("digits"; 4))
	ASSERT:C1129($o.digits=4)
	
/*
Function test_it_decodes_the_secret
var $o : Object
$o:=OTP.OTP.new("JDDK4U6G3BJLEZ7Y")
This.assertEquals("H\\306\\256S\\306\\330R\\262g\\370"; $o.byteSecret())*/
/*
Function test_it_turns_an_int_into_bytestring
var $o : Object
$o:=OTP.OTP.new("JDDK4U6G3BJLEZ7Y")
//This.assertEquals("\\000\\000\\000\\000\\000\\000\\000\\000"; $o.intToBytestring(0)) 
//This.assertEquals("\\000\\000\\000\\000\\000\\000\\000\\001"; $o.intToBytestring(1))
//This.assertEquals("\\000\\000\\000\\000\\000\\000\\001\\364"; $o.intToBytestring(500)) // CHECK HOW to inject character in 4d instead of char(244)
//This.assertEquals("\\000\\000\\000\\000\\000\\000\\005\\334"; $o.intToBytestring(1500))*/
	
Function test_generate_otp
	var $o : Object
	$o:=OTP.OTP.new("JDDK4U6G3BJLEZ7Y")
	This:C1470.assertEquals(Int:C8(855783); $o.generateOTP(0))
	This:C1470.assertEquals(Int:C8(549607); $o.generateOTP(500))
	This:C1470.assertEquals(Int:C8(654666); $o.generateOTP(1500))
	