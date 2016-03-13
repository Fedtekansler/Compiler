
	.text
# PROCEDURE tigermain
	.globl	tigermain
	.func	tigermain
	.type	tigermain, @function
tigermain:
	# FRAME tigermain(1 formals, 14 locals)
	pushl %ebp
	movl %esp, %ebp
	subl $60, %esp
	# SP, FP, calleesaves, argregs have values
L2_blocks:                                        # x86gen:142
	movl $0, %ebx                             # x86gen:438 x86frame:328
	movl %ebx, -8(%ebp)                       # x86gen:438 x86frame:333
	movl %ebp, %ebx                           # x86gen:96
	movl -8(%ebp), %ecx                       # x86gen:97 x86frame:626
	movl %ecx, -4 (%ebx)                      # x86gen:102
	movl -4(%ebp), %ebx                       # x86gen:253 x86frame:345
	movl %ebx, -20(%ebp)                      # x86gen:253 x86frame:350
	movl -20(%ebp), %ebx                      # x86gen:158 x86frame:633
	movl %ebx, -24(%ebp)                      # x86gen:158 x86frame:638
	movl -24(%ebp), %ebx                      # x86gen:163 x86frame:361
	cmpl $0, %ebx                             # x86gen:163 x86frame:366
	je L1_unNx 
	jmp L1_unNx                               # x86gen:166
L1_unNx:                                          # x86gen:142
	movl $1, %ebx                             # x86gen:438 x86frame:328
	movl %ebx, -28(%ebp)                      # x86gen:438 x86frame:333
	movl -28(%ebp), %ebx                      # x86gen:137 x86frame:633
	movl %ebx, -44(%ebp)                      # x86gen:137 x86frame:638
	movl -4(%ebp), %ebx                       # x86gen:253 x86frame:345
	movl %ebx, -32(%ebp)                      # x86gen:253 x86frame:350
	movl -32(%ebp), %ebx                      # x86gen:158 x86frame:633
	movl %ebx, -36(%ebp)                      # x86gen:158 x86frame:638
	movl -36(%ebp), %ebx                      # x86gen:163 x86frame:361
	cmpl $0, %ebx                             # x86gen:163 x86frame:366
	jne L2_unEx_t 
	jmp L3_unEx_f                             # x86gen:166
L3_unEx_f:                                        # x86gen:142
	movl $0, %ebx                             # x86gen:438 x86frame:328
	movl %ebx, -40(%ebp)                      # x86gen:438 x86frame:333
	movl -40(%ebp), %ebx                      # x86gen:137 x86frame:633
	movl %ebx, -44(%ebp)                      # x86gen:137 x86frame:638
L2_unEx_t:                                        # x86gen:142
	movl -44(%ebp), %eax                      # x86gen:137 x86frame:626
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
