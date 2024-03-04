	.data

	.global prompt_for_board
	.global alice_prompt_1
	.global button_prompt
	.global button_prompt2
	.global tiva_prompt_1
	.global restart
	.global prompt1_data
	.global error

prompt_for_board:	.string "Which board would you like to use? (0 for Tiva, 1 for Alice)", 0
alice_prompt_1:		.string "Which LED would you like to turn on? (0 for LED 1, 1 for LED 2, 2 for LED 3, 3 for LED 4, 4 for ALL LEDs)", 0
button_prompt: 		.string "Would you like to press a button? (0 for Yes, 1 for No)", 0
button_prompt2: 	.string "Please Press The Desired Button!", 0
restart: 			.string "Would you like to run this program again?", 0
tiva_prompt_1:		.string "Which color would you like to display? (1 for Red, 2 for Blue, 3 for Green, 4 for Purple, 5 for Yellow , 6 for White)", 0
prompt1_data: 		.string "placeholder",0
error:				.string "Invalid Entry",0


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
	.global string2int

ptr_to_board:		.word prompt_for_board
ptr_to_alice1:		.word alice_prompt_1
ptr_to_button:		.word button_prompt
ptr_to_button2:		.word button_prompt2
ptr_to_tiva1: 		.word tiva_prompt_1
ptr_to_restart:		.word restart
ptr_to_data1: 		.word prompt1_data
ptr_to_error:		.word error





lab4:
	PUSH {r4-r12,lr}	; Spill registers to stack

          ; Your code is placed here
    BL uart_init
    BL gpio_btn_and_LED_init
    ;BL read_from_push_btns
    ;BL illuminate_LEDs
    ;BL read_tiva_push_button
    ;BL illuminate_RGB_LED

RESTART:
	LDR r0, ptr_to_board
	BL output_string
	LDR r0, ptr_to_data1
	BL read_string


	MOV r0, #0xD
    BL output_character
    MOV r0, #0xA
    BL output_character

    LDR r0, ptr_to_data1
    BL string2int
	CMP r0, #0
	BEQ TIVA
	CMP r0,#1
	BEQ ALICE
	BNE ERROR



ALICE:
	LDR r0, ptr_to_alice1
	BL output_string
	LDR r0, ptr_to_data1
	BL read_string

	MOV r0, #0xD
    BL output_character
    MOV r0, #0xA
    BL output_character

    LDR r0, ptr_to_data1
    BL string2int
    BL illuminate_LEDs

   	LDR r0, ptr_to_button
   	BL output_string
   	LDR r0, ptr_to_data1
   	BL read_string


	MOV r0, #0xD
    BL output_character
    MOV r0, #0xA
    BL output_character

    LDR r0, ptr_to_data1
    BL string2int
    CMP r0, #0
	BEQ READBUTTONA
	CMP r0,#1
	BEQ END


READBUTTONA:
	LDR r0, ptr_to_button2
	BL output_string
	LDR r0, ptr_to_data1
	BL read_from_push_btns
	
	
	STR r0, ptr_to_data1
	BL output_character


	MOV r0, #0xD
    BL output_character
    MOV r0, #0xA
    BL output_character

	LDR r0, ptr_to_data1


	B ERROR





TIVA:

ERROR:
	LDR r0, ptr_to_error
	BL output_string

	MOV r0, #0xD
    BL output_character
    MOV r0, #0xA
    BL output_character

	B END

END:
	LDR r0, ptr_to_restart
	BL output_string
	;LDR r0



	POP {r4-r12,lr}  	; Restore registers from stack
	MOV pc, lr

	.end
