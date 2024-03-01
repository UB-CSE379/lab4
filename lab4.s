	.text
	.global lab4
	.global read_from_push_btns

lab4:
	PUSH {r4-r12,lr}	; Spill registers to stack

          ; Your code is placed here
    BL read_from_push_btns
    BL read_tiva_pushbutton
    BL illuminate_RGB_LED

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
    ;MOV r0, #5 ;YELLOW -> RED AND GREEN
    MOV r0, #6 ;WHITE -> RED, BLUE, AND GREEN

    MOV r1, #0xE000
    MOVT r1, #0x400F
    LDRB r5, [r1, #0x608] 
    ORR r5, r5, #0x20	; Find Port F 0010 0000
    STRB r5, [r1, #0x608] ; Enable clock for Port F

    ; Initialize r3 with Port F address
    ; Set Pins 1, 2, 3 Direction to Output
    MOV r3, #0x5000
    MOVT r3, #0x4002
    
    LDRB r6, [r3, #0x400] ;offset 0x400 to port F
    ORR r6, r6, #0x0E ; configure pin 1 as output, red, 0000 1110 thats 0E
    STRB r6, [r3, #0x400] ; write 1 to mem

    ; Intilize pins as digital
    LDRB r7, [r3, #0x51C]
	; enable pin 1, 2, 3 as digital 0000 1110
    ORR r7, r7, #0x0E ;
    STRB r7, [r3, #0x51C] ;write 1 to make pin digital

    LDRB r8, [r3, #0x3FC] ; GPIODATA

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
