Class extends TestCase

Class constructor
	Super:C1705()
	This:C1470.functions:=New collection:C1472(This:C1470.test_encode_for_otp; This:C1470.test_encode_pure)
	This:C1470.base32:=cs:C1710.Base32.new()
	
Function test_encode_for_otp
	This:C1470.assertEquals(""; This:C1470.base32.encodeText(""; False:C215))
	This:C1470.assertEquals("OQ"; This:C1470.base32.encodeText("t"; False:C215))
	This:C1470.assertEquals("ORSQ"; This:C1470.base32.encodeText("te"; False:C215))
	This:C1470.assertEquals("ORSXG5A"; This:C1470.base32.encodeText("test"; False:C215))
	This:C1470.assertEquals("ORSXG5DB"; This:C1470.base32.encodeText("testa"; False:C215))
	This:C1470.assertEquals("ORSXG5DBME"; This:C1470.base32.encodeText("testaa"; False:C215))
	This:C1470.assertEquals("NBQXA4DZMRSA"; This:C1470.base32.encodeText("happydd"; False:C215))
	
	This:C1470.assertEquals("MY"; This:C1470.base32.encodeText("f"; False:C215))
	This:C1470.assertEquals("MZXQ"; This:C1470.base32.encodeText("fo"; False:C215))
	This:C1470.assertEquals("MZXW6"; This:C1470.base32.encodeText("foo"; False:C215))
	This:C1470.assertEquals("MZXW6YQ"; This:C1470.base32.encodeText("foob"; False:C215))
	This:C1470.assertEquals("MZXW6YTB"; This:C1470.base32.encodeText("fooba"; False:C215))
	This:C1470.assertEquals("MZXW6YTBOI"; This:C1470.base32.encodeText("foobar"; False:C215))
	
Function test_encode_pure
	// https://datatracker.ietf.org/doc/html/rfc4648#section-10
	This:C1470.assertEquals("MY======"; This:C1470.base32.encodeText("f"))
	This:C1470.assertEquals("MZXQ===="; This:C1470.base32.encodeText("fo"))
	This:C1470.assertEquals("MZXW6==="; This:C1470.base32.encodeText("foo"))
	This:C1470.assertEquals("MZXW6YQ="; This:C1470.base32.encodeText("foob"))
	This:C1470.assertEquals("MZXW6YTB"; This:C1470.base32.encodeText("fooba"))
	This:C1470.assertEquals("MZXW6YTBOI======"; This:C1470.base32.encodeText("foobar"))
	