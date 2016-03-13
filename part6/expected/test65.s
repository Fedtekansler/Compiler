
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
	movl $1, %ebx                             # x86gen:438 x86frame:328
	movl %ebx, -4(%ebp)                       # x86gen:438 x86frame:333
	movl -4(%ebp), %ebx                       # x86gen:137 x86frame:633
	movl %ebx, -48(%ebp)                      # x86gen:137 x86frame:638
	movl $L1_string, %ebx                     # x86gen:431 x86frame:328
	movl %ebx, -8(%ebp)                       # x86gen:431 x86frame:333
	movl -8(%ebp), %eax                       # x86gen:234 x86frame:626
	pushl %eax                                # x86gen:239
	movl 8(%ebp), %ebx                        # x86gen:253 x86frame:345
	movl %ebx, -12(%ebp)                      # x86gen:253 x86frame:350
	movl -12(%ebp), %eax                      # x86gen:234 x86frame:626
	pushl %eax                                # x86gen:239
	call ord                                  # x86gen:73
	addl $8, %esp                             # x86gen:60
	movl %eax, -16(%ebp)                      # x86gen:75 x86frame:619
	movl -16(%ebp), %ebx                      # x86gen:137 x86frame:633
	movl %ebx, -28(%ebp)                      # x86gen:137 x86frame:638
	movl $L2_string, %ebx                     # x86gen:431 x86frame:328
	movl %ebx, -20(%ebp)                      # x86gen:431 x86frame:333
	movl -20(%ebp), %eax                      # x86gen:234 x86frame:626
	pushl %eax                                # x86gen:239
	movl 8(%ebp), %ebx                        # x86gen:253 x86frame:345
	movl %ebx, -24(%ebp)                      # x86gen:253 x86frame:350
	movl -24(%ebp), %eax                      # x86gen:234 x86frame:626
	pushl %eax                                # x86gen:239
	call ord                                  # x86gen:73
	addl $8, %esp                             # x86gen:60
	movl %eax, -32(%ebp)                      # x86gen:75 x86frame:619
	movl -28(%ebp), %ebx                      # x86gen:169 x86frame:633
	movl %ebx, -40(%ebp)                      # x86gen:169 x86frame:638
	movl -32(%ebp), %ebx                      # x86gen:170 x86frame:633
	movl %ebx, -36(%ebp)                      # x86gen:170 x86frame:638
	movl -36(%ebp), %ebx                      # x86gen:175 x86frame:550
	movl -40(%ebp), %edx                      # x86gen:175 x86frame:555
	cmpl %ebx, %edx                           # x86gen:175 x86frame:560
	jge L3_unEx_t 
	jmp L4_unEx_f                             # x86gen:181
L4_unEx_f:                                        # x86gen:142
	movl $0, %ebx                             # x86gen:438 x86frame:328
	movl %ebx, -44(%ebp)                      # x86gen:438 x86frame:333
	movl -44(%ebp), %ebx                      # x86gen:137 x86frame:633
	movl %ebx, -48(%ebp)                      # x86gen:137 x86frame:638
L3_unEx_t:                                        # x86gen:142
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
L2_string:
	.long 1
	.asciz "0"
	.data
L1_string:
	.long 1
	.asciz "1"
	.data
L0_string:
	.long 13
	.asciz "DefaultString"
