
	.text
# PROCEDURE tigermain
	.globl	tigermain
	.func	tigermain
	.type	tigermain, @function
tigermain:
	# FRAME tigermain(1 formals, 9 locals)
	pushl %ebp
	movl %esp, %ebp
	subl $40, %esp
	# SP, FP, calleesaves, argregs have values
L2_blocks:                                        # x86gen:142
	movl $1, %ebx                             # x86gen:438 x86frame:328
	movl %ebx, -4(%ebp)                       # x86gen:438 x86frame:333
	movl -4(%ebp), %ebx                       # x86gen:137 x86frame:633
	movl %ebx, -24(%ebp)                      # x86gen:137 x86frame:638
	movl $1, %ebx                             # x86gen:143 x86frame:328
	movl %ebx, -16(%ebp)                      # x86gen:143 x86frame:333
	movl $0, %ebx                             # x86gen:438 x86frame:328
	movl %ebx, -8(%ebp)                       # x86gen:438 x86frame:333
	movl -8(%ebp), %ebx                       # x86gen:144 x86frame:633
	movl %ebx, -12(%ebp)                      # x86gen:144 x86frame:638
	movl -12(%ebp), %ebx                      # x86gen:149 x86frame:550
	movl -16(%ebp), %edx                      # x86gen:149 x86frame:555
	cmpl %ebx, %edx                           # x86gen:149 x86frame:560
	jge L1_unEx_t 
	jmp L2_unEx_f                             # x86gen:155
L2_unEx_f:                                        # x86gen:142
	movl $0, %ebx                             # x86gen:438 x86frame:328
	movl %ebx, -20(%ebp)                      # x86gen:438 x86frame:333
	movl -20(%ebp), %ebx                      # x86gen:137 x86frame:633
	movl %ebx, -24(%ebp)                      # x86gen:137 x86frame:638
L1_unEx_t:                                        # x86gen:142
	movl -24(%ebp), %eax                      # x86gen:137 x86frame:626
	jmp L1_block_done                         # x86gen:188
L1_block_done:                                    # x86gen:142
	# FP, SP, RV, calleesaves still live
	leave
	ret
	.size	tigermain, .-tigermain
	.endfunc
# END tigermain


	.data
L0_string:
	.long 13
	.asciz "DefaultString"
