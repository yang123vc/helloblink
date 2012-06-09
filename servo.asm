;********************************************************************
;* LED blinker: LED will blink with a X on/off ratio at PD6
;*
;* NOTE: delay depends in the value of X, 1 is fast, 255 is slow
;*
;* No copyright ©1998 RESÆ * FREEWARE *
;*
;* NOTE: Connect a low current LED with a 1k resistor in serie from
;*	 Vdd to pin 11 of the MCU. (Or a normal LED with a 330ohm)
;*
;* RESÆ can be reached by email: at90s2313@europe.com
;* or visit the website: http://www.attiny.com
;*
;* Original Version  :1.0
;* Date		     :12/26/98
;* Author	     :Rob's ElectroSoft
;* Target MCU        :AT90S1200-12PI@4MHz
;*
;* copyright (CC BY-NC 3.0)
;* http://creativecommons.org/licenses/by-nc/3.0/
;*
;* Version           : 0.1
;* Date		     : 20120523
;* Author	     : Michael Tomkins
;* Target MCU        : ATTINY13
;********************************************************************


; You can get the tn13def.inc from http://www.attiny.com/software/AVR000.zip
; or http://www.atmel.com/products/microcontrollers/avr/tinyAVR.aspx

.include "tn13def.inc"

	rjmp	reset		;reset handle


	brne  pulse	; 2t 1f
	ret


; high pulse is ~0.001 or 1000 times a second
; low pulse is ~0.02 or 50 times a second

pulse:
;* Code
	sbi   PORTB, 0  ; 5 / 1
	sbi   PORTB, 2  ; 5 / 1
        mov   r1, r16   ; 1, 100-1 times to get pulse length.
high_rst:

        mov   r0, r19   ; 1
;       clr   r0  ; 1
high_loop: 		; 3n(32*3+3)
	dec   r0
	brne  high_loop	; 2t 1f
	dec   r1	; 1
	brne  high_rst ; 2t 1f
	cbi   PORTB, 0  ; 1
	cbi   PORTB, 2  ; 1
;	dec   r17	; 1
;	brne  pulse	; 2t 1f
;	dec   r18	; 1
;	brne  pulse	; 2t 1f


       mov   r1, r17   ; 1
;       clr   r1  ; 1
;low_rst:
;       mov   r0, r16   ; 1
;        clr   r0  ; 1
low_loop:		; 3n(256*3+3)
	dec   r0
	brne  low_loop	; 2t 1f
	dec   r1       ; 1
;	cbi   PORTB, 0
;	sbi   PORTB, 1
	brne  low_loop	; 2t 1f
       ; mov   r2, r20   ; 1
;	dec   r17	; 1
;	brne  pulse	; 2t 1f
	dec   r18
	brne  pulse
	ret

reset:

	.equ	r19, 	0x20 ;
	cli

main:
	ldi   r19, 0x20		; This way we have nice up times.
	cbi   PORTB, 3
	sbi   PORTB, 4
	ldi   r16, 0x64		; 1 ms pulse, 9600 cycles (or 100x :)
	ldi   r17, 0xe6		; 19 ms low, 182400 cycles
	ldi   r18, 0x33		; repeat 50 * 20 ms = 1s, 50 * 192000 = 9.6Mcycles
	rcall pulse
	cbi   PORTB, 4
	sbi   PORTB, 3
	ldi   r16, 0x84		; 1 ms pulse, 9600 cycles (or 100x :)
	ldi   r17, 0xe6		; 19 ms low, 182400 cycles
	ldi   r18, 0x33		; repeat 50 * 20 ms = 1s, 50 * 192000 = 9.6Mcycles
	rcall pulse
	ldi   r16, 0xfa		; 1 ms pulse, 9600 cycles (or 100x :)
	ldi   r17, 0xe6		; 19 ms low, 182400 cycles
	ldi   r18, 0x33		; repeat 50 * 20 ms = 1s, 50 * 192000 = 9.6Mcycles
	rcall pulse
	ldi   r16, 0x40		; 1 ms pulse, 9600 cycles (or 100x :)
	ldi   r17, 0xe6		; 19 ms low, 182400 cycles
	ldi   r18, 0x33		; repeat 50 * 20 ms = 1s, 50 * 192000 = 9.6Mcycles
	rcall pulse
	rjmp  main		;another run


;pulse
	ldi   r16, 0xb5		; 1 ms pulse, 9600 cycles (or 100x :)
	ldi   r17, 0xe6		; 19 ms low, 182400 cycles
	ldi   r18, 0x04		; repeat 50 * 20 ms = 1s, 50 * 192000 = 9.6Mcycles
	ldi   r19, 0x1f		; This way we have nice up times.
;low
