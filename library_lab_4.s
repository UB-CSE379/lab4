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

          ; Your code is placed here
    ;BL read_from_push_btns

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
    ;ENABLE CLOCK FOR PORT D
    MOV r1, #0xE000  ; get the SYSCTL_RCGC address into r1
    MOVT r1, #0x400F
    LDRB r4, [r1, #0x608] ; load r4 with r1 mem address
    ORR r4, r4, #0x08  ; write 1 to port D 0000 1000 to enable clock
    STRB r4, [r1, #0x608] ;

    ; CONFIGURE PIN AS INPUT
    ;Initilize r3 with PORT D Base Address
    MOV r3, #0x7000
    MOVT r3, #0x4000
    LDRB r5, [r3, #0x400] ; Load r5 with GPIODIR address
 	AND r5, r5, #0x00 ; Configure pin as Input
 	STRB r5, [r3, #0x400] ; Write 0 to all pins 0000 0000 in r3

 	;GPIODEN, make pins 0 - 3 digital
 	LDRB r6, [r3, #0x51C]
 	ORR r6, r6, #0x0F ; 0000 1111 make pins 0 - 3 digital
 	STRB r6, [r3, #0x51C]

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

	POP {r4-r12,lr}  	; Restore registers from stack
	MOV pc, lr

illuminate_RGB_LED:
	PUSH {r4-r12,lr}	; Spill registers to stack

          ; Your code is placed here

	POP {r4-r12,lr}  	; Restore registers from stack
	MOV pc, lr

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

