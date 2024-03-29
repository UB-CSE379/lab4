	.data

	.global sw5
	.global sw4
	.global sw3
	.global sw2
	.global sw1
	.global prompt_for_board
	.global alice_prompt_1
	.global button_prompt
	.global button_prompt2
	.global tiva_prompt_1
	.global restart
	.global div_mod
	.global prompt1_data
	.global prompt2_data
	.global error
	.global div_mod2
	.global div_mod3
	.global quo
	.global rem



quo:				.string "The Quotient Is: ",0
rem: 				.string "The Remainder Is: ",0
div_mod: 			.string "Would you like to perform Div and Mod? (0 for Yes, 1 for No)",0
div_mod2:			.string "Enter Your Dividend!",0
div_mod3:			.string "Enter Your Divisor!",0
sw1:				.string "SW1 Pressed",0
sw2:				.string "SW2 Pressed",0
sw3:				.string "SW3 Pressed",0
sw4:				.string "SW4 Pressed",0
sw5:				.string "SW5 Pressed",0
prompt_for_board:	.string "Which board would you like to use? (0 for Tiva, 1 for Alice)", 0
alice_prompt_1:		.string "Which LED would you like to turn on? (0 for LED 1, 1 for LED 2, 2 for LED 3, 3 for LED 4, 4 for ALL LEDs)", 0
button_prompt: 		.string "Would you like to press a button? (0 for Yes, 1 for No)", 0
button_prompt2: 	.string "Please Press The Desired Button!", 0
restart: 			.string "Would you like to run this program again? (0 for Yes, 1 for No)", 0
tiva_prompt_1:		.string "Which color would you like to display? (1 for Red, 2 for Blue, 3 for Green, 4 for Purple, 5 for Yellow , 6 for White)", 0
prompt1_data: 		.string "placeholder",0
prompt2_data: 		.string "placeholder2",0
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
	.global int2string
	.global print_all_numbers

ptr_to_rem: 		.word rem
ptr_to_quo:			.word quo
ptr_to_div:			.word div_mod
ptr_to_div2:		.word div_mod2
ptr_to_div3:		.word div_mod3
ptr_to_sw1:			.word sw1
ptr_to_sw2:			.word sw2
ptr_to_sw3:			.word sw3
ptr_to_sw4:			.word sw4
ptr_to_sw5:			.word sw5
ptr_to_board:		.word prompt_for_board
ptr_to_alice1:		.word alice_prompt_1
ptr_to_button:		.word button_prompt
ptr_to_button2:		.word button_prompt2
ptr_to_tiva1: 		.word tiva_prompt_1
ptr_to_restart:		.word restart
ptr_to_data1: 		.word prompt1_data
ptr_to_data2: 		.word prompt2_data
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
	LDR r0, ptr_to_div
	BL output_string

	MOV r0, #0xD
    BL output_character
    MOV r0, #0xA
    BL output_character

    LDR r0, ptr_to_data1
    BL read_string

	MOV r0, #0xD
    BL output_character
    MOV r0, #0xA
    BL output_character

    LDR r0, ptr_to_data1
    BL string2int

    CMP r0, #0
    BEQ DIV_MOD
    CMP r0, #1
    BNE ERROR


	LDR r0, ptr_to_board
	BL output_string

	MOV r0, #0xD
    BL output_character
    MOV r0, #0xA
    BL output_character

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

	BNE ERROR ;if neither it is an error

;________________________________________________________________________________________________________________

DIV_MOD:
	LDR r0, ptr_to_div2
	BL output_string

	MOV r0, #0xD
    BL output_character
    MOV r0, #0xA
    BL output_character

    LDR r0, ptr_to_data1
    BL read_string

    MOV r0, #0xD
    BL output_character
    MOV r0, #0xA
    BL output_character

    LDR r0, ptr_to_div3
    BL output_string

    MOV r0, #0xD
    BL output_character
    MOV r0, #0xA
    BL output_character

    LDR r0, ptr_to_data2
    BL read_string

    MOV r0, #0xD
    BL output_character
    MOV r0, #0xA
    BL output_character

    LDR r0, ptr_to_data1
    BL string2int
    MOV r6, r0
    LDR r0, ptr_to_data2
    BL string2int
    MOV r1,r0
    MOV r0, r6
    BL div_and_mod

    MOV r6,r0
    MOV r7,r1

    LDR r0, ptr_to_quo
    BL output_string

    MOV r0, r6
    BL print_all_numbers

    MOV r0, #0xD
    BL output_character
    MOV r0, #0xA
    BL output_character

    LDR r0, ptr_to_rem
    BL output_string

    MOV r0, r7
    BL print_all_numbers

    MOV r0, #0xD
    BL output_character
    MOV r0, #0xA
    BL output_character


    B END

;________________________________________________________________________________________________________________

ALICE:

	LDR r0, ptr_to_alice1
	BL output_string

	MOV r0, #0xD
    BL output_character
    MOV r0, #0xA
    BL output_character

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

   	MOV r0, #0xD
    BL output_character
    MOV r0, #0xA
    BL output_character

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
	BNE ERROR

;________________________________________________________________________________________________________________

READBUTTONA:

	LDR r0, ptr_to_button2
	BL output_string

	LDR r0, ptr_to_data1
	BL read_from_push_btns

	CMP r0, #5
	BEQ SW5

	CMP r0, #4
	BEQ SW4

	CMP r0, #3
	BEQ SW3

	CMP r0, #2
	BEQ SW2

	B ERROR

;________________________________________________________________________________________________________________

SW2:
	MOV r0, #0xD
    BL output_character
    MOV r0, #0xA
    BL output_character

	LDR r0, ptr_to_sw2
	BL output_string

	MOV r0, #0xD
    BL output_character
    MOV r0, #0xA
    BL output_character

	B END

;________________________________________________________________________________________________________________

SW3:
	MOV r0, #0xD
    BL output_character
    MOV r0, #0xA
    BL output_character

	LDR r0, ptr_to_sw3
	BL output_string

	MOV r0, #0xD
    BL output_character
    MOV r0, #0xA
    BL output_character

	B END

;________________________________________________________________________________________________________________

SW4:
	MOV r0, #0xD
    BL output_character
    MOV r0, #0xA
    BL output_character

	LDR r0, ptr_to_sw4
	BL output_string

	MOV r0, #0xD
    BL output_character
    MOV r0, #0xA
    BL output_character

	B END

;________________________________________________________________________________________________________________

SW5:
	MOV r0, #0xD
    BL output_character
    MOV r0, #0xA
    BL output_character

	LDR r0, ptr_to_sw5
	BL output_string

	MOV r0, #0xD
    BL output_character
    MOV r0, #0xA
    BL output_character

	B END

;________________________________________________________________________________________________________________


TIVA:
	LDR r0, ptr_to_tiva1
	BL output_string

	MOV r0, #0xD
    BL output_character
    MOV r0, #0xA
    BL output_character

	LDR r0, ptr_to_data1
	BL read_string


    LDR r0, ptr_to_data1
    BL string2int
    BL illuminate_RGB_LED


    MOV r0, #0xD
    BL output_character
    MOV r0, #0xA
    BL output_character


    LDR r0, ptr_to_button
   	BL output_string

   	MOV r0, #0xD
    BL output_character
    MOV r0, #0xA
    BL output_character

   	LDR r0, ptr_to_data1
   	BL read_string

   	MOV r0, #0xD
    BL output_character
    MOV r0, #0xA
    BL output_character

   	LDR r0, ptr_to_data1
    BL string2int
    CMP r0, #0
	BEQ READBUTTONT
	CMP r0,#1
	BEQ END
	BNE ERROR

;________________________________________________________________________________________________________________

READBUTTONT:
	LDR r0, ptr_to_button2
	BL output_string

	LDR r0, ptr_to_data1
	BL read_tiva_push_button
	CMP r0, #1
	BEQ SW1
	B END

;________________________________________________________________________________________________________________

SW1:
	MOV r0, #0xD
    BL output_character
    MOV r0, #0xA
    BL output_character

	LDR r0, ptr_to_sw1
	BL output_string

	MOV r0, #0xD
    BL output_character
    MOV r0, #0xA
    BL output_character

	B END

;________________________________________________________________________________________________________________

ERROR:
	LDR r0, ptr_to_error
	BL output_string

	MOV r0, #0xD
    BL output_character
    MOV r0, #0xA
    BL output_character

	B END

;________________________________________________________________________________________________________________

END:
	LDR r0, ptr_to_restart
	BL output_string

	MOV r0, #0xD
    BL output_character
    MOV r0, #0xA
    BL output_character

    LDR r0, ptr_to_data1
    BL read_string

    MOV r0, #0xD
    BL output_character
    MOV r0, #0xA
    BL output_character

    LDR r0, ptr_to_data1
    BL string2int
    CMP r0, #0
    BEQ RESTART




	POP {r4-r12,lr}  	; Restore registers from stack
	MOV pc, lr

	.end
