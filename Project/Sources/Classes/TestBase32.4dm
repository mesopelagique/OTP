Class extends TestCase

Class constructor
	Super:C1705()
	This:C1470.functions:=New collection:C1472(This:C1470.test_decode_encode_symetrie)
	This:C1470.base32:=cs:C1710.Base32.new()
	
Function test_decode_encode_symetrie
	var $value : Text
	For each ($value; New collection:C1472(""; "a"; "a b"; " a b c"))
		This:C1470.assertEquals($value; This:C1470.base32.decodeText(This:C1470.base32.encodeText($value)))
	End for each 