
	.text
# PROCEDURE tigermain
	.globl	tigermain
	.func	tigermain
	.type	tigermain, @function
tigermain:
	# FRAME tigermain(1 formals, 15 locals)
	pushl %ebp
	movl %esp, %ebp
	subl $64, %esp
	# SP, FP, calleesaves, argregs have values
L2_blocks:                                        # x86gen:142
	movl %ebp, -8(%ebp)                       # x86gen:280 x86frame:619
	movl -8(%ebp), %ebx                       # x86gen:285 x86frame:377
	addl $-4, %ebx                            # x86gen:285 x86frame:382
	movl %ebx, -8(%ebp)                       # x86gen:285 x86frame:387
	movl -8(%ebp), %ebx                       # x86gen:137 x86frame:633
	movl %ebx, -32(%ebp)                      # x86gen:137 x86frame:638
	movl $26, %ebx                            # x86gen:438 x86frame:328
	movl %ebx, -12(%ebp)                      # x86gen:438 x86frame:333
	movl -12(%ebp), %eax                      # x86gen:234 x86frame:626
	pushl %eax                                # x86gen:239
	movl $4, %ebx                             # x86gen:438 x86frame:328
	movl %ebx, -16(%ebp)                      # x86gen:438 x86frame:333
	movl -16(%ebp), %eax                      # x86gen:234 x86frame:626
	pushl %eax                                # x86gen:239
	movl $L1_string, %ebx                     # x86gen:431 x86frame:328
	movl %ebx, -20(%ebp)                      # x86gen:431 x86frame:333
	movl -20(%ebp), %eax                      # x86gen:234 x86frame:626
	pushl %eax                                # x86gen:239
	movl $1, %ebx                             # x86gen:438 x86frame:328
	movl %ebx, -24(%ebp)                      # x86gen:438 x86frame:333
	movl -24(%ebp), %eax                      # x86gen:234 x86frame:626
	pushl %eax                                # x86gen:239
	movl $10, %ebx                            # x86gen:438 x86frame:328
	movl %ebx, -28(%ebp)                      # x86gen:438 x86frame:333
	movl -28(%ebp), %eax                      # x86gen:234 x86frame:626
	pushl %eax                                # x86gen:239
	call initArray                            # x86gen:73
	addl $20, %esp                            # x86gen:60
	movl %eax, -36(%ebp)                      # x86gen:75 x86frame:619
	movl -32(%ebp), %ebx                      # x86gen:127 x86frame:626
	movl -36(%ebp), %ecx                      # x86gen:128 x86frame:626
	movl %ecx, (%ebx)                         # x86gen:133
	movl -4(%ebp), %ebx                       # x86gen:253 x86frame:345
	movl %ebx, -48(%ebp)                      # x86gen:253 x86frame:350
	movl -48(%ebp), %eax                      # x86gen:137 x86frame:626
	jmp L1_block_done                         # x86gen:188
L1_block_done:                                    # x86gen:142
	# FP, SP, RV, calleesaves still live
	leave
	ret
	.size	tigermain, .-tigermain
	.endfunc
# END tigermain


	.data
L1_string:
	.long 23
	.asciz "../testcases/test52.tig"
	.data
L0_string:
	.long 13
	.asciz "DefaultString"
