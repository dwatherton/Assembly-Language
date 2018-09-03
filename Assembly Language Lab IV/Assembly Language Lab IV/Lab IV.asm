;Assembly Language Lab IV - Finite State Machine (Lab IV.asm)

;Program Description: Allows a user to enter an array of characters then tests to see if it is valid
;hexidecimal using a Finite State Machine (FSM).
;Author: Daniel Atherton
;Creation Date: 4/12/2018
;Revisions: Fixed not recognizing end of array in StateC so that only vaild hex shows up as vaild.
;Date: 4/13/2018						Modified by: Daniel Atherton

INCLUDE irvine32.inc

BUFSIZE = 20																 ;set a buffersize for the character array

.386
.model flat,stdcall
.stack 4096
ExitProcess PROTO, dwExitCode:DWORD
.data

	welcome  BYTE "Welcome! This program takes user-entered characters and checks if they conform to MASM hexadecimal syntax!", 0Ah, 0Dh, 0
	prompt   BYTE "Enter the characters to check here: => ", 0
	valid    BYTE "Valid hexidecimal constant!", 0Ah, 0Dh, 0
	invalid  BYTE "Invalid hexidecimal constant!", 0Ah, 0Dh, 0

	hexArray BYTE BUFSIZE + 1 DUP(?)

.code
main PROC

	MOV  EDX, OFFSET welcome
	CALL WriteString													 	 ;tell the user what the program does
	CALL CrLf
	CALL EnterTheHex														 ;procedure to enter the characters to be checked
	CALL FiniteStateMachine												 ;procedure to check if the characters are valid hexadecimal
	CALL WaitMsg															 ;call waitmsg to pause to see the result
	INVOKE ExitProcess,0

main ENDP



;-----------------------------------------------------------
EnterTheHex PROC
;
; Prompts the user to enter an array of characters and saves 
; the user entered array into the BYTE array "hexArray".
; Recieves: BYTE string "prompt" and BYTE array "hexArray".
; Returns: BYTE array "hexArray".
; Requires: BYTE string "prompt" and BYTE array "hexArray".
;-----------------------------------------------------------
	pushad																	 ;save all registers
	MOV  EDX, OFFSET prompt
	CALL WriteString														 ;ask the user to enter the string of characters
	MOV  EDX, OFFSET hexArray											 ;point to my hexArray to store user entered characters
	MOV  ECX, BUFSIZE														 ;set the BUFSIZE as readstrings counter
	CALL ReadString														 ;get the user entered character array into hexArray
	CALL CrLf																 ;print a blank line
	popad																		 ;return all registers
	ret																		 ;return to main PROC one line after this procedure call
EnterTheHex ENDP



;-----------------------------------------------------------
FiniteStateMachine PROC
;
; Loops through an array of characters to determine 
; if it contains valid hexidecimal syntax. If it is valid
; hexidecimal, the message "valid hexidecimal constant"
; is printed to the console. If it is invalid 
; hexidecimal, the message "invalid hexidecimal constant"
; is printed to the console.
; Recieves: BYTE array "hexArray", BYTE string "valid", 
; and BYTE string "invalid".
; Returns: Nothing.
; Requires: BYTE array "hexArray", BYTE string "valid", 
; and BYTE string "invalid".
;-----------------------------------------------------------
	pushad																	 ;save all registers
	MOV  EAX, 0																 ;set our array index to 0

StateA:																		 ;StateA (Check digits 0 - 9) JE StateB
	CMP hexArray[EAX], "0"												 
	JE  StateB																 
	CMP hexArray[EAX], "1"
	JE  StateB
	CMP hexArray[EAX], "2"
	JE  StateB
	CMP hexArray[EAX], "3"
	JE  StateB
	CMP hexArray[EAX], "4"
	JE  StateB
	CMP hexArray[EAX], "5"
	JE  StateB
	CMP hexArray[EAX], "6"
	JE  StateB
	CMP hexArray[EAX], "7"
	JE  StateB
	CMP hexArray[EAX], "8"
	JE  StateB
	CMP hexArray[EAX], "9"												 
	JE  StateB																 
	JMP  InvalidHex														 ;jump InvalidHex if the first character is not 0 - 9	

StateB:																		 ;StateB (Check 0 - 9, A - F) JE StateB														
	INC  EAX																	 ;move to next element to check
	CMP hexArray[EAX], "0"
	JE  StateB
	CMP hexArray[EAX], "1"
	JE  StateB
	CMP hexArray[EAX], "2"
	JE  StateB
	CMP hexArray[EAX], "3"
	JE  StateB
	CMP hexArray[EAX], "4"
	JE  StateB
	CMP hexArray[EAX], "5"
	JE  StateB
	CMP hexArray[EAX], "6"
	JE  StateB
	CMP hexArray[EAX], "7"
	JE  StateB
	CMP hexArray[EAX], "8"
	JE  StateB
	CMP hexArray[EAX], "9"
	JE  StateB
	CMP hexArray[EAX], "A"
	JE  StateB
	CMP hexArray[EAX], "B"
	JE  StateB
	CMP hexArray[EAX], "C"
	JE  StateB
	CMP hexArray[EAX], "D"
	JE  StateB
	CMP hexArray[EAX], "E"
	JE  StateB
	CMP hexArray[EAX], "F"
	JE  StateB

	CMP hexArray[EAX], "h"												 ;check if element is h (if it's not 0 - 9, A - F)
	JE  StateC																 ;if element is h jump to StateC 
	JMP InvalidHex															 ;if element is not 0 - 9, A - F, or h, jump InvalidHex

StateC:
	INC  EAX																	 ;move to next element
	CMP  hexArray[EAX], 0												 ;check for null terminator (end of array of characters)
	JNE InvalidHex															 ;if not end of array of characters jump InvalidHex
	
	MOV  EDX, OFFSET valid
	CALL WriteString														 ;tells the user the hexidecimal constant is valid
	CALL CrLf
	JMP Done																	 ;we are done now, get out of the finite state machine!

InvalidHex:
	MOV  EDX, OFFSET invalid
	CALL WriteString														 ;tells the user the hexidecimal constant is invalid
	CALL CrLf
	JMP  Done																 ;we are done now, get out of the finite state machine!

Done:
	popad																		 ;return all registers
	ret																		 ;return to main PROC one line after this procedure call
FiniteStateMachine ENDP
END main