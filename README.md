# lab4

## PART 1
Objective
In this part of the lab, you will learn to use general purpose I/O to interface hardware with the ARM
processor. You will utilize one of the two momentary push buttons on the Tiva board along with the
RGB LED.

Description
Write and test two ARM assembly language subroutines, called read_from_push_btn and
illuminate_RGB_LED. The details for each subroutine are provided below.
Subroutine Details
• read_from_push_btn reads from the momentary push button (SW1) on the Tiva board, and
returns a one (1) in r0 if the button is currently being pressed and a zero (0) if it is not.
• illuminate_RGB_LED illuminates the RBG LED on the Tiva board. The color to be displayed is
passed into the routine in r0. How the individual colors are encoded when passed into the routine
in r0 is up to you. You should provide for the RGB LED to be illuminated red, blue, green,
purple, yellow, and white.
