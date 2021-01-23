//%attributes = {}

cs:C1710.Base32.new()


ASSERT:C1129(hash_hmac("MD5"; "The quick brown fox jumps over the lazy dog"; "key")="80070713463e7749b90c2dc24911e275")

ASSERT:C1129(hash_hmac("SHA1"; "The quick brown fox jumps over the lazy dog"; "key")="de7c9b85b8b78aa6bc8a7a36f70a90701c9db4d9")

ASSERT:C1129(hash_hmac("SHA256"; "The quick brown fox jumps over the lazy dog"; "key")="f7bc83f430538424b13298e6aa6fb143ef4d59a14946175997479dbc2d1a3cd8")