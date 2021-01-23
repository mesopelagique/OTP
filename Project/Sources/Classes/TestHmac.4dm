
Class extends TestCase

Class constructor
	Super:C1705()
	This:C1470.functions:=New collection:C1472(This:C1470.test_hash_hmac_md5; This:C1470.test_hash_hmac_sha1; This:C1470.test_hash_hmac_sha256)
	
Function test_hash_hmac_md5
	This:C1470.assertEquals(hash_hmac("MD5"; "The quick brown fox jumps over the lazy dog"; "key"); "80070713463e7749b90c2dc24911e275")
	
Function test_hash_hmac_sha1
	This:C1470.assertEquals(hash_hmac("SHA1"; "The quick brown fox jumps over the lazy dog"; "key"); "de7c9b85b8b78aa6bc8a7a36f70a90701c9db4d9")
	
Function test_hash_hmac_sha256
	This:C1470.assertEquals(hash_hmac("SHA256"; "The quick brown fox jumps over the lazy dog"; "key"); "f7bc83f430538424b13298e6aa6fb143ef4d59a14946175997479dbc2d1a3cd8")