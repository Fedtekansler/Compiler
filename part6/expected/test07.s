
	.text
# PROCEDURE tigermain
	.globl	tigermain
	.func	tigermain
	.type	tigermain, @function
tigermain:
	# FRAME tigermain(1 formals, 5 locals)
	pushl %ebp
	movl %esp, %ebp
	subl $24, %esp
	# SP, FP, calleesaves, argregs have values
L2_blocks:                                        # x86gen:142
	movl $L5_string, %ebx                     # x86gen:431 x86frame:328
	movl %ebx, -4(%ebp)                       # x86gen:431 x86frame:333
	movl -4(%ebp), %eax                       # x86gen:234 x86frame:626
	pushl %eax                                # x86gen:239
	movl $0, %ebx                             # x86gen:438 x86frame:328
	movl %ebx, -8(%ebp)                       # x86gen:438 x86frame:333
	movl -8(%ebp), %eax                       # x86gen:234 x86frame:626
	pushl %eax                                # x86gen:239
	movl %ebp, %eax                           # x86gen:234
	pushl %eax                                # x86gen:239
	call L1_fun_do_nothing1                   # x86gen:73
	addl $12, %esp                            # x86gen:60
	movl %eax, %eax                           # x86gen:75
	jmp L1_block_done                         # x86gen:188
L1_block_done:                                    # x86gen:142
	# FP, SP, RV, calleesaves still live
	leave
	ret
	.size	tigermain, .-tigermain
	.endfunc
# END tigermain


	.data
L5_string:
	.long 4
	.asciz "str2"

	.text
# PROCEDURE L2_fun_do_nothing2
	.globl	L2_fun_do_nothing2
	.func	L2_fun_do_nothing2
	.type	L2_fun_do_nothing2, @function
L2_fun_do_nothing2:
	# FRAME L2_fun_do_nothing2(2 formals, 7 locals)
	pushl %ebp
	movl %esp, %ebp
	subl $36, %esp
	# SP, FP, calleesaves, argregs have values
L4_blocks:                                        # x86gen:142
	movl $L3_string, %ebx                     # x86gen:431 x86frame:328
	movl %ebx, -4(%ebp)                       # x86gen:431 x86frame:333
	movl -4(%ebp), %eax                       # x86gen:234 x86frame:626
	pushl %eax                                # x86gen:239
	movl 12(%ebp), %ebx                       # x86gen:253 x86frame:345
	movl %ebx, -8(%ebp)                       # x86gen:253 x86frame:350
	movl -8(%ebp), %eax                       # x86gen:234 x86frame:626
	pushl %eax                                # x86gen:239
	movl 8(%ebp), %ebx                        # x86gen:253 x86frame:345
	movl %ebx, -12(%ebp)                      # x86gen:253 x86frame:350
	movl -12(%ebp), %eax                      # x86gen:234 x86frame:626
	pushl %eax                                # x86gen:239
	call L1_fun_do_nothing1                   # x86gen:208
	addl $12, %esp                            # x86gen:60
	movl $L4_string, %ebx                     # x86gen:431 x86frame:328
	movl %ebx, -16(%ebp)                      # x86gen:431 x86frame:333
	movl -16(%ebp), %eax                      # x86gen:137 x86frame:626
	jmp L3_block_done                         # x86gen:188
L3_block_done:                                    # x86gen:142
	# FP, SP, RV, calleesaves still live
	leave
	ret
	.size	L2_fun_do_nothing2, .-L2_fun_do_nothing2
	.endfunc
# END L2_fun_do_nothing2


	.data
L4_string:
	.long 1
	.asciz " "
	.data
L3_string:
	.long 3
	.asciz "str"

	.text
# PROCEDURE L1_fun_do_nothing1
	.globl	L1_fun_do_nothing1
	.func	L1_fun_do_nothing1
	.type	L1_fun_do_nothing1, @function
L1_fun_do_nothing1:
	# FRAME L1_fun_do_nothing1(3 formals, 7 locals)
	pushl %ebp
	movl %esp, %ebp
	subl $40, %esp
	# SP, FP, calleesaves, argregs have values
L6_blocks:                                        # x86gen:142
	movl 12(%ebp), %ebx                       # x86gen:253 x86frame:345
	movl %ebx, -4(%ebp)                       # x86gen:253 x86frame:350
	movl -4(%ebp), %ebx                       # x86gen:280 x86frame:633
	movl %ebx, -8(%ebp)                       # x86gen:280 x86frame:638
	movl -8(%ebp), %ebx                       # x86gen:285 x86frame:377
	addl $1, %ebx                             # x86gen:285 x86frame:382
	movl %ebx, -8(%ebp)                       # x86gen:285 x86frame:387
	movl -8(%ebp), %eax                       # x86gen:234 x86frame:626
	pushl %eax                                # x86gen:239
	movl 8(%ebp), %ebx                        # x86gen:253 x86frame:345
	movl %ebx, -12(%ebp)                      # x86gen:253 x86frame:350
	movl -12(%ebp), %eax                      # x86gen:234 x86frame:626
	pushl %eax                                # x86gen:239
	call L2_fun_do_nothing2                   # x86gen:208
	addl $8, %esp                             # x86gen:60
	movl $0, %ebx                             # x86gen:438 x86frame:328
	movl %ebx, -16(%ebp)                      # x86gen:438 x86frame:333
	movl -16(%ebp), %eax                      # x86gen:137 x86frame:626
	jmp L5_block_done                         # x86gen:188
L5_block_done:                                    # x86gen:142
	# FP, SP, RV, calleesaves still live
	leave
	ret
	.size	L1_fun_do_nothing1, .-L1_fun_do_nothing1
	.endfunc
# END L1_fun_do_nothing1


	.data
L0_string:
	.long 13
	.asciz "DefaultString"
