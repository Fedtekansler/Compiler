
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
	movl $10, %ebx                            # x86gen:143 x86frame:328
	movl %ebx, -12(%ebp)                      # x86gen:143 x86frame:333
	movl $20, %ebx                            # x86gen:438 x86frame:328
	movl %ebx, -4(%ebp)                       # x86gen:438 x86frame:333
	movl -4(%ebp), %ebx                       # x86gen:144 x86frame:633
	movl %ebx, -8(%ebp)                       # x86gen:144 x86frame:638
	movl -8(%ebp), %ebx                       # x86gen:149 x86frame:550
	movl -12(%ebp), %edx                      # x86gen:149 x86frame:555
	cmpl %ebx, %edx                           # x86gen:149 x86frame:560
	jg L1_if_then 
	jmp L2_if_else                            # x86gen:155
L2_if_else:                                       # x86gen:142
	movl $40, %ebx                            # x86gen:438 x86frame:328
	movl %ebx, -16(%ebp)                      # x86gen:438 x86frame:333
	movl -16(%ebp), %ebx                      # x86gen:137 x86frame:633
	movl %ebx, -20(%ebp)                      # x86gen:137 x86frame:638
L3_if_join:                                       # x86gen:142
	movl -20(%ebp), %eax                      # x86gen:137 x86frame:626
	jmp L1_block_done                         # x86gen:188
L1_if_then:                                       # x86gen:142
	movl $30, %ebx                            # x86gen:438 x86frame:328
	movl %ebx, -24(%ebp)                      # x86gen:438 x86frame:333
	movl -24(%ebp), %ebx                      # x86gen:137 x86frame:633
	movl %ebx, -20(%ebp)                      # x86gen:137 x86frame:638
	jmp L3_if_join                            # x86gen:188
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
