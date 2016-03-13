
	.text
# PROCEDURE tigermain
	.globl	tigermain
	.func	tigermain
	.type	tigermain, @function
tigermain:
	# FRAME tigermain(1 formals, 7 locals)
	pushl %ebp
	movl %esp, %ebp
	subl $32, %esp
	# SP, FP, calleesaves, argregs have values
L2_blocks:                                        # x86gen:142
	movl $L1_string, %ebx                     # x86gen:431 x86frame:328
	movl %ebx, -8(%ebp)                       # x86gen:431 x86frame:333
	movl %ebp, %ebx                           # x86gen:96
	movl -8(%ebp), %ecx                       # x86gen:97 x86frame:626
	movl %ecx, -4 (%ebx)                      # x86gen:102
	movl %ebp, %eax                           # x86gen:234
	pushl %eax                                # x86gen:239
	call L2_fun_compare                       # x86gen:73
	addl $4, %esp                             # x86gen:60
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
# PROCEDURE L2_fun_compare
	.globl	L2_fun_compare
	.func	L2_fun_compare
	.type	L2_fun_compare, @function
L2_fun_compare:
	# FRAME L2_fun_compare(1 formals, 6 locals)
	pushl %ebp
	movl %esp, %ebp
	subl $28, %esp
	# SP, FP, calleesaves, argregs have values
L4_blocks:                                        # x86gen:142
	movl $L3_string, %ebx                     # x86gen:431 x86frame:328
	movl %ebx, -4(%ebp)                       # x86gen:431 x86frame:333
	movl -4(%ebp), %eax                       # x86gen:234 x86frame:626
	pushl %eax                                # x86gen:239
	movl 8(%ebp), %ebx                        # x86gen:253 x86frame:345
	movl %ebx, -8(%ebp)                       # x86gen:253 x86frame:350
	movl -8(%ebp), %ebx                       # x86gen:253 x86frame:393
	movl -4(%ebx), %ecx                       # x86gen:253 x86frame:398
	movl %ecx, -12(%ebp)                      # x86gen:253 x86frame:403
	movl -12(%ebp), %eax                      # x86gen:234 x86frame:626
	pushl %eax                                # x86gen:239
	call stringGreater                        # x86gen:73
	addl $8, %esp                             # x86gen:60
	movl %eax, %eax                           # x86gen:75
	jmp L3_block_done                         # x86gen:188
L3_block_done:                                    # x86gen:142
	# FP, SP, RV, calleesaves still live
	leave
	ret
	.size	L2_fun_compare, .-L2_fun_compare
	.endfunc
# END L2_fun_compare


	.data
L3_string:
	.long 4
	.asciz "else"
	.data
L1_string:
	.long 8
	.asciz "whatever"
	.data
L0_string:
	.long 13
	.asciz "DefaultString"
