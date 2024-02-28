	.text 
	.global lab4

lab4:
	PUSH {r4-r12,lr}	; Spill registers to stack
    
          ; Your code is placed here
 
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
 
	POP {r4-r12,lr}  	; Restore registers from stack
	MOV pc, lr

	.end
