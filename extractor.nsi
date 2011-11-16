; Functions for manipulating strings and searching in strings
; http://nsis.sourceforge.net/Category:String_Functions

Function GetAfterChar
; This script will get the last part of a string after a specified character
; Usage example:
;    Push (input str)
;    Push (specified character))
;    Call GetAfterChar
;    Pop (result str)

  Exch $0 ; chop char
  Exch
  Exch $1 ; input string
  Push $2
  Push $3
  StrCpy $2 0
  loop:
    IntOp $2 $2 - 1
    StrCpy $3 $1 1 $2
    StrCmp $3 "" 0 +3
      StrCpy $0 ""
      Goto exit2
    StrCmp $3 $0 exit1
    Goto loop
  exit1:
    IntOp $2 $2 + 1
    StrCpy $0 $1 "" $2
  exit2:
    Pop $3
    Pop $2
    Pop $1
    Exch $0 ; output
FunctionEnd

Function GetLastPart
; This function returns the parts before and after a sub string in a string
; Usage example:
;    Push (divider str)
;    Push (input string)
;    Call GetLastPart
;    Pop (last part)
;    Pop (first part)

	Exch $R0 ; input
	Exch
	Exch $R1 ; divider str
	Push $R2
	Push $R3
	Push $R4
	Push $R5

	StrCpy $R2 -1
	StrLen $R4 $R0
	StrLen $R5 $R1
	Loop:
		IntOp $R2 $R2 + 1
		StrCpy $R3 $R0 $R5 $R2
		StrCmp $R3 $R1 Chop
		StrCmp $R2 $R4 0 Loop
		 StrCpy $R0 ""
		 StrCpy $R1 ""
		 Goto Done
	Chop:
		StrCpy $R1 $R0 $R2
		IntOp $R2 $R2 + $R5
		StrCpy $R0 $R0 "" $R2
	Done:

	Pop $R5
	Pop $R4
	Pop $R3
	Pop $R2
	Exch $R1 ; before
	Exch
	Exch $R0 ; after
FunctionEnd
