TITLE Encryption Program               (Encrypt.asm)

;This program allows a user to enter
;a message and a key for XOR based 
;encryption and decryption, then
;shows the user the resulting strings.

INCLUDE Irvine32.inc

BUFMAX = 128     														;maximum buffer size

.data
sPrompt  BYTE  "Enter the plain text: ",0
sKey		BYTE  "Enter the key:        ",0
sEncrypt BYTE  "Cipher text:          ",0
sDecrypt BYTE  "Decrypted:            ",0

buffer   BYTE   BUFMAX+1 DUP(0)
bufSize  DWORD  ?
key		BYTE	 BUFMAX+1 DUP(0)
keySize  DWORD	 ?

.code
main PROC

	call InputTheString												;input the plain text
	call InputTheKey													;input the key
	call TranslateBuffer												;encrypt the buffer with the key
	MOV  EDX, OFFSET sEncrypt										;display encrypted message
	call DisplayMessage
	call TranslateBuffer  											;decrypt the buffer against the key
	MOV  EDX, OFFSET sDecrypt										;display decrypted message
	call DisplayMessage
	call WaitMsg

	exit
main ENDP

;-----------------------------------------------------
InputTheString PROC
;
; Asks the user to enter a string from the
; keyboard. Saves the string and its length
; in the variables.
; Receives: nothing. Returns: nothing
; Requires: BYTE array named "buffer" to accept input
;-----------------------------------------------------
	PUSHAD
	MOV  EDX, OFFSET sPrompt										;display a prompt
	call WriteString
	MOV  ECX, BUFMAX         										;maximum character count
	MOV  EDX, OFFSET buffer   										;point to the buffer
	call ReadString         										;input the string
	MOV  bufSize, EAX        										;save the length
	call Crlf
	POPAD
	RET
InputTheString ENDP

;-----------------------------------------------------
InputTheKey PROC
;
; Asks the user to enter a string from the
; keyboard. Saves the string and its length
; in variables.
; Receives: nothing. Returns: nothing
; Requires: BYTE array named "key" to accept input
;-----------------------------------------------------
	PUSHAD
	MOV  EDX, OFFSET sKey											;display a prompt
	call WriteString
	MOV  ECX, BUFMAX         										;maximum character count
	MOV  EDX, OFFSET key	   										;point to the key
	call ReadString         										;input the string
	MOV  keySize, EAX        										;save the length
	call Crlf
	POPAD
	RET
InputTheKey ENDP

;-----------------------------------------------------
DisplayMessage PROC
;
; Display the encrypted or decrypted message.
; Receives: EDX points to a context message
; Returns:  nothing
; Requires:  BYTE array named "buffer" with encrypted
;		or decrypted message
;-----------------------------------------------------
	PUSHAD
	call WriteString
	MOV  EDX, OFFSET buffer											;display the buffer
	call WriteString
	call Crlf
	call Crlf
	POPAD
	RET
DisplayMessage ENDP

;-----------------------------------------------------
TranslateBuffer PROC
;
; Translates the string by exclusive-ORing each byte
; with the user entered key. *Note: key must be moved
; into the a register because you can not xor memory
; with memory, and the size of buffer and key must be
; the same!
; Receives: nothing.  Returns: nothing
; Requires:  BYTE array named "buffer" with plaintext 
;		or ciphertext.  DWORD bufSize that holds
;		the length of the message. BYTE array named "key"
;		with the key.
;-----------------------------------------------------
	PUSHAD
	MOV  ECX, bufSize													;loop counter
	MOV  ESI, 0															;index 0 in buffer
L2:	
	MOV  EBX, 0															;index 0 in key
L1:
	MOV  AL, key[EBX]													;put byte at key[ebx] into al
	CMP  AL, 0															;check if that byte is 0
	JZ   L2																;jump L2 to restart index 0
	INC  EBX																;point to next byte in key
	XOR  buffer[ESI], AL												;translate a byte
	INC  ESI																;point to next byte in buffer
	loop L1																;loop to translate next byte

	POPAD
	RET
TranslateBuffer ENDP
END main