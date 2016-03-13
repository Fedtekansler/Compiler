
	.text
# PROCEDURE tigermain
	.globl	tigermain
	.func	tigermain
	.type	tigermain, @function
tigermain:
	# FRAME tigermain(1 formals, 8 locals)
	pushl %ebp
	movl %esp, %ebp
	subl $36, %esp
	# SP, FP, calleesaves, argregs have values
L2_blocks:                                        # x86gen:142
	movl $0, %ebx                             # x86gen:438 x86frame:328
	movl %ebx, -8(%ebp)                       # x86gen:438 x86frame:333
	movl %ebp, %ebx                           # x86gen:96
	movl -8(%ebp), %ecx                       # x86gen:97 x86frame:626
	movl %ecx, -4 (%ebx)                      # x86gen:102
	movl %ebp, %eax                           # x86gen:234
	pushl %eax                                # x86gen:239
	call L1_fun_f                             # x86gen:208
	addl $4, %esp                             # x86gen:60
	movl -4(%ebp), %ebx                       # x86gen:253 x86frame:345
	movl %ebx, -20(%ebp)                      # x86gen:253 x86frame:350
	movl -20(%ebp), %eax                      # x86gen:137 x86frame:626
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
	# FRAME L1_fun_f(1 formals, 9 locals)
	pushl %ebp
	movl %esp, %ebp
	subl $40, %esp
	# SP, FP, calleesaves, argregs have values
L4_blocks:                                        # x86gen:142
	movl 8(%ebp), %ebx                        # x86gen:253 x86frame:345
	movl %ebx, -12(%ebp)                      # x86gen:253 x86frame:350
	movl 8(%ebp), %ebx                        # x86gen:253 x86frame:345
	movl %ebx, -4(%ebp)                       # x86gen:253 x86frame:350
	movl -4(%ebp), %ebx                       # x86gen:253 x86frame:393
	movl -4(%ebx), %ecx                       # x86gen:253 x86frame:398
	movl %ecx, -8(%ebp)                       # x86gen:253 x86frame:403
	movl -8(%ebp), %ebx                       # x86gen:280 x86frame:633
	movl %ebx, -16(%ebp)                      # x86gen:280 x86frame:638
	movl -16(%ebp), %ebx                      # x86gen:285 x86frame:377
	addl $1, %ebx                             # x86gen:285 x86frame:382
	movl %ebx, -16(%ebp)                      # x86gen:285 x86frame:387
	movl -12(%ebp), %ebx                      # x86gen:96 x86frame:626
	movl -16(%ebp), %ecx                      # x86gen:97 x86frame:626
	movl %ecx, -4 (%ebx)                      # x86gen:102
	jmp L3_block_done                         # x86gen:188
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
