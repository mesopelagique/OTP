Class extends TestCase

Class constructor
	Super:C1705()
	This:C1470.functions:=New collection:C1472(This:C1470.test_encode)
	This:C1470.base32:=cs:C1710.Base32.new()
	
Function test_encode
	This:C1470.assertEquals(""; This:C1470.base32.encodeText(""))
	This:C1470.assertEquals("OQ"; This:C1470.base32.encodeText("t"))
	This:C1470.assertEquals("ORSQ"; This:C1470.base32.encodeText("te"))
	This:C1470.assertEquals("ORSXG5A"; This:C1470.base32.encodeText("test"))  // BUG
	This:C1470.assertEquals("ORSXG5DB"; This:C1470.base32.encodeText("testa"))
	This:C1470.assertEquals("ORSXG5DBME"; This:C1470.base32.encodeText("testaa"))
	