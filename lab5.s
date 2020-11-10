### MIPS32 sample program (using QtSpim)
###
### Configuration:
###     Make sure that in preferences -> MIPS, choose/click "Simple Machine"
###     (Two options are selected: "Accept Pseudo Instructions", "Enable Mapped IO")
###     Also, unchecked "Load Exception Handler" to simplify the output in the GUI
###
### Note:
###     In this lab, we'll implemeent the power function
###         power(x, y) = x^y
###         power(2, 3) = 2^3 = 8
###     For simplicity, we assume that both x and y are > 1.
###			x is the base, and y is the power term.
###
### --------------------------
### This is the data segment
### --------------------------
    .data

prompt:         .asciiz  "Please enter the first integer:\n"
prompt2:        .asciiz  "Please enter the second integer:\n"
newline:        .asciiz  "\n"

### ----------------------------------------------------
### This is the user text segment (instructions go here)
### ----------------------------------------------------
    .text
    .globl  main

main:
    # prompt to enter the first integer
    li $v0, 4
    la $a0, prompt
    syscall

    # read the first integer and store it in $t0
    li $v0, 5
    syscall
    move $t0, $v0

    # [ implemeent your code here ]

    # prompt to enter the second integer
    li $v0, 4
    la $a0, prompt2
    syscall

    # read the second integer and store it in $t1
    li $v0, 5
    syscall
    move $t1, $v0

		# prepare the parameters for the function call
		move $a0, $t0
		move $a1, $t0
		move $a2, $t1

    # call the power function
    # function call will carry the parameters through
    # $a0, $a1, $a2, $a3
    jal power

# Terminate the program
    li $v0, 10
    syscall

.end main

power:
    # [ implement the power function here ]
    # use $a0 for multiplication result
    # I fix the $a1 for the base value
		mul $a0, $a0, $a1
		
		# print out the temp values
    li $v0, 1
		syscall

		# to avoid $a0 from being overwritten...
		move $t0, $a0

		# syscal to print new line char to separate the output
		li $v0, 4
		la $a0, newline
		syscall
		
		# restore the $a0 value for following calc.
		move $a0, $t0

		# check if we should continue the loop
		# we have the original power term stored in $a2
		sub $a2, $a2, 1
		bne $a2, 0, power

    # return to the function caller
    jr $ra

### End of file
