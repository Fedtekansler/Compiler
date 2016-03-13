
	.text
# PROCEDURE tigermain
	.globl	tigermain
	.func	tigermain
	.type	tigermain, @function
tigermain:
	# FRAME tigermain(1 formals, 21 locals)
	pushl %ebp
	movl %esp, %ebp
	subl $88, %esp
	# SP, FP, calleesaves, argregs have values
L2_blocks:                                        # x86gen:142
	movl $0, %ebx                             # x86gen:438 x86frame:328
	movl %ebx, -12(%ebp)                      # x86gen:438 x86frame:333
	movl %ebp, %ebx                           # x86gen:96
	movl -12(%ebp), %ecx                      # x86gen:97 x86frame:626
	movl %ecx, -4 (%ebx)                      # x86gen:102
	movl $0, %ebx                             # x86gen:438 x86frame:328
	movl %ebx, -16(%ebp)                      # x86gen:438 x86frame:333
	movl %ebp, %ebx                           # x86gen:96
	movl -16(%ebp), %ecx                      # x86gen:97 x86frame:626
	movl %ecx, -8 (%ebx)                      # x86gen:102
	movl $100, %ebx                           # x86gen:438 x86frame:328
	movl %ebx, -20(%ebp)                      # x86gen:438 x86frame:333
	movl -20(%ebp), %ebx                      # x86gen:137 x86frame:633
	movl %ebx, -48(%ebp)                      # x86gen:137 x86frame:638
	movl -8(%ebp), %ebx                       # x86gen:253 x86frame:345
	movl %ebx, -24(%ebp)                      # x86gen:253 x86frame:350
	movl -24(%ebp), %ebx                      # x86gen:169 x86frame:633
	movl %ebx, -32(%ebp)                      # x86gen:169 x86frame:638
	movl -48(%ebp), %ebx                      # x86gen:170 x86frame:633
	movl %ebx, -28(%ebp)                      # x86gen:170 x86frame:638
	movl -28(%ebp), %ebx                      # x86gen:175 x86frame:550
	movl -32(%ebp), %edx                      # x86gen:175 x86frame:555
	cmpl %ebx, %edx                           # x86gen:175 x86frame:560
	jle L2_for_body 
	jmp L1_for                                # x86gen:181
L1_for:                                           # x86gen:142
	jmp L1_block_done                         # x86gen:188
L2_for_body:                                      # x86gen:142
	movl -4(%ebp), %ebx                       # x86gen:253 x86frame:345
	movl %ebx, -36(%ebp)                      # x86gen:253 x86frame:350
	movl -36(%ebp), %ebx                      # x86gen:280 x86frame:633
	movl %ebx, -40(%ebp)                      # x86gen:280 x86frame:638
	movl -40(%ebp), %ebx                      # x86gen:285 x86frame:377
	addl $1, %ebx                             # x86gen:285 x86frame:382
	movl %ebx, -40(%ebp)                      # x86gen:285 x86frame:387
	movl %ebp, %ebx                           # x86gen:96
	movl -40(%ebp), %ecx                      # x86gen:97 x86frame:626
	movl %ecx, -4 (%ebx)                      # x86gen:102
	movl -8(%ebp), %ebx                       # x86gen:253 x86frame:345
	movl %ebx, -44(%ebp)                      # x86gen:253 x86frame:350
	movl -44(%ebp), %ebx                      # x86gen:169 x86frame:633
	movl %ebx, -56(%ebp)                      # x86gen:169 x86frame:638
	movl -48(%ebp), %ebx                      # x86gen:170 x86frame:633
	movl %ebx, -52(%ebp)                      # x86gen:170 x86frame:638
	movl -52(%ebp), %ebx                      # x86gen:175 x86frame:550
	movl -56(%ebp), %edx                      # x86gen:175 x86frame:555
	cmpl %ebx, %edx                           # x86gen:175 x86frame:560
	jge L1_for 
	jmp L3_for_next                           # x86gen:181
L3_for_next:                                      # x86gen:142
	movl -8(%ebp), %ebx                       # x86gen:253 x86frame:345
	movl %ebx, -60(%ebp)                      # x86gen:253 x86frame:350
	movl -60(%ebp), %ebx                      # x86gen:288 x86frame:633
	movl %ebx, -64(%ebp)                      # x86gen:288 x86frame:638
	movl -64(%ebp), %ebx                      # x86gen:293 x86frame:377
	addl $1, %ebx                             # x86gen:293 x86frame:382
	movl %ebx, -64(%ebp)                      # x86gen:293 x86frame:387
	movl %ebp, %ebx                           # x86gen:96
	movl -64(%ebp), %ecx                      # x86gen:97 x86frame:626
	movl %ecx, -8 (%ebx)                      # x86gen:102
	jmp L2_for_body                           # x86gen:188
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
