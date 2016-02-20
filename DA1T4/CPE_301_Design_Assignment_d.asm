.nolist
.include "m328pdef.inc"
.equ stacktop = $08DF
.equ div_no1 = $7
.equ div_no2 = $3
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
   ;for divisibility by 7
	ld r17 , -Y
	mov r18 , r17
	ldi r19 , $0 
	rcall find_rem7
    cpi r17 , $0
	brne skip1
    add r20 , r18 
	adc r21 , r19
skip1:
	;for divisibility by 3 
    ld r17 , Y
	mov r18 , r17
	ldi r19 , $0
	rcall find_rem3
	cpi r17 , $0
	brne skip2
    add r23 , r18
	adc r24 , r19 
skip2:
	dec r16
	brne memory_parse_loop
    brbc $0 , end
	andi r22 , $04
    mov  r7  , r22

end: jmp end

find_rem7:
	loop_start1:
		sbci r17 , div_no1
		cpi  r17 , div_no1
		brcc loop_start1 
ret

find_rem3:
	loop_start2:
		sbci r17 , div_no2
		cpi  r17 , div_no2
		brcc loop_start2 
ret
