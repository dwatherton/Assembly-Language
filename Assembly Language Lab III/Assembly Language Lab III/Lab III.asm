;Program Template (Template.asm)

;Program Description: This program permutates an integer array.
;Author: Daniel Atherton
;Creation Date: 3/21/2018
;Revisions:
;Date:							Modified by:

INCLUDE irvine32.inc

MAXSIZE = 20															;maximum array size

.386
.model flat,stdcall
.stack 4096
ExitProcess PROTO, dwExitCode:DWORD
.data

	welcome				BYTE "Welcome! This program permutates an array of any size.", 0Ah, 0Dh, 0
	enterSize			BYTE "Please enter the size of the array: ", 0
	enterElements		BYTE "Please enter the ", 0
	ofTheArray			BYTE " elements of the array:", 0Ah, 0Dh, 0
	enterPermutation  BYTE "Please enter the permutation: ", 0Ah, 0Dh, 0	
	theArrayIs			BYTE "The array is: ", 0AH, 0Dh, 0
	spaces				BYTE "     ", 0
	thePermutationIs  BYTE "The permutation is: ", 0Ah, 0dh, 0
	endingArray		   BYTE "The array after permutation is: ", 0Ah, 0Dh, 0
	endingPermutation BYTE "The permutation at the end is: ", 0Ah, 0Dh, 0

	arraySize			DWORD ?
	theArray				DWORD MAXSIZE+1 DUP(0)
	thePermutation		DWORD MAXSIZE+1 DUP(0)
	varI					DWORD ?
	varJ					DWORD ?
	sizeI					DWORD ?
	sizeJ					DWORD ?

.code
main PROC

	MOV  EDX, OFFSET welcome										;display welcome message
	call WriteString
	call Crlf												
	MOV  EDX, OFFSET enterSize										;display enter array size prompt
	call WriteString
	call ReadInt														;get the size from the user
	MOV  arraySize, EAX												;put the size into variable arraySize
	call Crlf
	MOV  EDX, OFFSET enterElements								;display "please enter the"
	call WriteString
	MOV  EDX, OFFSET arraySize										;"size"
	call WriteDec
	MOV  EDX, OFFSET ofTheArray									;"elements of the array."
	call WriteString
	call EnterTheArray												;procedure for entering elements into array
	call Crlf
	MOV  EDX, OFFSET enterPermutation							;display permutation prompt
	call WriteString
	call EnterThePermutation										;procedure for entering elements into permutation array
	call Crlf
	MOV  EDX, OFFSET theArrayIs									;display the array is
	call WriteString
	call PrintTheArray												;procedure for displaying the array
	call Crlf
	call Crlf
	MOV  EDX, OFFSET thePermutationIs							;display the permutation is
	call WriteString
	call PrintThePermutation										;procedure for displaying the permutation array
	call Crlf
	call Crlf
	call PermutateTheArray											;procedure to permutate the array
	MOV  EDX, OFFSET endingArray									;display array after permutation
	call WriteString
	call PrintTheArray												;procedure for displaying the array
	call Crlf
	call Crlf
	MOV  EDX, OFFSET endingPermutation							;display permuation array after permutation
	call WriteString
	call PrintThePermutation										;procedure for displaying the permutation
	call Crlf
	call Crlf
	call WaitMsg														;call wait message to view the results
	INVOKE ExitProcess,0

main ENDP

;-----------------------------------------------------
EnterTheArray PROC
;
; Loops through the array based on the user entered 
; size and allows the user to enter integers to each
; place in the array.
; Recieves: DWORD variable "arraySize" and DWORD array
; "theArray".
; Returns: DWORD array "theArray".
; Requires: DWORD variable "arraySize" and DWORD array
; "theArray".
;-----------------------------------------------------
	PUSHAD																;save all registers 
	MOV  ECX, arraySize												;initialize loop counter
	MOV  EBX, 0															;initialize index 0
EnterInt:
	call ReadInt														;get the integer
	MOV  theArray[EBX], EAX											;place integer at index [EBX]
	ADD  EBX, 4															;move to next element
	loop EnterInt														;repeats arraySize times
	POPAD																	;return registers to initial values
	RET
EnterTheArray ENDP

;-----------------------------------------------------
EnterThePermutation PROC
;
; Loops through the permutation based on user entered 
; size and allows the user to enter integers to each
; place in the array.
; Recieves: DWORD variable "thePermutation" and DWORD
; variable "arraySize".
; Returns: DWORD array "thePermutation".
; Requires: DWORD variable "arraySize" and DWORD array
; "thePermutation".
;-----------------------------------------------------
	PUSHAD																;save all registers
	MOV  ECX, arraySize												;initialize loop counter
	MOV  EBX, 0															;initialize index 0
EnterInt:
	call ReadInt														;get the integer
	MOV  thePermutation[EBX], EAX									;place integer at index [EBX]
	ADD  EBX, 4															;move to next element
	loop EnterInt														;repeats arraySize times
	POPAD																	;return registers to initial values
	RET
EnterThePermutation ENDP

;-----------------------------------------------------
PrintTheArray PROC
;
; Loops through the user entered array "theArray" and
; prints to the console the integer stored at each 
; inedex of the array with spaces between them.
; Recieves: DWORD variable "arraySize", DWORD array
; "theArray", and BYTE string "spaces".
; Returns: Nothing.
; Requires: DWORD variable "arraySize", DWORD array
; "theArray", and BYTE string "spaces".
;-----------------------------------------------------
	PUSHAD																;save all registers
	MOV  ECX, arraySize												;initialize loop counter
	MOV  EBX, 0															;initialize index 0
	MOV  EDX, OFFSET spaces											;place spaces between integers
PrintArray:
	MOV  EAX, theArray[EBX]											;place integer into EAX
	call WriteDec														;print integer at index[EBX]
	call WriteString													;print some spaces between integers
	ADD  EBX, 4															;move to next element
	loop PrintArray													;repeats arraySize times
	POPAD																	;return registers to initial values
	RET
PrintTheArray ENDP

;-----------------------------------------------------
PrintThePermutation PROC
;
; Loops through the user entered array "thePermutation"
; and prints to the console the integer stored at each 
; inedex of the array with spaces between them.
; Recieves: DWORD variable "arraySize", DWORD array
; "thePermutation", and BYTE string "spaces".
; Returns: Nothing.
; Requires: DWORD variable "arraySize", DWORD array
; "thePermutation", and BYTE string "spaces".
;-----------------------------------------------------
	PUSHAD																;save all registers
	MOV  ECX, arraySize												;initialize loop counter
	MOV  EBX, 0															;initialize index 0
	MOV  EDX, OFFSET spaces											;place spaces between integers
PrintArray:
	MOV  EAX, thePermutation[EBX]									;place integer into EAX
	call WriteDec														;print integer at index[EBX]
	call WriteString													;print some spaces between integers
	ADD  EBX, 4															;move to next element
	loop PrintArray													;repeats arraySize times
	POPAD																	;return registers to initial values
	RET
PrintThePermutation ENDP

;-----------------------------------------------------
PermutateTheArray PROC
;
; Permutates "theArray" that the user entered based on
; the values the user entered into "thePermutation".
; Recieves: DWORD variable "arraySize", DWORD array 
; "theArray", DWORD array "thePermutation", DWORD 
; variable "varI", DWORD variable "varJ", DWORD 
; variable "sizeI", and DWORD variable "sizeJ".
; Returns: DWORD array "theArray" and DWORD array 
; "thePermutation".
; Requires: DWORD variable "arraySize", DWORD array 
; "theArray", DWORD array "thePermutation", DWORD 
; variable "varI", DWORD variable "varJ", DWORD 
; variable "sizeI", and DWORD variable "sizeJ".
;-----------------------------------------------------
	PUSHAD																;save all registers
;INITIALIZE OUTTER LOOP	
	MOV  varI, 0														;(int i = 0) counter set for outter loop
	MOV  EAX, arraySize												;store arraySize in EAX to be moved into sizeI
	MOV  sizeI, EAX													;store the arraySize into sizeI
	SUB  sizeI, 2														;(size - 2) codition set for outer loop

	Outter:
	;OUTTER BODY

		MOV  EAX, varI													;put our i into EAX as an index
		MOV  EBX, thePermutation[EAX*4]							;put thePermutation[i] into EBX
		MOV  ECX, theArray[EBX*4]									;put theArray[thePermutation[i]] into ECX
		XCHG theArray[EAX*4], ECX									;exchange theArray[i] with theArray[thePermutation[i]]
		MOV  theArray[EBX*4], ECX									;put the value from theArray[thePermutation[i]] into theArray[i]

			;INITIALIZE INNER LOOP
				MOV  EAX, varI											;move varI into EAX to set up varJ
				ADD  EAX, 1												;EAX contains (varI + 1) aka varJ
				MOV  varJ, EAX											;(int j = (i + 1)) counter set for inner loop
				MOV  EAX, arraySize									;store arraySize to be moved into sizeJ
				MOV  sizeJ, EAX										;store the arraySize into sizeJ
				SUB  sizeJ, 1											;(size - 1) codition set for inner loop
	
				Inner:
				;INNER BODY

					MOV  EAX, varI										;move varI into EAX for checking if equal
					MOV  EBX, varJ										;move varJ into EBX for checking if equal
					CMP  EAX, thePermutation[EBX*4]				;compare varI to thePermutation[EBX*4]
					JE   Equal											;jump if equal to swap permutation[i] with permutation[j]
					JMP  NotEqual										;unconditional jump if NOT equal to avoid swapping values

				Equal:
					MOV  ECX, thePermutation[EAX*4]				;put thePermutation[i] into ECX
					XCHG thePermutation[EBX*4], ECX				;exchange thePermutation[j] with thePermutation[i]
					MOV  thePermutation[EAX*4], ECX				;put the value from thePermutation[j] into thePermutation[i]

				NotEqual:

				;END INNER BODY
					INC  varJ											;(j++) increment varJ
					MOV  EAX, sizeJ									;move sizeJ into eax for CMP
					CMP  varJ, EAX										;compare inner counter to inner condition
					JLE  Inner											;jump if counter is less than or equal to condition

	;END OUTTER BODY
		INC  varI														;(i++) increment varI
		MOV  EAX, sizeI												;move sizeI into eax for CMP
		CMP  varI, EAX													;compare outter counter to outter condition
		JLE  Outter														;jump if counter is less than or equal to condition
	POPAD																	;return registers to initial values
	RET
PermutateTheArray ENDP

END main