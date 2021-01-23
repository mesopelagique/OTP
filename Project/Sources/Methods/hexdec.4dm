//%attributes = {}
C_TEXT:C284($1)
C_LONGINT:C283($result; $lLength; $lDigitValue; $0; $i)

$result:=0
$lLength:=Length:C16($1)

For ($i; $lLength; 1; -1)
	
	Case of 
		: ($1[[$i]]="F")
			$lDigitValue:=15
		: ($1[[$i]]="E")
			$lDigitValue:=14
		: ($1[[$i]]="D")
			$lDigitValue:=13
		: ($1[[$i]]="C")
			$lDigitValue:=12
		: ($1[[$i]]="B")
			$lDigitValue:=11
		: ($1[[$i]]="A")
			$lDigitValue:=10
		: ($1[[$i]]="9")
			$lDigitValue:=9
		: ($1[[$i]]="8")
			$lDigitValue:=8
		: ($1[[$i]]="7")
			$lDigitValue:=7
		: ($1[[$i]]="6")
			$lDigitValue:=6
		: ($1[[$i]]="5")
			$lDigitValue:=5
		: ($1[[$i]]="4")
			$lDigitValue:=4
		: ($1[[$i]]="3")
			$lDigitValue:=3
		: ($1[[$i]]="2")
			$lDigitValue:=2
		: ($1[[$i]]="1")
			$lDigitValue:=1
		Else 
			$lDigitValue:=0
	End case 
	
	If ($lDigitValue>0)
		$result:=$result+(($lDigitValue)*(16^($lLength-$i)))
	End if 
	
End for 

$0:=$result