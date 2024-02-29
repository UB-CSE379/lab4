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
    ;Initialize Clock Address
    MOV r1, #0xE000
    MOVT r1, #0x400F
    LDRB r5, [r1, #0x608] 
    ORR r5, r5, #0x10	; Find Port F 
    STRB r5, [r1, #0x608] ; Enable clock for Port F

    ; Initialize r3 with Port F address
    ; Set Pins 1, 2, 3 Direction to Output
    MOV r3, #0x5000
    MOVT r3, #0x4002
    
    LDRB r6, [r3, #0x400] ;offset 0x400 to port F
    LDRB r7, [r3, #0x400]
    LDRB r8, [r3, #0x400]
    
    ORR r6, r6, #0x02 ; configure pin 1 as output, red
    ORR r7, r7, #0x04 ; configure pin 2 as output , blue
    ORR r8, r8, #0x08 ; configure pin 3 as output , green
    
    STRB r6, [r3, #0x400] ; write 1 to mem
    STRB r7, [r3, #0x400] ; write 1 to mem
    STRB r8, [r3, #0x400] ; write 1 to mem

    ; Intilize pins as digital
    LDRB r6, [r3, #0x51C]
    LDRB r7, [r3, #0x51C]
    LDRB r8, [r3, #0x51C]

    ORR r6, r6, #0x02 ; enable pin 1 as digital
    ORR r7, r7, #0x04 ; enable pin 2 as digital
    ORR r8, r8, #0x08 ; enable pin 3 as digital

    STRB r6, [r3, #0x51C] ;write 1 to make pin digital
    STRB r7, [r3, #0x51C] ;write 1 to make pin digital
    STRB r8, [r3, #0x51C] ;write 1 to make pin digital

    ;how to control what colors show up ?? 

	POP {r4-r12,lr}  	; Restore registers from stack
	MOV pc, lr

read_tiva_pushbutton:
	PUSH {r4-r12,lr}	; Spill registers to stack

          ; Your code is placed here
	  
    ;Initialize r1 with Clock Address
    MOV r1, #0xE000
    MOVT r1, #0x400F
    LDRB r5, [r1, #0x608] 
    ORR r5, r5, #0x20	; Find Port F    0010 0000
    STRB r5, [r1, #0x608] ; Enable clock for Port F

    ;Initialize r3 with Port F address
    ; Set Pin 4 Direction to Input
    MOV r3, #0x5000
    MOVT r3, #0x4002
    LDRB r6, [r3, #0x400] ;offset 0x400 to port F
    AND r6, r6, #0xEF ; configure pin 4 as input
    STRB r6, [r3, #0x400] ; write 0 to configure pin 4 as input

	;Enable pull-up resistor
	LDRB r7, [r3, #0x510]
	ORR r7, r7, #0x10 ; 
	STRB r7, [r3, #0x510] ;Write 1 to enable pull-up resistor

    ; Initilize pin 4 as digital
    LDRB r8, [r3, #0x51C]
    ORR r8, r8, #0x10  ; enable pin 4 , by writing 1
	STRB r8, [r3, #0x51C] ;write 1 to make pin digital

    LDRB r9, [r3, #0x3FC] ;GPIODATA
    AND r9, r9, #0x10	; 

    CMP r9, #0x10 ; check if pin is being pressed
    BNE PRESS ; if r9 == 0, r0 = 1
    MOV r0, #0 ; if r9 == 1, r0 = 0
    B STOP

PRESS:
	MOV r0, #1; button is being pressed
	

STOP:

    ;

	POP {r4-r12,lr}  	; Restore registers from stack
	MOV pc, lr

	.end
