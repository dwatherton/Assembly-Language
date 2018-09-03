;Program Template (Template.asm)

;Program Description: Lab I for Computer Systems and Assembly Language
;Author: Daniel Atherton
;Creation Date: 2/12/2018
;Revisions: Optimized with CALL WaitMsg rather than INVOKE sleep, 10000
;Date: 03/08/18				Modified by: Daniel Atherton

INCLUDE irvine32.inc

.386
.model flat,stdcall
.stack 4096
ExitProcess PROTO, dwExitCode:DWORD
.data
	welcome BYTE "Welcome! This program subtracts three integer numbers.", 0Dh, 0Ah, 0			  ;string containing "Welcome! This program subtracts three integer numbers."
	prompt BYTE "Please input three integers x, y, and z.", 0Dh, 0Ah, 0								  ;string containing a prompt "Please input three integers x, y, and z."
	result BYTE "The result of (x-y-z) is: ", 0													           ;string containing "The result of (x-y-z) is: "
	xVar BYTE "x: ", 0																								  ;string containing "x: "
	yVar BYTE "y: ", 0																								  ;string containing "y: "
	zVar BYTE "z: ", 0																								  ;string containing "z: "
.code
main PROC
	L1:																													  ;loop back to the top and let the user input three more integers to subtract
	MOV	EDX, OFFSET welcome																						  ;move welcome string to the EDX register
	CALL WriteString																									  ;display the welcome message held in the EDX register
	CALL CrLf																											  ;display a blank line below the welcome string (Carriage Return Line Feed)
	MOV	EDX, OFFSET prompt																						  ;move prompt string to the EDX register
	CALL WriteString																									  ;display the prompt message held in the EDX register
	CALL CrLf																											  ;display a blank line below the prompt string (Carriage Return Line Feed)
	MOV	EDX, OFFSET xVar																							  ;move xVar string to the EDX register
	CALL WriteString																									  ;display the x: indicator for the user
	CALL ReadInt																										  ;read a 32-bit signed decimal integer from keyboard input and store it in the EAX register
	MOV	EBX, EAX																										  ;move the keyboard input 32-bit signed decimal integer into EBX to store until needed
	CALL CrLf																											  ;display a blank line below the integer that was inputted by keyboard
	MOV	EDX, OFFSET yVar																							  ;move the yVar string to the EDX register
	CALL WriteString																									  ;display the y: indicator for the user
	CALL ReadInt																										  ;read a 32-bit signed decimal integer from keyboard input and store it in the EAX register
	MOV	ECX, EAX 																									  ;move the keyboard input 32-bit signed decimal integer into ECX to store until needed
	CALL CrLf																											  ;display a blank line below the integer that was inputted by keyboard
	MOV	EDX, OFFSET zVar																							  ;move the zVar string to the EDX register
	CALL WriteString																									  ;display the z: indicator for the user
	CALL ReadInt																										  ;read a 32-bit signed decimal integer from keyboard input and store it in the EAX register
	MOV	EDX, EAX 																									  ;move the keyboard input 32-bit signed decimal integer into EDX to store until needed
	CALL CrLf																											  ;display a blank line below the integer that was inputted by keyboard
	SUB	EBX, ECX																										  ;subtract the integer value stored in EBX by the value in ECX and store it back into EBX
	SUB	EBX, EDX																										  ;subtract the integer value stored in EBX by the value in EDX and store it back into EBX
	MOV	EAX, EBX																										  ;move the resulting value from subtracting x-y-z from register EBX into EAX so it can be displayed
	MOV	EDX, OFFSET result																						  ;move result string to the EDX register
	CALL WriteString																									  ;display the result message held in the EDX register
	CALL WriteDec																										  ;display the integer value held in the EAX register
	CALL CrLf																											  ;display a blank line below the result string (Carriage Return Line Feed)
	CALL CrLf																											  ;display a blank line below the result string (Carriage Return Line Feed)
	CALL WaitMsg																										  ;wait for user input to see the answer
	CALL ClrScr																											  ;clear the screen for the user to subtract three more numbers
	JMP L1																												  ;jump to L1 to create an infinite loop as requested by instructor
	INVOKE ExitProcess,0
main ENDP
;insert additional procedures here
END main