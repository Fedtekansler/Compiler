
	.text
# PROCEDURE tigermain
	.globl	tigermain
	.func	tigermain
	.type	tigermain, @function
tigermain:
	# FRAME tigermain(1 formals, 4 locals)
	pushl %ebp
	movl %esp, %ebp
	subl $20, %esp
	# SP, FP, calleesaves, argregs have values
L2_blocks:                                        # x86gen:142
	movl $10, %ebx                            # x86gen:438 x86frame:328
	movl %ebx, -4(%ebp)                       # x86gen:438 x86frame:333
	movl -4(%ebp), %eax                       # x86gen:234 x86frame:626
	pushl %eax                                # x86gen:239
	movl %ebp, %eax                           # x86gen:234
	pushl %eax                                # x86gen:239
	call L1_nfactor                           # x86gen:73
	addl $8, %esp                             # x86gen:60
	movl %eax, %eax                           # x86gen:75
	jmp L1_block_done                         # x86gen:188
L1_block_done:                                    # x86gen:142
	# FP, SP, RV, calleesaves still live
	leave
	ret
	.size	tigermain, .-tigermain
	.endfunc
# END tigermain



	.text
# PROCEDURE L1_nfactor
	.globl	L1_nfactor
	.func	L1_nfactor
	.type	L1_nfactor, @function
L1_nfactor:
	# FRAME L1_nfactor(2 formals, 15 locals)
	pushl %ebp
	movl %esp, %ebp
	subl $68, %esp
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
	movl 12(%ebp), %ebx                       # x86gen:253 x86frame:345
	movl %ebx, -12(%ebp)                      # x86gen:253 x86frame:350
	movl -12(%ebp), %ebx                      # x86gen:137 x86frame:633
	movl %ebx, -28(%ebp)                      # x86gen:137 x86frame:638
	movl 12(%ebp), %ebx                       # x86gen:253 x86frame:345
	movl %ebx, -16(%ebp)                      # x86gen:253 x86frame:350
	movl -16(%ebp), %ebx                      # x86gen:307 x86frame:633
	movl %ebx, -20(%ebp)                      # x86gen:307 x86frame:638
	movl -20(%ebp), %ebx                      # x86gen:312 x86frame:377
	subl $1, %ebx                             # x86gen:312 x86frame:382
	movl %ebx, -20(%ebp)                      # x86gen:312 x86frame:387
	movl -20(%ebp), %eax                      # x86gen:234 x86frame:626
	pushl %eax                                # x86gen:239
	movl 8(%ebp), %ebx                        # x86gen:253 x86frame:345
	movl %ebx, -24(%ebp)                      # x86gen:253 x86frame:350
	movl -24(%ebp), %eax                      # x86gen:234 x86frame:626
	pushl %eax                                # x86gen:239
	call L1_nfactor                           # x86gen:73
	addl $8, %esp                             # x86gen:60
	movl %eax, -36(%ebp)                      # x86gen:75 x86frame:619
	movl -28(%ebp), %eax                      # x86gen:340 x86frame:626
	movl -36(%ebp), %ebx                      # x86gen:345 x86frame:361
	imull %ebx                                # x86gen:345 x86frame:366
	movl %eax, -40(%ebp)                      # x86gen:346 x86frame:619
	movl -40(%ebp), %ebx                      # x86gen:137 x86frame:633
	movl %ebx, -44(%ebp)                      # x86gen:137 x86frame:638
L4_if_join:                                       # x86gen:142
	movl -44(%ebp), %eax                      # x86gen:137 x86frame:626
	jmp L3_block_done                         # x86gen:188
L2_if_then:                                       # x86gen:142
	movl $1, %ebx                             # x86gen:438 x86frame:328
	movl %ebx, -48(%ebp)                      # x86gen:438 x86frame:333
	movl -48(%ebp), %ebx                      # x86gen:137 x86frame:633
	movl %ebx, -44(%ebp)                      # x86gen:137 x86frame:638
	jmp L4_if_join                            # x86gen:188
L3_block_done:                                    # x86gen:142
	# FP, SP, RV, calleesaves still live
	leave
	ret
	.size	L1_nfactor, .-L1_nfactor
	.endfunc
# END L1_nfactor


	.data
L0_string:
	.long 13
	.asciz "DefaultString"
