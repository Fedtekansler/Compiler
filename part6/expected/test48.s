
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
	movl $0, %ebx                             # x86gen:438 x86frame:328
	movl %ebx, -4(%ebp)                       # x86gen:438 x86frame:333
	movl -4(%ebp), %eax                       # x86gen:137 x86frame:626
	jmp L1_block_done                         # x86gen:188
L1_block_done:                                    # x86gen:142
	# FP, SP, RV, calleesaves still live
	leave
	ret
	.size	tigermain, .-tigermain
	.endfunc
# END tigermain



	.text
# PROCEDURE L2_fun_g
	.globl	L2_fun_g
	.func	L2_fun_g
	.type	L2_fun_g, @function
L2_fun_g:
	# FRAME L2_fun_g(2 formals, 4 locals)
	pushl %ebp
	movl %esp, %ebp
	subl $24, %esp
	# SP, FP, calleesaves, argregs have values
L4_blocks:                                        # x86gen:142
	movl 12(%ebp), %ebx                       # x86gen:253 x86frame:345
	movl %ebx, -4(%ebp)                       # x86gen:253 x86frame:350
	movl -4(%ebp), %eax                       # x86gen:137 x86frame:626
	jmp L3_block_done                         # x86gen:188
L3_block_done:                                    # x86gen:142
	# FP, SP, RV, calleesaves still live
	leave
	ret
	.size	L2_fun_g, .-L2_fun_g
	.endfunc
# END L2_fun_g



	.text
# PROCEDURE L1_fun_g
	.globl	L1_fun_g
	.func	L1_fun_g
	.type	L1_fun_g, @function
L1_fun_g:
	# FRAME L1_fun_g(2 formals, 4 locals)
	pushl %ebp
	movl %esp, %ebp
	subl $24, %esp
	# SP, FP, calleesaves, argregs have values
L6_blocks:                                        # x86gen:142
	movl 12(%ebp), %ebx                       # x86gen:253 x86frame:345
	movl %ebx, -4(%ebp)                       # x86gen:253 x86frame:350
	movl -4(%ebp), %eax                       # x86gen:137 x86frame:626
	jmp L5_block_done                         # x86gen:188
L5_block_done:                                    # x86gen:142
	# FP, SP, RV, calleesaves still live
	leave
	ret
	.size	L1_fun_g, .-L1_fun_g
	.endfunc
# END L1_fun_g


	.data
L0_string:
	.long 13
	.asciz "DefaultString"
