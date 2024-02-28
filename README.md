# lab4

## PART 1
Objective
In this part of the lab, you will learn to use general purpose I/O to interface hardware with the ARM
processor. You will utilize one of the two momentary push buttons on the Tiva board along with the
RGB LED.

### Description
Write and test two ARM assembly language subroutines, called read_from_push_btn and
illuminate_RGB_LED. The details for each subroutine are provided below.
Subroutine Details
• read_from_push_btn reads from the momentary push button (SW1) on the Tiva board, and
returns a one (1) in r0 if the button is currently being pressed and a zero (0) if it is not.
• illuminate_RGB_LED illuminates the RBG LED on the Tiva board. The color to be displayed is
passed into the routine in r0. How the individual colors are encoded when passed into the routine
in r0 is up to you. You should provide for the RGB LED to be illuminated red, blue, green,
purple, yellow, and white.

## PART 2

## Objective
In this part of the lab, you will build off of what you started in Part #1, learning how to use general
purpose I/O to interface hardware with the ARM processor and begin to create a library for your
subroutines. You will utilize four LEDs on the Alice EduBase board, the four momentary push buttons
on the Alice EduBase board, the RGB LED on the Tiva board, and switch 1 (SW1) on the Tiva board.

## Description
Write and test five ARM assembly language subroutines, called read_tiva_push_button,
read_from_push_btns, illuminate_LEDs, and illuminate_RGB_LED. Once written, write a subroutine,
called lab4, which has a menu that allows you to repeatedly test each of the subroutines until the user
decides to exit the program. Note that instructions on how to use the program (such as what the menu
choices are and what user input is expected) is required.
The Library
Incorporate the following subroutines into a separate library file called library_lab_4.s.
• uart_init initializes the user UART for use.
• gpio_btn_and_LED_init initializes the four push buttons on the Alice EduBase board, the four
LEDs on the AliceEduBase board, the momentary push button on the Tiva board (SW1), and the
RGB LED on the Tiva board.
• output_character transmits a character passed into the routine in r0 to PuTTy via the UART.
• read_character reads a character from PuTTy via the UART, and returns the character in r0.
• read_string reads a string entered in PuTTy and stores it as a null-terminated string in memory.
The user terminates the string by hitting Enter. The base address of the string should be passed
into the routine in r0. The carriage return should NOT be stored in the string.
• output_string displays a null-terminated string in PuTTy. The base address of the string should be
passed into the routine in r0.
• read_from_push_btns reads the momentary push buttons, and returns the value read in r0. Push
button 2 should correspond to the MSB and 5 to the LSB.
• illuminate_LEDs illuminates the four LEDs. The pattern indicating which LEDs to illuminate is
passed into the routine in r0. Bit 3 corresponds to LED 3, bit 2 to LED 2, bit 1 to LED 1, and bit
0 to LED0.
• illuminate_RGB_LED illuminates the RBG LED. The color to be displayed is passed into the
routine in r0. How the individual colors are encoded when passed into the routine in r0 is up to
you. You should provide for the RGB LED to be illuminated red, blue, green, purple, yellow,
and white.
• read_tiva_push_button (originally labeled read_from_push_btn in Part #1, changed here for
clarity for future use) reads from the momentary push button (SW1) on the Tiva board, and
returns a one (1) in r0 if the button is currently being pressed, and a zero (0) if it is not.
• div_and_mod from Lab #2.
