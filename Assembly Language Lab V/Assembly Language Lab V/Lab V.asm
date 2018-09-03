;Assembly Language Lab V (Lab V.asm)

;Program Description: This Assembly program computes and displays the nth Fibonacci number 
;for any positive integer, n, that the user enters.
;Author: Daniel Atherton
;Creation Date: 4/25/2018
;Revisions:
;Date:							Modified by:

INCLUDE irvine32.inc

.386
.model flat, C
.stack 4096
ExitProcess PROTO, dwExitCode:DWORD
.data

	welcome  BYTE "Welcome! This program computes and displays the nth Fibonacci Number for any positive integer!", 0Ah, 0Dh, 0
	getInput BYTE "Enter your choice here: => ", 0
	fib		BYTE "Fib(", 0
	equals	BYTE ") = ", 0
	period	BYTE ".", 0Ah, 0Dh, 0

	n		   DWORD ?
	result	DWORD ?

.code
main PROC

	MOV  EDX, OFFSET welcome												;welcome message to user
	CALL WriteString
L1:
	CALL Crlf
	MOV  EDX, OFFSET getInput												;prompt user for input (n)
	CALL WriteString
	CALL ReadInt																;get n value from user into EAX
	MOV  n, EAX																	;copy user entered integer into n (for output)
	
	PUSH EAX																		;push user entered value to be used in the procedure to the stack
	CALL FibonacciNum															;calculate fib(n), returns result in EAX
	MOV  result, EAX															;place fib(n) into result variable
	ADD  ESP, 4																	;clean up the stack (C calling convention)

	CALL Crlf
	MOV  EDX, OFFSET fib														;display "fib (" to console
	CALL WriteString
	MOV  EAX, n																	;show user entered n value
	CALL WriteDec
	MOV  EDX, OFFSET equals													;display ") = " to console
	CALL WriteString
	MOV  EAX, result															;show the user what fib(n) equals
	CALL WriteDec
	MOV  EDX, OFFSET period													;place period at end of sentence (super important, I know)
	CALL WriteString
	JMP  L1																		;added to quickly and easily show several Fibonacci Numbers
	CALL Crlf
	CALL WaitMsg																;wait message to see the result
	INVOKE ExitProcess, 0

main ENDP

;-----------------------------------------------------------
FibonacciNum PROC C
;
; Description: Takes the user entered value pushed onto the
; stack and calculates the resulting fibonacci number.
; Recieves: an the integer value pushed onto the stack.
; Returns: the resulting fibonacci number in register EAX.
; Requires: an integer value to be pushed to the stack.
;-----------------------------------------------------------

	PUSH EBP
	MOV  EBP, ESP
	SUB  ESP, 4																	;create space for a local dword variable at [ebp - 4]
	MOV  EAX, [EBP + 8]														;get the user entered n value from the top of stack

	;if  ((n == 1) || (n == 2)) { return n - 1 };
	CMP  EAX, 1																	;check if n == 1
	JE   ifCondition															;if n == 1 jump to ifCondition to DEC EAX
	CMP  EAX, 2																	;check if n == 2
	JE   ifCondition															;if n == 2 jump to ifCondition to DEC EAX

	;else { return fib(n-1) + fib(n-2) };
	DEC  EAX																		;decrease EAX, fib(n - 1)
	PUSH EAX																		;push fib(n - 1) to be used in the procedure to the stack
	CALL FibonacciNum															;recursion 1 occurs here, call FibonacciNum procedure
	MOV  [EBP - 4], EAX														;store first result for later use

	DEC  DWORD PTR [ESP]														;(n - 1) on the stack -> (n - 2)
	CALL FibonacciNum															;recursion 2 occurs here, call FibonacciNum procedure
	ADD  ESP, 4																	;clean up the stack

	ADD  EAX, [EBP - 4]														;add fib(n-1) + fib(n-2) in EAX to be returned

	JMP  Quit																	;jump to quit, avoid ifCondition in else statement

ifCondition:
	DEC  EAX																		;decrease EAX (returns n - 1)

Quit:
	MOV  ESP, EBP																;restore ESP
	POP  EBP																		;restore EBP

	RET																			;return EAX, stack not cleaned up (C calling convention)
FibonacciNum ENDP

END main