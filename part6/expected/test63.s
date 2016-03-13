
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
	movl $L12_string, %ebx                    # x86gen:431 x86frame:328
	movl %ebx, -4(%ebp)                       # x86gen:431 x86frame:333
	movl -4(%ebp), %eax                       # x86gen:234 x86frame:626
	pushl %eax                                # x86gen:239
	movl %ebp, %eax                           # x86gen:234
	pushl %eax                                # x86gen:239
	call L1_fun_isdigit                       # x86gen:73
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


	.data
L12_string:
	.long 1
	.asciz "1"

	.text
# PROCEDURE L1_fun_isdigit
	.globl	L1_fun_isdigit
	.func	L1_fun_isdigit
	.type	L1_fun_isdigit, @function
L1_fun_isdigit:
	# FRAME L1_fun_isdigit(2 formals, 30 locals)
	pushl %ebp
	movl %esp, %ebp
	subl $128, %esp
	# SP, FP, calleesaves, argregs have values
L4_blocks:                                        # x86gen:142
	movl 12(%ebp), %ebx                       # x86gen:253 x86frame:345
	movl %ebx, -4(%ebp)                       # x86gen:253 x86frame:350
	movl -4(%ebp), %eax                       # x86gen:234 x86frame:626
	pushl %eax                                # x86gen:239
	movl 8(%ebp), %ebx                        # x86gen:253 x86frame:345
	movl %ebx, -8(%ebp)                       # x86gen:253 x86frame:350
	movl -8(%ebp), %ebx                       # x86gen:253 x86frame:393
	movl 8(%ebx), %ecx                        # x86gen:253 x86frame:398
	movl %ecx, -12(%ebp)                      # x86gen:253 x86frame:403
	movl -12(%ebp), %eax                      # x86gen:234 x86frame:626
	pushl %eax                                # x86gen:239
	call ord                                  # x86gen:73
	addl $8, %esp                             # x86gen:60
	movl %eax, -16(%ebp)                      # x86gen:75 x86frame:619
	movl -16(%ebp), %ebx                      # x86gen:137 x86frame:633
	movl %ebx, -32(%ebp)                      # x86gen:137 x86frame:638
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
	call ord                                  # x86gen:73
	addl $8, %esp                             # x86gen:60
	movl %eax, -36(%ebp)                      # x86gen:75 x86frame:619
	movl -32(%ebp), %ebx                      # x86gen:169 x86frame:633
	movl %ebx, -44(%ebp)                      # x86gen:169 x86frame:638
	movl -36(%ebp), %ebx                      # x86gen:170 x86frame:633
	movl %ebx, -40(%ebp)                      # x86gen:170 x86frame:638
	movl -40(%ebp), %ebx                      # x86gen:175 x86frame:550
	movl -44(%ebp), %edx                      # x86gen:175 x86frame:555
	cmpl %ebx, %edx                           # x86gen:175 x86frame:560
	jge L9_if_then 
	jmp L10_if_else                           # x86gen:181
L10_if_else:                                      # x86gen:142
	movl $0, %ebx                             # x86gen:438 x86frame:328
	movl %ebx, -48(%ebp)                      # x86gen:438 x86frame:333
	movl -48(%ebp), %ebx                      # x86gen:137 x86frame:633
	movl %ebx, -104(%ebp)                     # x86gen:137 x86frame:638
L11_if_join:                                      # x86gen:142
	movl -104(%ebp), %eax                     # x86gen:137 x86frame:626
	jmp L3_block_done                         # x86gen:188
L9_if_then:                                       # x86gen:142
	movl $1, %ebx                             # x86gen:438 x86frame:328
	movl %ebx, -52(%ebp)                      # x86gen:438 x86frame:333
	movl -52(%ebp), %ebx                      # x86gen:137 x86frame:633
	movl %ebx, -108(%ebp)                     # x86gen:137 x86frame:638
	movl 12(%ebp), %ebx                       # x86gen:253 x86frame:345
	movl %ebx, -56(%ebp)                      # x86gen:253 x86frame:350
	movl -56(%ebp), %eax                      # x86gen:234 x86frame:626
	pushl %eax                                # x86gen:239
	movl 8(%ebp), %ebx                        # x86gen:253 x86frame:345
	movl %ebx, -60(%ebp)                      # x86gen:253 x86frame:350
	movl -60(%ebp), %ebx                      # x86gen:253 x86frame:393
	movl 8(%ebx), %ecx                        # x86gen:253 x86frame:398
	movl %ecx, -64(%ebp)                      # x86gen:253 x86frame:403
	movl -64(%ebp), %eax                      # x86gen:234 x86frame:626
	pushl %eax                                # x86gen:239
	call ord                                  # x86gen:73
	addl $8, %esp                             # x86gen:60
	movl %eax, -68(%ebp)                      # x86gen:75 x86frame:619
	movl -68(%ebp), %ebx                      # x86gen:137 x86frame:633
	movl %ebx, -84(%ebp)                      # x86gen:137 x86frame:638
	movl $L3_string, %ebx                     # x86gen:431 x86frame:328
	movl %ebx, -72(%ebp)                      # x86gen:431 x86frame:333
	movl -72(%ebp), %eax                      # x86gen:234 x86frame:626
	pushl %eax                                # x86gen:239
	movl 8(%ebp), %ebx                        # x86gen:253 x86frame:345
	movl %ebx, -76(%ebp)                      # x86gen:253 x86frame:350
	movl -76(%ebp), %ebx                      # x86gen:253 x86frame:393
	movl 8(%ebx), %ecx                        # x86gen:253 x86frame:398
	movl %ecx, -80(%ebp)                      # x86gen:253 x86frame:403
	movl -80(%ebp), %eax                      # x86gen:234 x86frame:626
	pushl %eax                                # x86gen:239
	call ord                                  # x86gen:73
	addl $8, %esp                             # x86gen:60
	movl %eax, -88(%ebp)                      # x86gen:75 x86frame:619
	movl -84(%ebp), %ebx                      # x86gen:169 x86frame:633
	movl %ebx, -96(%ebp)                      # x86gen:169 x86frame:638
	movl -88(%ebp), %ebx                      # x86gen:170 x86frame:633
	movl %ebx, -92(%ebp)                      # x86gen:170 x86frame:638
	movl -92(%ebp), %ebx                      # x86gen:175 x86frame:550
	movl -96(%ebp), %edx                      # x86gen:175 x86frame:555
	cmpl %ebx, %edx                           # x86gen:175 x86frame:560
	jle L7_unEx_t 
	jmp L8_unEx_f                             # x86gen:181
L8_unEx_f:                                        # x86gen:142
	movl $0, %ebx                             # x86gen:438 x86frame:328
	movl %ebx, -100(%ebp)                     # x86gen:438 x86frame:333
	movl -100(%ebp), %ebx                     # x86gen:137 x86frame:633
	movl %ebx, -108(%ebp)                     # x86gen:137 x86frame:638
L7_unEx_t:                                        # x86gen:142
	movl -108(%ebp), %ebx                     # x86gen:137 x86frame:633
	movl %ebx, -104(%ebp)                     # x86gen:137 x86frame:638
	jmp L11_if_join                           # x86gen:188
L3_block_done:                                    # x86gen:142
	# FP, SP, RV, calleesaves still live
	leave
	ret
	.size	L1_fun_isdigit, .-L1_fun_isdigit
	.endfunc
# END L1_fun_isdigit


	.data
L3_string:
	.long 1
	.asciz "9"
	.data
L2_string:
	.long 1
	.asciz "0"
	.data
L0_string:
	.long 13
	.asciz "DefaultString"
