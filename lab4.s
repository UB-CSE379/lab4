	.text
	.global lab4
	.global read_from_push_btns

lab4:
	PUSH {r4-r12,lr}	; Spill registers to stack

          ; Your code is placed here
    BL gpio_btn_and_LED_init
    BL read_from_push_btns
    BL illuminate_LEDs
    BL read_tiva_pushbutton
    BL illuminate_RGB_LED


	POP {r4-r12,lr}  	; Restore registers from stack
	MOV pc, lr

	.end
