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


uart_init:
	PUSH {r4-r12,lr}	; Spill registers to stack

          ; Your code is placed here
	;BL read_from_push_btns

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
	LDRB r9, [r8, #0x400]
	AND r9, r9, #0x00
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

    ; Set Pin 4 in Port F Digital, write 1
    LDRB r12, [r8, #0x51C]
    ORR r12, r12, #0x10
    STRB r12, [r8, #0x51C]

          ; Your code is placed here

	POP {r4-r12,lr}  	; Restore registers from stack
	MOV pc, lr

output_character:
	PUSH {r4-r12,lr}	; Spill registers to stack

          ; Your code is placed here

	POP {r4-r12,lr}  	; Restore registers from stack
	MOV pc, lr

read_character:
	PUSH {r4-r12,lr}	; Spill registers to stack

          ; Your code is placed here

	POP {r4-r12,lr}  	; Restore registers from stack
	MOV pc, lr

read_string:
	PUSH {r4-r12,lr}	; Spill registers to stack

          ; Your code is placed here

	POP {r4-r12,lr}  	; Restore registers from stack
	MOV pc, lr

output_string:
	PUSH {r4-r12,lr}	; Spill registers to stack

          ; Your code is placed here

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

    CMP r0, #5
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

;luminate_RGB_LED:
;PUSH {r4-r12,lr}	; Spill registers to stack

          ; Your code is placed here

;POP {r4-r12,lr}  	; Restore registers from stack
;MOV pc, lr

read_tiva_pushbutton:
	PUSH {r4-r12,lr}	; Spill registers to stack

          ; Your code is placed here

	POP {r4-r12,lr}  	; Restore registers from stack
	MOV pc, lr

div_and_mod:
	PUSH {r4-r12,lr}	; Spill registers to stack

          ; Your code is placed here

	POP {r4-r12,lr}  	; Restore registers from stack
	MOV pc, lr

	.end
