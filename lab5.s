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

    #second number
    li $v0, 4
    la $a0, prompt2
    syscall

    li $v0,5        
        syscall
    move $t1,$v0

        add $t2, $t1, $t0 #compute the sum

    #print out sum of $t2
    li $v0, 4       # load syscall print int into $v0
    #li, $v0,1
    la, $a0, result
    syscall
    
    add $a0, $t1, $t0 #compute the sum
    li $v0, 1
    syscall

    # call the power function
    jal power

# Terminate the program
    li $v0, 10
    syscall

.end main

power:
    # [ implement the power function here ]
    sub $sp, $sp, 4
    sw $ra, 4($sp)
   if: sub $t1, $v0
   blez $t1, endif

    # return to the function caller
    jal power
    endif: mul $v0
    lw $ra, 4($sp)
    add $sp, $sp, 4
return: jr $ra

### End of file
