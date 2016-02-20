.nolist
.include "m328pdef.inc"
.equ stacktop = $08DF
.equ div_no = $3
.list

.dseg

.cseg
.org $000
; init counter
	ldi r16 , $19
; init stack pointer 
	ldi r22 , high(stacktop)
    out SPH , r22
	ldi r22 , low(stacktop) 
	out SPL , r22
; init pointer y to RAM end
    ldi r28 , low(RAMEND)
	ldi r29 , high(RAMEND)
; loop
memory_parse_loop:
	ld r17 , -Y
	mov r18 , r17
	ldi r19 , $0 
	rcall find_rem
    cpi r17 , $0
	brne skip
    add r20 , r18 
	adc r21 , r19
skip:
	dec r16
	brne memory_parse_loop
	
end: jmp end

find_rem:
	loop_start:
		sbci r17 , div_no
		cpi  r17 , div_no
		brcc loop_start

ret
