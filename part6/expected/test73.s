
	.text
# PROCEDURE tigermain
	.globl	tigermain
	.func	tigermain
	.type	tigermain, @function
tigermain:
	# FRAME tigermain(1 formals, 9 locals)
	pushl %ebp
	movl %esp, %ebp
	subl $40, %esp
	# SP, FP, calleesaves, argregs have values
L2_blocks:                                        # x86gen:142
	movl $L6_string, %ebx                     # x86gen:431 x86frame:328
	movl %ebx, -4(%ebp)                       # x86gen:431 x86frame:333
	movl -4(%ebp), %eax                       # x86gen:234 x86frame:626
	pushl %eax                                # x86gen:239
	movl $1, %ebx                             # x86gen:438 x86frame:328
	movl %ebx, -8(%ebp)                       # x86gen:438 x86frame:333
	movl -8(%ebp), %eax                       # x86gen:234 x86frame:626
	pushl %eax                                # x86gen:239
	movl $1, %ebx                             # x86gen:438 x86frame:328
	movl %ebx, -12(%ebp)                      # x86gen:438 x86frame:333
	movl -12(%ebp), %eax                      # x86gen:234 x86frame:626
	pushl %eax                                # x86gen:239
	movl %ebp, %eax                           # x86gen:234
	pushl %eax                                # x86gen:239
	call L1_fun_chk                           # x86gen:208
	addl $16, %esp                            # x86gen:60
	movl $L7_string, %ebx                     # x86gen:431 x86frame:328
	movl %ebx, -16(%ebp)                      # x86gen:431 x86frame:333
	movl -16(%ebp), %eax                      # x86gen:234 x86frame:626
	pushl %eax                                # x86gen:239
	movl $1, %ebx                             # x86gen:438 x86frame:328
	movl %ebx, -20(%ebp)                      # x86gen:438 x86frame:333
	movl -20(%ebp), %eax                      # x86gen:234 x86frame:626
	pushl %eax                                # x86gen:239
	movl $0, %ebx                             # x86gen:438 x86frame:328
	movl %ebx, -24(%ebp)                      # x86gen:438 x86frame:333
	movl -24(%ebp), %eax                      # x86gen:234 x86frame:626
	pushl %eax                                # x86gen:239
	movl %ebp, %eax                           # x86gen:234
	pushl %eax                                # x86gen:239
	call L1_fun_chk                           # x86gen:208
	addl $16, %esp                            # x86gen:60
	jmp L1_block_done                         # x86gen:188
L1_block_done:                                    # x86gen:142
	# FP, SP, RV, calleesaves still live
	leave
	ret
	.size	tigermain, .-tigermain
	.endfunc
# END tigermain


	.data
L7_string:
	.long 6
	.asciz "Not OK"
	.data
L6_string:
	.long 2
	.asciz "OK"

	.text
# PROCEDURE L1_fun_chk
	.globl	L1_fun_chk
	.func	L1_fun_chk
	.type	L1_fun_chk, @function
L1_fun_chk:
	# FRAME L1_fun_chk(4 formals, 13 locals)
	pushl %ebp
	movl %esp, %ebp
	subl $68, %esp
	# SP, FP, calleesaves, argregs have values
L4_blocks:                                        # x86gen:142
	movl 12(%ebp), %ebx                       # x86gen:253 x86frame:345
	movl %ebx, -4(%ebp)                       # x86gen:253 x86frame:350
	movl -4(%ebp), %ebx                       # x86gen:169 x86frame:633
	movl %ebx, -16(%ebp)                      # x86gen:169 x86frame:638
	movl 16(%ebp), %ebx                       # x86gen:253 x86frame:345
	movl %ebx, -8(%ebp)                       # x86gen:253 x86frame:350
	movl -8(%ebp), %ebx                       # x86gen:170 x86frame:633
	movl %ebx, -12(%ebp)                      # x86gen:170 x86frame:638
	movl -12(%ebp), %ebx                      # x86gen:175 x86frame:550
	movl -16(%ebp), %edx                      # x86gen:175 x86frame:555
	cmpl %ebx, %edx                           # x86gen:175 x86frame:560
	je L3_if_then 
	jmp L4_if_else                            # x86gen:181
L4_if_else:                                       # x86gen:142
	movl $L2_string, %ebx                     # x86gen:431 x86frame:328
	movl %ebx, -20(%ebp)                      # x86gen:431 x86frame:333
	movl -20(%ebp), %eax                      # x86gen:234 x86frame:626
	pushl %eax                                # x86gen:239
	movl 8(%ebp), %ebx                        # x86gen:253 x86frame:345
	movl %ebx, -24(%ebp)                      # x86gen:253 x86frame:350
	movl -24(%ebp), %ebx                      # x86gen:253 x86frame:393
	movl 8(%ebx), %ecx                        # x86gen:253 x86frame:398
	movl %ecx, -28(%ebp)                      # x86gen:253 x86frame:403
	movl -28(%ebp), %eax                      # x86gen:234 x86frame:626
	pushl %eax                                # x86gen:239
	call print                                # x86gen:208
	addl $8, %esp                             # x86gen:60
L5_if_join:                                       # x86gen:142
	jmp L3_block_done                         # x86gen:188
L3_if_then:                                       # x86gen:142
	movl 20(%ebp), %ebx                       # x86gen:253 x86frame:345
	movl %ebx, -32(%ebp)                      # x86gen:253 x86frame:350
	movl -32(%ebp), %eax                      # x86gen:234 x86frame:626
	pushl %eax                                # x86gen:239
	movl 8(%ebp), %ebx                        # x86gen:253 x86frame:345
	movl %ebx, -36(%ebp)                      # x86gen:253 x86frame:350
	movl -36(%ebp), %ebx                      # x86gen:253 x86frame:393
	movl 8(%ebx), %ecx                        # x86gen:253 x86frame:398
	movl %ecx, -40(%ebp)                      # x86gen:253 x86frame:403
	movl -40(%ebp), %eax                      # x86gen:234 x86frame:626
	pushl %eax                                # x86gen:239
	call print                                # x86gen:208
	addl $8, %esp                             # x86gen:60
	jmp L5_if_join                            # x86gen:188
L3_block_done:                                    # x86gen:142
	# FP, SP, RV, calleesaves still live
	leave
	ret
	.size	L1_fun_chk, .-L1_fun_chk
	.endfunc
# END L1_fun_chk


	.data
L2_string:
	.long 1
	.asciz "."
	.data
L0_string:
	.long 13
	.asciz "DefaultString"
