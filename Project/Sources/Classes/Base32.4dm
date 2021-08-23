// Original code from https://discuss.4d.com/t/base32-encode-decode-in-native-4d/11129/4

Class constructor
	singletonize(This:C1470)
	
Function encodeText
	C_TEXT:C284($1)
	var $0; $1 : Text
	var $2 : Boolean
	var $blob : Blob
	TEXT TO BLOB:C554($1; $blob; UTF8 text without length:K22:17)
	If (Count parameters:C259>1)
		$0:=This:C1470.encode($blob; $2)
	Else 
		$0:=This:C1470.encode($blob)
	End if 
	
Function encode
	var $1; $blob : Blob
	var $2; $padding : Boolean
	var $0; $encoded : Text  //$0 contains a base32 encoded string
	$blob:=$1
	If (Count parameters:C259>1)
		$padding:=$2
	Else 
		$padding:=True:C214  // default padding
	End if 
	
	var $alfa : Text
	$alfa:="ABCDEFGHIJKLMNOPQRSTUVWXYZ234567"
	
	var $i; $index : Integer
	var $next_byte; $numBitsLeftOver : Integer
	var $fiveBits; $shiftToGet5Bits : Integer
	
	$index:=0
	$numBitsLeftOver:=0
	For ($i; 1; BLOB size:C605($blob))
		$next_byte:=($next_byte << 8)+$blob{$index}  // fetch a single byte from the input blob
		$numBitsLeftOver:=$numBitsLeftOver+8
		
		While ($numBitsLeftOver>=5)
			$shiftToGet5Bits:=($numBitsLeftOver-5)
			
			$fiveBits:=($next_byte >> $shiftToGet5Bits)+1  // get high 5 bits
			If ($fiveBits>0) & ($fiveBits<=Length:C16($alfa))
				$encoded:=$encoded+$alfa[[$fiveBits]]
			End if 
			
			$numBitsLeftOver:=$numBitsLeftOver-5
			Case of 
				: ($numBitsLeftOver=0)
					$next_byte:=0
				: ($numBitsLeftOver=1)
					$next_byte:=$next_byte & (0x0001)
				: ($numBitsLeftOver=2)
					$next_byte:=$next_byte & (0x0003)
				: ($numBitsLeftOver=3)
					$next_byte:=$next_byte & (0x0007)
				: ($numBitsLeftOver=4)
					$next_byte:=$next_byte & (0x000F)
				: ($numBitsLeftOver=5)
					$next_byte:=$next_byte & (0x001F)
				: ($numBitsLeftOver=6)
					$next_byte:=$next_byte & (0x003F)
				: ($numBitsLeftOver=7)
					$next_byte:=$next_byte & (0x007F)
				: ($numBitsLeftOver=8)
					$next_byte:=$next_byte & (0x00FF)
				: ($numBitsLeftOver=9)
					$next_byte:=$next_byte & (0x01FF)
				: ($numBitsLeftOver=10)
					$next_byte:=$next_byte & (0x03FF)
				: ($numBitsLeftOver=11)
					$next_byte:=$next_byte & (0x07FF)
				: ($numBitsLeftOver=12)
					$next_byte:=$next_byte & (0x0FFF)
				Else 
					
			End case 
			
		End while 
		
		$index:=$index+1
	End for 
	
	// deal with any left over bits
	If ($numBitsLeftOver>0)
		$next_byte:=($next_byte << (5-$numBitsLeftOver))  // pad on right with 0's
		$fiveBits:=($next_byte & 0x001F)+1  // get high 5 bits
		$encoded:=$encoded+$alfa[[$fiveBits]]
	End if 
	
	If ($padding)
		If (Length:C16($encoded)%8#0)
			$encoded:=$encoded+("="*(8-(Length:C16($encoded)%8)))
		End if 
	End if 
	
	$0:=$encoded
	
Function decode
	C_BLOB:C604($0; $blob)
	C_TEXT:C284($1; $b32)
	SET BLOB SIZE:C606($blob; 0)
	
	C_TEXT:C284($alfa)
	C_LONGINT:C283($z; $x; $i; $cc; $flt; $padc; $bf; $offset; $index)
	
	$x:=Length:C16($1)
	$b32:=$1
	C_LONGINT:C283($bf; $bits)
	$bf:=0
	$bits:=0
	$padc:=0
	$alfa:="ABCDEFGHIJKLMNOPQRSTUVWXYZ234567"
	For ($i; 1; $x)
		If ($bits>=16)
			$flt:=$bits-16
			$cc:=($bf >> $flt) & 0xFFFF
			INTEGER TO BLOB:C548($cc; $blob; Macintosh byte ordering:K22:2; *)
			
			$bf:=$bf & ((2^$flt)-1)
			$bits:=$bits-16
		End if 
		$z:=Position:C15(Substring:C12($b32; $i; 1); $alfa)
		Case of 
			: ($z>0)
				$bf:=($bf << 5) | ($z-1)
				$bits:=$bits+5
			: (Substring:C12($b32; $i; 1)="=")
				$bf:=($bf << 5)
				$bits:=$bits+5
				$padc:=$padc+1
			Else 
		End case 
	End for 
	If ($bits>=16)
		$flt:=$bits-16
		$cc:=($bf >> $flt) & 0xFFFF
		INTEGER TO BLOB:C548($cc; $blob; Macintosh byte ordering:K22:2; *)
		
		$bf:=$bf & ((2^$flt)-1)
		$bits:=$bits-16
	End if 
	If ($bits>0)
		$bf:=$bf << (16-$bits)
		
		INTEGER TO BLOB:C548($bf & 0xFFFF; $blob; Macintosh byte ordering:K22:2; *)
	End if 
	If ($padc>0)
		$padc:=$padc*5
		$padc:=Int:C8($padc/8)
		
		If ($padc>0)
			$z:=BLOB size:C605($blob)
			SET BLOB SIZE:C606($blob; $z-$padc)
		End if 
	End if 
	$0:=$blob