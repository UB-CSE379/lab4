	.data

	.global prompt_for_board
	.global alice_prompt_1
	.global button_prompt
	.global tiva_prompt_1
	.global restart

prompt_for_board:	.string "Which board would you like to use? (0 for Tiva, 1 for Alice)", 0
alice_prompt_1:		.string "Which LED would you like to turn on? (0 for LED 1, 1 for LED 2, 2 for LED 3, 3 for LED 4, 4 for ALL LEDs)", 0
button_prompt: 		.string "Would you like to press a button? (0 for Yes, 1 for No)", 0
restart: 			.string "Would you like to run this program again?", 0
tiva_prompt_1:		.string "Which color would you like to display? (1 for Red, 2 for Blue, 3 for Green, 4 for Purple, 5 for Yellow , 6 for White)", 0


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

ptr_to_board:		.word prompt_for_board
ptr_to_alice1:		.word alice_prompt_1
ptr_to_button:		.word button_prompt
ptr_to_tiva1: 		.word tiva_prompt_1
ptr_to_restart:		.word restart




lab4:
	PUSH {r4-r12,lr}	; Spill registers to stack

          ; Your code is placed here
    BL uart_init
    ;BL gpio_btn_and_LED_init
    ;BL read_from_push_btns
    ;BL illuminate_LEDs
    ;BL read_tiva_push_button
    ;BL illuminate_RGB_LED

RESTART:
	LDR r0, ptr_to_board
	BL output_string
	BL read_string

	MOV r0, #0xD
    BL output_character
    MOV r0, #0xA
    BL output_character

    LDRB r0, [r4]
    BL output_string



	POP {r4-r12,lr}  	; Restore registers from stack
	MOV pc, lr

	.end
