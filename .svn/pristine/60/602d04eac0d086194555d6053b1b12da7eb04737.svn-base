
	.text
# PROCEDURE tigermain
	.globl	tigermain
	.func	tigermain
	.type	tigermain, @function
tigermain:
	# FRAME tigermain(1 formals, 10 locals)
	pushl %ebp
	movl %esp, %ebp
	subl $44, %esp
	# SP, FP, calleesaves, argregs have values
L2_blocks:                                        # x86gen:142
	movl $1, %ebx                             # x86gen:438 x86frame:328
	movl %ebx, -12(%ebp)                      # x86gen:438 x86frame:333
	movl %ebp, %ebx                           # x86gen:96
	movl -12(%ebp), %ecx                      # x86gen:97 x86frame:626
	movl %ecx, -4 (%ebx)                      # x86gen:102
	movl $2, %ebx                             # x86gen:438 x86frame:328
	movl %ebx, -16(%ebp)                      # x86gen:438 x86frame:333
	movl %ebp, %ebx                           # x86gen:96
	movl -16(%ebp), %ecx                      # x86gen:97 x86frame:626
	movl %ecx, -8 (%ebx)                      # x86gen:102
	movl -8(%ebp), %ebx                       # x86gen:253 x86frame:345
	movl %ebx, -20(%ebp)                      # x86gen:253 x86frame:350
	movl %ebp, %ebx                           # x86gen:96
	movl -20(%ebp), %ecx                      # x86gen:97 x86frame:626
	movl %ecx, -4 (%ebx)                      # x86gen:102
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
