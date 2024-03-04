	.text
	.global uart_init
	.global gpio_btn_and_LED_init
	.global output_character
	.global read_character
	.global read_string
	.global output_string
	.global read_from_push_btns
	.global illuminate_LEDs
	.global illuminate_RGB_LED
	.global read_tiva_push_button
	.global div_and_mod

U0FR: 	.equ 0x18	; UART0 Flag Register


uart_init:
	PUSH {r4-r12,lr} 	; Store any registers in the range of r4 through r12
							; Your code for your uart_init routine is placed here
	MOV r0, #0xE618
    MOVT r0, #0x400F
    MOV r1, #0x1
    STR r1, [r0]



    MOV r0, #0xE608
    MOVT r0, #0x400F
    MOV r1, #0x1
    STR r1, [r0]



    MOV r0, #0xC030
    MOVT r0, #0x4000
    MOV r1, #0x0
    STR r1, [r0]



     MOV r0, #0xC024
    MOVT r0, #0x4000
    MOV r1, #8
    STR r1, [r0]



    MOV r0, #0xC028
    MOVT r0, #0x4000
    MOV r1, #44
    STR r1, [r0]



    MOV r0, #0xCFC8
    MOVT r0, #0x4000
    MOV r1, #0x0
    STR r1, [r0]



    MOV r0, #0xC02C
    MOVT r0, #0x4000
    MOV r1, #0x60
    STR r1, [r0]



    MOV r0, #0xC030
    MOVT r0, #0x4000
    MOV r1, #0x301
    STR r1, [r0]



    MOV r0, #0x451C
    MOVT r0, #0x4000
    MOV r1, #0x03
    LDR r2 ,[r0]
    ORR r1 , r1, r2
    STR r1, [r0]


    MOV r0, #0x4420
    MOVT r0, #0x4000
    MOV r1, #0x03
    LDR r2 ,[r0]
    ORR r1 , r1, r2
    STR r1, [r0]


	MOV r0, #0x452C
    MOVT r0, #0x4000
    MOV r1, #0x11
    LDR r2 ,[r0]
    ORR r1 , r1, r2
    STR r1, [r0]

	POP {r4-r12,lr}  	; Restore registers from stack
	MOV pc, lr

gpio_btn_and_LED_init:
	PUSH {r4-r12,lr}	; Spill registers to stack

	;Enable Clocks for Ports B, D, and F
	MOV r4, #0xE000
	MOVT r4, #0x400F
	LDRB r5, [r4, #0x608]		  ;00  1  0  1  0  1  0
	ORR r5, r5, #0x2A ;0010 1010  Port F, E, D, C, B, A
	STRB r5, [r4, #0x608]

	;Port F Pin 4 is input, write 0
		; - need a pull-up resistor for SW1
	; Port D Pins 0-3 are input for Btns, write 0
	; Port B Pins 0-3 are output for LEDs, write 1
	; Port B Base Address-> 0x40005000
	MOV r6, #0x5000
	MOVT r6, #0x4000
	;Port D Base Address -> 0x40007000
	MOV r7, #0x7000
	MOVT r7, #0x4000

	;Port F Base Address -> 0x40025000
	MOV r8, #0x5000
	MOVT r8, #0x4002

	;Set Pin Directions
	;Port B Pin Direction is Output, write 1 to pins 0 - 3
	LDRB r9, [r6, #0x400]
    ORR r9, r9, #0x0F ;configure pins 0 - 3 as output
    STRB r9, [r6, #0x400] ; write 1 to mem

	;Port D Pin Direction is Input, Write 0 to pins 0-3
	LDRB r9, [r7, #0x400]
	AND r9, r9, #0x00
	STRB r9, [r7, #0x400]

	;Port F Pin Direction is Input, Write 0 to pin 4
	; Port F Pin Direction Output for pins 0 - 3, write 1
	LDRB r9, [r8, #0x400]
	ORR r9, r9, #0x0E ; 0000 1110
	STRB r9, [r8, #0x400]

    ;SET PIN AS DIGITAL
    ; Set Pins 0-3 in Port B Digital, write 1
    LDRB r10, [r6, #0x51C]
    ORR r10, r10, #0x0F
    STRB r10, [r6, #0x51C]

    ; Set Pins 0-3 in Port D Digital, write 1
    LDRB r11, [r7, #0x51C]
    ORR r11, r11, #0x0F
    STRB r11, [r7, #0x51C]

    ; Initilize Pull-up resistor for Port F, write 1
    LDRB r12, [r8, #0x510]
    ORR r12, r12, #0x10
    STRB r12, [r8, #0x510]

    ; Set Pin pins 1-4 in Port F Digital, write 1
    LDRB r12, [r8, #0x51C]
    ORR r12, r12, #0x1E
    STRB r12, [r8, #0x51C]

          ; Your code is placed here

	POP {r4-r12,lr}  	; Restore registers from stack
	MOV pc, lr

output_character:
	PUSH {r4-r12,lr}	; Spill registers to stack

          ; Your code is placed here
	MOV r1, #0xC000			;Base address
	MOVT r1, #0x4000
LOOP2:
	LDRB r2, [r1, #U0FR]
	AND r2,r2, #0x20
	CMP r2, #0x20
	BEQ LOOP2
	STRB r0,[r1]

	POP {r4-r12,lr}  	; Restore registers from stack
	MOV pc, lr

read_character:
	PUSH {r4-r12,lr}	; Spill registers to stack

          ; Your code is placed here
  	MOV r1, #0xC000
	MOVT r1, #0x4000

LOOP1:

	LDRB r2, [r1, #U0FR]
	AND r2,r2, #0x10
	CMP r2, #0x10
	BEQ LOOP1

	LDRB r0,[r1]

	POP {r4-r12,lr}  	; Restore registers from stack
	MOV pc, lr

read_string:
	PUSH {r4-r12,lr}	; Spill registers to stack

          ; Your code is placed here
    MOV r4, r0

LOOP_RS:
    BL read_character
    CMP r0, #0xD
    BEQ ENTER
    STRB r0, [r4]
    BL output_character
    ADD r4, r4, #1
    B LOOP_RS

ENTER:
    MOV r0, #0x0
    STRB r0, [r4]

	POP {r4-r12,lr}  	; Restore registers from stack
	MOV pc, lr

output_string:
	PUSH {r4-r12,lr}	; Spill registers to stack

          ; Your code is placed here
    MOV r4, r0

LOOP_OS:
	LDRB r6, [r4]
	ADD r4, r4, #1

	CMP r6, #0x0
	BEQ EXIT
	MOV r0,r6
	BL output_character
	B LOOP_OS



EXIT:

	POP {r4-r12,lr}  	; Restore registers from stack
	MOV pc, lr

read_from_push_btns:
	PUSH {r4-r12,lr}	; Spill registers to stack

          ; Your code is placed here
    ;Initilize r3 with PORT D Base Address
    MOV r3, #0x7000
    MOVT r3, #0x4000

 	;GPIODATA
 	LDRB r9, [r3, #0x3FC]
 	AND r9, r9, #0x0F ; if r9 == 0000 0001 SW5 is pressed
 					  ; if r9 == 0000 0010 SW4 is pressed
 					  ; if r9 == 0000 0100 SW3 is pressed
 					  ; if r9 == 0000 1000 SW2 is pressed

 	;Find which button was pressed
 	CMP r9, #0x01 ; SW5 is pressed
 	BEQ PRESS_5

 	CMP r9, #0x02; SW4 is pressed
 	BEQ PRESS_4

 	CMP r9, #0x04; SW3 is pressed
 	BEQ PRESS_3

 	CMP r9, #0x08; SW2 is pressed
 	BEQ PRESS_2

 	MOV r0, #0 ; Nothing is pressed
 	B STOP_BTNS

PRESS_5:
	MOV r0, #5
	B STOP_BTNS
PRESS_4:
	MOV r0, #4
	B STOP_BTNS
PRESS_3:
	MOV r0, #3
	B STOP_BTNS
PRESS_2:
	MOV r0, #2
	B STOP_BTNS

STOP_BTNS:
	POP {r4-r12,lr}  	; Restore registers from stack
	MOV pc, lr

illuminate_LEDs:
	PUSH {r4-r12,lr}	; Spill registers to stack

          ; Your code is placed here
    ;Get LEDS
    ;MOV r0, #0 ;First LED
    ;MOV r0, #1 ; Second LED
    ;MOV r0, #2 ; Third LED
    ;MOV r0, #3; 4th LED
    MOV r0, #5 ; ALL LEDS

	; Get Port B Base Address
	MOV r6, #0x5000
	MOVT r6, #0x4000

	LDRB r1, [r6, #0x3FC]
    CMP r0, #0
    BEQ LED0

    CMP r0, #1
    BEQ LED1

    CMP r0, #2
    BEQ LED2

    CMP r0, #3
    BEQ LED3

    CMP r0, #4
    BEQ LEDALL
LED0:
	ORR r1, r1, #0x01
	STRB r1, [r6, #0x3FC]
	B LED_STOP

LED1:
	ORR r1, r1, #0x02
	STRB r1, [r6, #0x3FC]
	B LED_STOP

LED2:
	ORR r1, r1, #0x04
	STRB r1, [r6, #0x3FC]
	B LED_STOP

LED3:
	ORR r1, r1, #0x08
	STRB r1, [r6, #0x3FC]
	B LED_STOP
LEDALL:
	ORR r1, r1, #0x0F
	STRB r1, [r6, #0x3FC]
	B LED_STOP
LED_STOP:

	POP {r4-r12,lr}  	; Restore registers from stack
	MOV pc, lr

illuminate_RGB_LED:

	PUSH {r4-r12,lr}	; Spill registers to stack

          ; Your code is placed here
    ;Initialize Clock Address
    ; Color is passed in from r0
    ;MOV r0, #1 	;RED
    ;MOV r0, #2 ;BLUE
    ;MOV r0, #3 ;GREEN
    ;MOV r0, #4 ;PURPLE -> RED AND BLUE
    MOV r0, #5 ;YELLOW -> RED AND GREEN
    ;MOV r0, #6 ;WHITE -> RED, BLUE, AND GREEN

    MOV r3, #0x5000
    MOVT r3, #0x4002

    LDRB r9, [r3, #0x3FC] ; GPIODATA

	CMP r0, #1
	BEQ RED

 	CMP r0, #2
  	BEQ BLUE

   	CMP r0, #3
	BEQ GREEN

	CMP r0, #4
	BEQ PURPLE

	CMP r0, #5
	BEQ YELLOW

	CMP r0, #6
	BEQ WHITE


    ; RED , turn on pin 1, turn off pin 2 and 3
RED:
    ORR r9, r9, #0x02     ; need to turn pin 1 on that is 0000 0010
    STRB r9, [r3, #0x3FC]		; Turn on 0000 0010
	B COLOR_STOP

    ; BLUE, turn on pin 2, turn off pin 1 and 3 so 0000 0100
BLUE:
	ORR r9, r9, #0x04
	STRB r9, [r3, #0x3FC]
	B COLOR_STOP

    ; GREEN, turn on pin 3, turn off pin 1 and 2 so 0000 1000
GREEN:
	ORR r9, r9, #0x08
	STRB r9, [r3, #0x3FC]
	B COLOR_STOP

    ; PURPLE = red + blue, pins 1 and 2 on, 3 off -> 0000 0110
PURPLE:
	ORR r9, r9, #06
	STRB r9, [r3, #0x3FC]
	B COLOR_STOP

    ; YELLOW = red + green, pins 1 and 3, 2 off -> 0000 1010
YELLOW:
	ORR r9, r9, #0x0A
	STRB r9, [r3, #0x3FC]
	B COLOR_STOP

    ; WHITE = red + blue + green, pins 1-3 on -> 0000 1110
WHITE:
	ORR r9, r9, #0x0E
	STRB r9, [r3, #0x3FC]
	B COLOR_STOP

COLOR_STOP:

	POP {r4-r12,lr}  	; Restore registers from stack
	MOV pc, lr

read_tiva_push_button:
	PUSH {r4-r12,lr}	; Spill registers to stack

          ; Your code is placed here

    ;Initialize r3 with Port F address
    MOV r3, #0x5000
    MOVT r3, #0x4002

    LDRB r9, [r3, #0x3FC] ;GPIODATA
    AND r9, r9, #0x10	;

    CMP r9, #0x10 ; check if pin is being pressed
    BNE PRESS ; if r9 == 0, r0 = 1
    MOV r0, #0 ; if r9 == 1, r0 = 0
    B STOP

PRESS:
	MOV r0, #1; button is being pressed


STOP:


	POP {r4-r12,lr}  	; Restore registers from stack
	MOV pc, lr

div_and_mod:
	PUSH {r4-r12,lr}	; Spill registers to stack

          ; Your code is placed here
	;ldr r7, ptr_to_quotient
	;ldr r8, ptr_to_remainder
							; Your code for your div_and_mod routine is placed here
	CMP r0, #0		; check if inital dividend is zero
	BEQ ZEROS		; if yes branch to ZEROS

	CMP r0,r1
	BEQ SAME



	MOV r2, #0 		; initialize register to 0 will be used as a counter
	MOV r3, r0		; initialize register to 0 will be used to calc remainder
	MOV r4, r1 		; copy of divisor used at end to calc remainder


	CMP r0, #0		;compare with zero
	BLT LZERO		;branch to LZERO if dividend is negative
	BGT GZERO		;branch to GZERO if dividend is positive

GZERO:
	CMP r1, #0 		;check if divisor is negative
	BGT	POSDIVG
	RSB r4, r4, #0
	BLT NEGDIVG

NEGDIVG:
	ADD r3, r3, r1	;subtract dividend copied in r3 by divisor
	CMP r3, #0		;Comparing r3 to 0
	SUB r2, r2, #1	;incrementing counter
	BGT NEGDIVG		;if r3 is greater than zero loop back to NEGDIVG
	ADD r2, r2, #1	;decrement counter since remainder is encountered
	MOV r0, r2		;counter is moved to r0 as quotient
	RSB r1, r3, #0	;remainder is stored in r1
	SUB r1, r4, r1
	B LAST			;branch to end

POSDIVG:
	SUB r3, r3, r1	;subtract dividend copied in r3 by divisor
	CMP r3, #0		;Comparing r3 to 0
	ADD r2, r2, #1	;incrementing counter
	BGT POSDIVG		;if r3 is greater than zero loop back to GZERO
	SUB r2, r2, #1	;decrement counter since remainder is encountered
	MOV r0, r2		;counter is moved to r0 as quotient
	RSB r1, r3, #0	;remainder is flipped from negative to positive and stored in r1
	SUB r1, r4, r1
	B LAST			;branch to end


LZERO:
	CMP r1, #0 		;check if divisor is negative
	BGT	POSDIVL
	RSB r4, r4, #0
	BLT NEGDIVL

POSDIVL:
	ADD r3, r3, r1
	SUB r2,r2, #1
	CMP r3, #0
	BLT POSDIVL
	ADD r2,r2, #1
	MOV r0, r2		;counter is moved to r0 as quotient
	MOV r1, r3		;remainder is stored in r1
	SUB r1, r4, r1
	B LAST			;branch to end

NEGDIVL:
	SUB r3, r3, r1
	ADD r2,r2, #1
	CMP r3, #0
	BLT NEGDIVL
	SUB r2,r2, #1
	MOV r0, r2		;counter is moved to r0 as quotient
	SUB r1, r4, r3		;remainder is stored in r1
	B LAST			;branch to end


ZEROS:
	MOV r0, #0		;assigns zero to quotient
	MOV r1, #0		;assigns zero to remainder
	B LAST

SAME:
	MOV r0, #1
	MOV r1, #0
	B LAST


LAST:
	MOV r7, r0
	MOV r8, r1

	POP {r4-r12,lr}  	; Restore registers from stack
	MOV pc, lr

	.end
