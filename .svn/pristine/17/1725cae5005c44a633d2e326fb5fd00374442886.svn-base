
	.text
# PROCEDURE tigermain
	.globl	tigermain
	.func	tigermain
	.type	tigermain, @function
tigermain:
	# FRAME tigermain(1 formals, 18 locals)
	pushl %ebp
	movl %esp, %ebp
	subl $76, %esp
	# SP, FP, calleesaves, argregs have values
L2_blocks:                                        # x86gen:142
	movl %ebp, -12(%ebp)                      # x86gen:280 x86frame:619
	movl -12(%ebp), %ebx                      # x86gen:285 x86frame:377
	addl $-4, %ebx                            # x86gen:285 x86frame:382
	movl %ebx, -12(%ebp)                      # x86gen:285 x86frame:387
	movl -12(%ebp), %ebx                      # x86gen:137 x86frame:633
	movl %ebx, -20(%ebp)                      # x86gen:137 x86frame:638
	movl $10, %ebx                            # x86gen:438 x86frame:328
	movl %ebx, -16(%ebp)                      # x86gen:438 x86frame:333
	movl -16(%ebp), %eax                      # x86gen:234 x86frame:626
	pushl %eax                                # x86gen:239
	movl %ebp, %eax                           # x86gen:234
	pushl %eax                                # x86gen:239
	call L1_fun_f                             # x86gen:73
	addl $8, %esp                             # x86gen:60
	movl %eax, -24(%ebp)                      # x86gen:75 x86frame:619
	movl -20(%ebp), %ebx                      # x86gen:127 x86frame:626
	movl -24(%ebp), %ecx                      # x86gen:128 x86frame:626
	movl %ecx, (%ebx)                         # x86gen:133
	movl %ebp, -28(%ebp)                      # x86gen:280 x86frame:619
	movl -28(%ebp), %ebx                      # x86gen:285 x86frame:377
	addl $-8, %ebx                            # x86gen:285 x86frame:382
	movl %ebx, -28(%ebp)                      # x86gen:285 x86frame:387
	movl -28(%ebp), %ebx                      # x86gen:137 x86frame:633
	movl %ebx, -36(%ebp)                      # x86gen:137 x86frame:638
	movl $0, %ebx                             # x86gen:438 x86frame:328
	movl %ebx, -32(%ebp)                      # x86gen:438 x86frame:333
	movl -32(%ebp), %eax                      # x86gen:234 x86frame:626
	pushl %eax                                # x86gen:239
	movl %ebp, %eax                           # x86gen:234
	pushl %eax                                # x86gen:239
	call L1_fun_f                             # x86gen:73
	addl $8, %esp                             # x86gen:60
	movl %eax, -40(%ebp)                      # x86gen:75 x86frame:619
	movl -36(%ebp), %ebx                      # x86gen:127 x86frame:626
	movl -40(%ebp), %ecx                      # x86gen:128 x86frame:626
	movl %ecx, (%ebx)                         # x86gen:133
	movl -4(%ebp), %ebx                       # x86gen:253 x86frame:345
	movl %ebx, -52(%ebp)                      # x86gen:253 x86frame:350
	movl -52(%ebp), %ebx                      # x86gen:298 x86frame:633
	movl %ebx, -60(%ebp)                      # x86gen:298 x86frame:638
	movl -8(%ebp), %ebx                       # x86gen:253 x86frame:345
	movl %ebx, -56(%ebp)                      # x86gen:253 x86frame:350
	movl -60(%ebp), %ebx                      # x86gen:303 x86frame:571
	movl -56(%ebp), %ecx                      # x86gen:303 x86frame:576
	addl %ecx, %ebx                           # x86gen:303 x86frame:581
	movl %ebx, -60(%ebp)                      # x86gen:303 x86frame:586
	movl -60(%ebp), %eax                      # x86gen:137 x86frame:626
	jmp L1_block_done                         # x86gen:188
L1_block_done:                                    # x86gen:142
	# FP, SP, RV, calleesaves still live
	leave
	ret
	.size	tigermain, .-tigermain
	.endfunc
# END tigermain



	.text
# PROCEDURE L1_fun_f
	.globl	L1_fun_f
	.func	L1_fun_f
	.type	L1_fun_f, @function
L1_fun_f:
	# FRAME L1_fun_f(2 formals, 8 locals)
	pushl %ebp
	movl %esp, %ebp
	subl $40, %esp
	# SP, FP, calleesaves, argregs have values
L4_blocks:                                        # x86gen:142
	movl 12(%ebp), %ebx                       # x86gen:253 x86frame:345
	movl %ebx, -4(%ebp)                       # x86gen:253 x86frame:350
	movl -4(%ebp), %ebx                       # x86gen:158 x86frame:633
	movl %ebx, -8(%ebp)                       # x86gen:158 x86frame:638
	movl -8(%ebp), %ebx                       # x86gen:163 x86frame:361
	cmpl $0, %ebx                             # x86gen:163 x86frame:366
	je L2_if_then 
	jmp L3_if_else                            # x86gen:166
L3_if_else:                                       # x86gen:142
	movl $2, %ebx                             # x86gen:438 x86frame:328
	movl %ebx, -12(%ebp)                      # x86gen:438 x86frame:333
	movl -12(%ebp), %ebx                      # x86gen:137 x86frame:633
	movl %ebx, -16(%ebp)                      # x86gen:137 x86frame:638
L4_if_join:                                       # x86gen:142
	movl -16(%ebp), %eax                      # x86gen:137 x86frame:626
	jmp L3_block_done                         # x86gen:188
L2_if_then:                                       # x86gen:142
	movl $1, %ebx                             # x86gen:438 x86frame:328
	movl %ebx, -20(%ebp)                      # x86gen:438 x86frame:333
	movl -20(%ebp), %ebx                      # x86gen:137 x86frame:633
	movl %ebx, -16(%ebp)                      # x86gen:137 x86frame:638
	jmp L4_if_join                            # x86gen:188
L3_block_done:                                    # x86gen:142
	# FP, SP, RV, calleesaves still live
	leave
	ret
	.size	L1_fun_f, .-L1_fun_f
	.endfunc
# END L1_fun_f


	.data
L0_string:
	.long 13
	.asciz "DefaultString"
