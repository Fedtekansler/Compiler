
	.text
# PROCEDURE tigermain
	.globl	tigermain
	.func	tigermain
	.type	tigermain, @function
tigermain:
	# FRAME tigermain(1 formals, 22 locals)
	pushl %ebp
	movl %esp, %ebp
	subl $92, %esp
	# SP, FP, calleesaves, argregs have values
L2_blocks:                                        # x86gen:142
	movl %ebp, -8(%ebp)                       # x86gen:280 x86frame:619
	movl -8(%ebp), %ebx                       # x86gen:285 x86frame:377
	addl $-4, %ebx                            # x86gen:285 x86frame:382
	movl %ebx, -8(%ebp)                       # x86gen:285 x86frame:387
	movl -8(%ebp), %ebx                       # x86gen:137 x86frame:633
	movl %ebx, -24(%ebp)                      # x86gen:137 x86frame:638
	movl $2, %ebx                             # x86gen:438 x86frame:328
	movl %ebx, -12(%ebp)                      # x86gen:438 x86frame:333
	movl -12(%ebp), %eax                      # x86gen:234 x86frame:626
	pushl %eax                                # x86gen:239
	call allocRecord                          # x86gen:73
	addl $4, %esp                             # x86gen:60
	movl %eax, -28(%ebp)                      # x86gen:75 x86frame:619
	movl $L1_string, %ebx                     # x86gen:431 x86frame:328
	movl %ebx, -16(%ebp)                      # x86gen:431 x86frame:333
	movl -28(%ebp), %ebx                      # x86gen:96 x86frame:626
	movl -16(%ebp), %ecx                      # x86gen:97 x86frame:626
	movl %ecx, 0 (%ebx)                       # x86gen:102
	movl $1000, %ebx                          # x86gen:438 x86frame:328
	movl %ebx, -20(%ebp)                      # x86gen:438 x86frame:333
	movl -28(%ebp), %ebx                      # x86gen:96 x86frame:626
	movl -20(%ebp), %ecx                      # x86gen:97 x86frame:626
	movl %ecx, 4 (%ebx)                       # x86gen:102
	movl -24(%ebp), %ebx                      # x86gen:127 x86frame:626
	movl -28(%ebp), %ecx                      # x86gen:128 x86frame:626
	movl %ecx, (%ebx)                         # x86gen:133
	movl -4(%ebp), %ebx                       # x86gen:253 x86frame:345
	movl %ebx, -32(%ebp)                      # x86gen:253 x86frame:350
	movl -32(%ebp), %ebx                      # x86gen:137 x86frame:633
	movl %ebx, -40(%ebp)                      # x86gen:137 x86frame:638
	movl -40(%ebp), %ebx                      # x86gen:158 x86frame:633
	movl %ebx, -36(%ebp)                      # x86gen:158 x86frame:638
	movl -36(%ebp), %ebx                      # x86gen:163 x86frame:361
	cmpl $0, %ebx                             # x86gen:163 x86frame:366
	je L2_fvar_nil 
	jmp L3_fvar_nnil                          # x86gen:166
L3_fvar_nnil:                                     # x86gen:142
	movl -40(%ebp), %ebx                      # x86gen:298 x86frame:633
	movl %ebx, -60(%ebp)                      # x86gen:298 x86frame:638
	movl $4, %ebx                             # x86gen:438 x86frame:328
	movl %ebx, -52(%ebp)                      # x86gen:438 x86frame:333
	movl $0, %ebx                             # x86gen:438 x86frame:328
	movl %ebx, -44(%ebp)                      # x86gen:438 x86frame:333
	movl -44(%ebp), %eax                      # x86gen:340 x86frame:626
	movl -52(%ebp), %ebx                      # x86gen:345 x86frame:361
	imull %ebx                                # x86gen:345 x86frame:366
	movl %eax, -56(%ebp)                      # x86gen:346 x86frame:619
	movl -60(%ebp), %ebx                      # x86gen:303 x86frame:571
	movl -56(%ebp), %ecx                      # x86gen:303 x86frame:576
	addl %ecx, %ebx                           # x86gen:303 x86frame:581
	movl %ebx, -60(%ebp)                      # x86gen:303 x86frame:586
	movl -60(%ebp), %ebx                      # x86gen:127 x86frame:626
	movl $L4_string, %ebx                     # x86gen:431 x86frame:328
	movl %ebx, -64(%ebp)                      # x86gen:431 x86frame:333
	movl -64(%ebp), %ecx                      # x86gen:128 x86frame:626
	movl %ecx, (%ebx)                         # x86gen:133
	movl -4(%ebp), %ebx                       # x86gen:253 x86frame:345
	movl %ebx, -76(%ebp)                      # x86gen:253 x86frame:350
	movl -76(%ebp), %eax                      # x86gen:137 x86frame:626
	jmp L1_block_done                         # x86gen:188
L2_fvar_nil:                                      # x86gen:142
	call recFieldError                        # x86gen:208
	addl $0, %esp                             # x86gen:60
	jmp L3_fvar_nnil                          # x86gen:188
L1_block_done:                                    # x86gen:142
	# FP, SP, RV, calleesaves still live
	leave
	ret
	.size	tigermain, .-tigermain
	.endfunc
# END tigermain


	.data
L4_string:
	.long 8
	.asciz "Somebody"
	.data
L1_string:
	.long 6
	.asciz "Nobody"
	.data
L0_string:
	.long 13
	.asciz "DefaultString"
