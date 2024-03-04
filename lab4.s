	.text
	.global lab4
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
