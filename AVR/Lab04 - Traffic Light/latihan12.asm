.include "m8515def.inc"

.def counter = r17 ; set temporary counter

; Description : 
; LED PORTC : green
; LED PORTD : red
; LED PORTE : yellow

.org $00 ; If reset
	rjmp RESET
.org $07 ; If overflow occur
	rjmp ISR_TOV0

RESET:
	ldi	r16,low(RAMEND)
	out	SPL,r16	            ;init Stack Pointer		
	ldi	r16,high(RAMEND)
	out	SPH,r16

	ldi r16, (1<<CS02) | (1<<CS00)	; 
	out TCCR0,r16			
	ldi r16,1<<TOV0
	out TIFR,r16		; Interrupt if overflow occurs in T/C0
	ldi r16,1<<TOIE0
	out TIMSK,r16		; Enable Timer/Counter0 Overflow int
	ser r16
	out DDRC,r16		; Set port C as output
	out DDRD,r16		; Set port D as output
	out DDRE,r16		; Set port E as output

	ldi r18, 0xFF ; variable to light up all led
	ldi r19, 0x00 ;  variable to turn off all led

	; set led to off at the beggining
	out PORTC, r19
	out PORTD, r19
	out PORTE, r19

	sei

forever:
	rjmp forever

; If overflow occurs
ISR_TOV0:
	tst counter ; if counter=0, go to green
	breq green
	
	ldi r20, 1 ; if counter = 1 , go to red
	cp counter,r20
	breq red

	ldi r20, 2 ; if counter = 2 , go to yellow
	cp counter,r20
	breq yellow

; light up green , and turn off others
green:
	inc counter
	out PORTC, r18
	out PORTD, r19
	out PORTE, r19
	reti

; light up red , and turn off others
red:
	inc counter
	out PORTC, r19
	out PORTD, r18
	out PORTE, r19
	reti
	
; light up yellow , and turn off others
yellow:
	ldi counter,0
	out PORTC, r19
	out PORTD, r19
	out PORTE, r18
	reti
