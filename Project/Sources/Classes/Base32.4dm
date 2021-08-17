// Original code from https://discuss.4d.com/t/base32-encode-decode-in-native-4d/11129/4

Class constructor
	singletonize(This:C1470)
	
Function encodeText
	C_TEXT:C284($1)
	C_TEXT:C284($0)
	C_BLOB:C604($blob)
	TEXT TO BLOB:C554($1; $blob)
	
	$0:=This:C1470.encode($blob)
	
Function encode
	C_BLOB:C604($1; $data)
	
	C_TEXT:C284($0; $obuff)
	C_LONGINT:C283($bf)
	C_TEXT:C284($alfa)
	C_LONGINT:C283($z; $x; $i; $bits; $offset; $a; $bf; $offset; $index)
	
	$alfa:="ABCDEFGHIJKLMNOPQRSTUVWXYZ234567"
	$z:=Length:C16($alfa)
	$x:=BLOB size:C605($1)
	$data:=$1
	// To get the last byte of the blob as integer. 
	TEXT TO BLOB:C554(Char:C90(0x0000); $data; Mac text without length:K22:10; *)
	$obuff:=""
	$i:=1
	$bits:=0
	C_LONGINT:C283($pad)
	$pad:=0
	While ($i<=$x) | ($bits>0)
		If ($bits<5)
			If ($i<=$x)
				$bf:=$bf << 8
				$offset:=$i-1
				$a:=BLOB to integer:C549($data; Macintosh byte ordering:K22:2; $offset)
				$a:=($a & 0xFF00) >> 8
				$bf:=$bf | $a
				$bits:=$bits+8
				$i:=$i+1
			Else 
				$pad:=5-$bits
				$bf:=$bf << $pad
				$bits:=$bits+$pad
			End if 
		End if 
		$index:=0x001F & ($bf >> ($bits-5))
		If ((($pad>0) | ($i>$x)) & ($index=0))
			$obuff:=$obuff+"="
		Else 
			$obuff:=$obuff+Substring:C12($alfa; $index+1; 1)
		End if 
		$bits:=$bits-5
	End while 
	$obuff:=Replace string:C233($obuff; "="; ""; *)
	
	If (Length:C16($obuff)%8#0)
		$obuff:=$obuff+("="*(8-(Length:C16($obuff)%8)))
	End if 
	$0:=$obuff
	
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