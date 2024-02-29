	.text
	.global lab4

lab4:
	PUSH {r4-r12,lr}	; Spill registers to stack

          ; Your code is placed here
    BL read_tiva_pushbutton

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
    MOV r4, #1;

    ;Initlize r1 with Clock Address
    MOV r1, #0xE000
    MOVT r1, #0x400F
    ;NEED TO ENABLE CLOCK FOR ONLY PORT F HERE
    LDRB r5, [r1, #0x608]
    ORR r5, r5, #0x10	; find specfic port 
    STRB r5, [r1, #0x608] ;enable clock for Port F

    ;Initlize r3 with Port F address
    MOV r3, #0x5000
    MOVT r3, #0x4002
    LDRB r6, [r3, #0x400] ;offset 0x400 to port F
    AND r6, r6, #0xEF ; configure pin 4 as input, write 0
    STRB r6, [r3, #0x400] ;write 0 to mem

	;Enable pull-up resistor
	LDRB r7, [r3, #0x510]
	ORR r7, r7, #0x10
	STRB r7, [r3, #0x510] ;Write 1 to enable pull-up resistor

    ;Initilize pin as digital
    LDRB r8, [r3, #0x51C]
    ORR r8, r8, #0x10  ; enable pin 4 , by writing 1
	STRB r8, [r3, #0x51C] ;write 1 to make pin digital

    LDRB r9, [r3, #0x3FC] ;GPIODATA
    AND r9, r9, #0x10

    CMP r9, #0
    BEQ PRESS ;if r9 == 0, r0 = 1
    MOV r0, #0 ; if r9 == 1, r0 = 0
    B STOP

PRESS:
	MOV r0, #1; button is being pressed


STOP:

    ;

	POP {r4-r12,lr}  	; Restore registers from stack
	MOV pc, lr

	.end
