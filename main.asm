;====================================================================
; Main.asm file generated by New Project wizard
;
; Created:   Sun Jan 25 2015
; Created By: Anindya Sundar Manna
; Processor: AT89C2051
; Compiler:  ASEM-51 (Proteus)
;====================================================================

$NOMOD51
$INCLUDE (89C1051.MCU)

;====================================================================
; DEFINITIONS
;====================================================================

;====================================================================
; VARIABLES
;====================================================================

;====================================================================
; RESET and INTERRUPT VECTORS
;====================================================================

      ; Reset Vector
      org   0000h
      jmp   Start

;====================================================================
; CODE SEGMENT
;====================================================================

      org   0100h
Start:	
	MOV P1,00H
	MOV TMOD,#20H ;timer 1,mode 2(auto reload)
	MOV TH1, #-3 ;9600 baud rate
	MOV SCON,#50H ;8-bit, 1 stop, REN enabled
	SETB TR1
	
	MOV P1,#00H ;SET ALL PINS IN PORT 1
AGAIN:
;wait and receive   
	MOV A,#00H
	LCALL RECV
	CJNE A,#"A",RCV_B
	SETB P1.0
RCV_B:CJNE A,#"B",RCV_C
	SETB P1.1	
RCV_C:CJNE A,#"C",RCV_D
	SETB P1.2
RCV_D:CJNE A,#"D",RCV_E
	SETB P1.3
RCV_E:CJNE A,#"E",RCV_F
	SETB P1.4	
RCV_F:CJNE A,#"F",RCV_G
	SETB P1.5
RCV_G:CJNE A,#"G",RCV_H
	SETB P1.6	
RCV_H:CJNE A,#"H",RCVSM_A
	SETB P1.7
	
RCVSM_A:CJNE A,#"a",RCVSM_B
	CLR P1.0
RCVSM_B:CJNE A,#"b",RCVSM_C
	CLR P1.1	
RCVSM_C:CJNE A,#"c",RCVSM_D
	CLR P1.2
RCVSM_D:CJNE A,#"d",RCVSM_E
	CLR P1.3
RCVSM_E:CJNE A,#"e",RCVSM_F
	CLR P1.4	
RCVSM_F:CJNE A,#"f",RCVSM_G
	CLR P1.5
RCVSM_G:CJNE A,#"g",RCVSM_H
	CLR P1.6	
RCVSM_H:CJNE A,#"h",BLINK
	CLR P1.7
BLINK:
	;LCALL DELAY
	;SETB P3.7
	;LCALL DELAY
	;CLR P3.7
;transfer status
	L1:JB P1.0,H1
	MOV A,#"A"	;
	ACALL TRANS	;	CODE TO TRANSFER A
	
	SJMP L2		;	JUMP TO NEXT CHECK WITHOUT SETTING a
	H1:MOV A,#"a";
	ACALL TRANS;	CODE TO TRANSFER a
	
	L2:JB P1.1,H2
	MOV A,#"B"
	ACALL TRANS
	
	SJMP L3	
	H2:MOV A,#"b"
	ACALL TRANS
		
	L3:JB P1.2,H3
	MOV A,#"C"
	ACALL TRANS
	
	SJMP L4
	H3:MOV A,#"c"
	ACALL TRANS
		
	L4:JB P1.3,H4
	MOV A,#"D"	;
	ACALL TRANS	;	
	
	SJMP L5		;	
	H4:MOV A,#"d";
	ACALL TRANS;	
		
	L5:JB P1.4,H5
	MOV A,#"E"	;
	ACALL TRANS	;	
	
	SJMP L6		;	
	H5:MOV A,#"e";
	ACALL TRANS;			
	L6:JB P1.5,H6
	MOV A,#"F"	;
	ACALL TRANS	;	
	
	SJMP L7		;	
	H6:MOV A,#"f";
	ACALL TRANS;	
	
	L7:JB P1.6,H7
	MOV A,#"G"	;
	ACALL TRANS	;	
	;	;
	SJMP L8		;	
	H7:MOV A,#"g";
	ACALL TRANS;	
	
	L8:JB P1.7,H8
	MOV A,#"H"	;
	ACALL TRANS	;	
	
	SJMP L9		;	
	H8:MOV A,#"h";
	ACALL TRANS;	
		
	L9:NOP
	
	LJMP AGAIN ;keep doing it
	;serial data transfer subroutine
	TRANS: MOV SBUF,A ;load SBUF
	HERE: JNB TI,HERE ;wait for the last bit
	CLR TI ;get ready for next byte
	RET
	;serial data receive subroutine
	RECV: JNB RI,RECV ;wait here for char
	MOV A,SBUF ;save it in ACC
	CLR RI ;get ready for next char
	RET 

;====================================================================
      END
