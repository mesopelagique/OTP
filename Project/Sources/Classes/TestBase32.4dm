Class extends TestCase

Class constructor
	Super:C1705()
	This:C1470.functions:=New collection:C1472(This:C1470.test_encode)
	This:C1470.base32:=cs:C1710.Base32.new()
	
Function test_encode
	// https://datatracker.ietf.org/doc/html/rfc4648#page-12
	This:C1470.assertEquals(""; This:C1470.base32.encodeText(""))
	This:C1470.assertEquals("MY======"; This:C1470.base32.encodeText("f"))
	This:C1470.assertEquals("MZXQ===="; This:C1470.base32.encodeText("fo"))
	This:C1470.assertEquals("MZXW6==="; This:C1470.base32.encodeText("foo"))
	This:C1470.assertEquals("MZXW6YQ="; This:C1470.base32.encodeText("foob"))
	This:C1470.assertEquals("MZXW6YTB"; This:C1470.base32.encodeText("fooba"))
	This:C1470.assertEquals("MZXW6YTBOI======"; This:C1470.base32.encodeText("foobar"))
	
	