
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
	call L1_fun_f                             # x86gen:73
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
# PROCEDURE L1_fun_f
	.globl	L1_fun_f
	.func	L1_fun_f
	.type	L1_fun_f, @function
L1_fun_f:
	# FRAME L1_fun_f(2 formals, 4 locals)
	pushl %ebp
	movl %esp, %ebp
	subl $24, %esp
	# SP, FP, calleesaves, argregs have values
L4_blocks:                                        # x86gen:142
	movl $42, %ebx                            # x86gen:438 x86frame:328
	movl %ebx, -4(%ebp)                       # x86gen:438 x86frame:333
	movl -4(%ebp), %eax                       # x86gen:137 x86frame:626
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
