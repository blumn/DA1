.nolist
.include "m328pdef.inc"
.equ RAMSTART=0x0100 
.list

.dseg

.cseg
.org $000
; init counter 
	ldi r16 , $19
; init pointer x to RAM middle   
	ldi r26 , low((RAMEND+RAMSTART)/2)
; init pointer y to RAM end
    ldi r28 , low(RAMEND)
	ldi r29 , high(RAMEND)
; loop
	st Y, r26
memory_copy_loop:
    dec r26
	st -Y, r26
	dec r16
	brne memory_copy_loop
