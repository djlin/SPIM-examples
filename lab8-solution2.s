### Source: https://www.eecis.udel.edu/~davis/cpeg222/AssemblyTutorial/Chapter-27/ass27_1.html
### MIPS32 sample program (using QtSpim)
###
### Configuration:
###     Make sure that in preferences -> MIPS, choose/click "Simple Machine"
###     (Two options are selected: "Accept Pseudo Instructions", "Enable Mapped IO")
###     Also, unchecked "Load Exception Handler" to simplify the output in the GUI
###
### Note:
###     In this lab, we first prompt for input of up to 10 letters (a character string denoted as X.)
###     Then, we prompt to enter a character (denoted as Y.)
###     After that, search Y in X; if exists, print out the index and Y's upper/lower-case counterpart,
###				or otherwise print "N/A" 
###
###			We assume that the input will only be letters ('a' - 'z' and 'A' - 'Z').
###
### --------------------------
### This is the data segment
### --------------------------
.data

input:		.space		11		# 10 bytes of space + $zero
char:		.space		1		# 1 byte (for 1 char)
notExist:	.asciiz   	"N/A"

### ----------------------------------------------------
### This is the user text segment (instructions go here)
### ----------------------------------------------------

.text 
.globl main

main:
	# read a char string up to 10 letters (+1 for '\0')
	la $a0, input
	li $a1, 11
    li $v0, 8
	syscall 

		# read a character
		li $v0, 12
		syscall
		sb $v0, char

		# search the string
		li $a0, 0			# index = 0
		jal searchString

# ----
# Done, terrminate the program
exit:
    li $v0, 10
    syscall

.end main

searchString:
		la $t0, input
		add $t0, $t0, $a0
		lb $t1, ($t0)

		beq $t1, $zero, notAvailable	# hit '\0'
		add $a0, $a0, 1
		lb $t0, char
		bne $t0, $t1, searchString

		# found... print index
		sub $a0, $a0, 1
		li $v0, 1
		syscall

		# change upper/lower case
		blt $t1, 97, toLower

		# to upper case
		sub $a0, $t1, 32
		li $v0, 11
		syscall	

		j exit

notAvailable:
		la $a0, notExist
		li $v0, 4
		syscall
		j exit

toLower:
		add $a0, $t1, 32
		li $v0, 11
		syscall
		j exit
