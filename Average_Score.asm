; Creators: Victor Gutierrez, Luis Garibay, Jose Morales
; Class: Cis 11
; Project: Test Score Calculator Program
; Exceptions: Do not input any Alpha characters, no special characters, or triple digit inputs (no 100), 
; Purpose of Program: Program will collect five of the user's test score inputs and provide the user with the average of the 
;			tests scores. 

;==============================main===========================================

.ORIG x3000

	LD R2, TOTAL
	
	AND R3, R3, #0			; CLEAR R3
	ADD R3, R3, #5			; R3 = 5, LOOP COUNTER
GETSCORES
	LD	R4, HEXNUM
	LEA	R0, PROMPT		; stores prompt to R0
	PUTS				; prints prompt
	GETC				; obtains user charatcer
	OUT				; displays user input
	ADD R0, R0, R4
	JSR MULT10			; multiplies user's input subroutine
; SECOND INPUT
	AND R0, R0, #0			; CLEAR R0
	GETC				; gets second input
	OUT				; displays user input
	ADD R0, R0, R4			; ASCCI THING 
	ADD R6, R6, R0			; USER INPUT COMPLETE VALUE

	ADD R2, R2, R6			; ADDS ALL TESTS SCORES

	ST R2, TOTAL			; STORES R6 VALUE TO (TOTAL)
	ADD R3, R3, #-1			; SUBTRACT 1 FROM R3 UNTIL ZERO
	BRp GETSCORES			; LOOP INTO GETSCORES IF R3 IS STILL POS
;-------------------------------------------------------------------------=====================GETSCORES	
	
	JSR DIVIDE

	LEA R0, AVERAGE
	PUTS
	LD R4, HEXNUM
	LD R0, AVERAGENUMBER
	OUT
	;ADD R0, R0, R4
	;OUT

	LEA R0, ENDPROMPT		; load end prompt to R0
	PUTS				; display end prompt to screen

	HALT				
;===============================end of main=====================================







;==============================subroutines=======================================|


;----------------------MULTIPLY SUB------------------
MULT10	ADD R1, R0, #0		; COPY R0 TO R1
	NOT R1, R1		; INVERT FOR COUNTER
	ADD R1, R1, #1		; COUNTER R1
	AND R0, R0, #0		; CLEAR R0
LOOP10	ADD R0, R0, #10		; ADD 10 TO R0
	ADD R1, R1, #1		; ADD 1 UNTIL ZERO
	BRn LOOP10
	ADD R6, R0, #0		; R0 CARRIES VALUES NOW
	RET
;----------------------END OF MULT10-----------------

;-------------------------Division-----------------
DIVIDE
	AND R2, R2, #0			; clear R2
	LD R2, TOTAL			; load TOTAL into R2		y value
	
	AND R3, R3, #0			; CLEAR R3 FOR DENOMINATOR
	ADD R3, R3, #-5			; R3 = 5 TEST SCORES, OUR DENOM our x value

	AND R0, R0, #0
	AND R1, R1, #0			; CLEAR FOR OUR COUNTER, COUNTER WILL THE QUOTIENT	
	ADD R4, R2, #0			; COPY R2 TO R4
DIVLOOP ADD R1, R1, #1			; EVERY ITERATION INCREASING IT BY ONE.
	ADD R4, R4, R3			; Y = Y - X
	BRp DIVLOOP
	ADD R0, R1, #0			; COPIES R1 VALUE INTO R0
	
	ST R1, AVERAGENUMBER		; STORES OUR QUOTIENT TO AVERAGENUMBER
	
	RET

;--------------------------------------------------

;==========================end of subroutines=================

;===============================data========================
PROMPT	.STRINGZ "\nEnter a test score: "
ENDPROMPT	.STRINGZ "\n\nThank you for using the program.\n"


HEXNUM	.FILL XFFD0		; -48
TOTAL	.FILL X0
AVERAGE .STRINGZ "\n The average of the five tests scores is: "
AVERAGENUMBER	.FILL x0
;============================end of data=====================

.END