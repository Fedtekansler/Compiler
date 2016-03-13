
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
	call L2_fun_isdigit                       # x86gen:73
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
# PROCEDURE L2_fun_isdigit
	.globl	L2_fun_isdigit
	.func	L2_fun_isdigit
	.type	L2_fun_isdigit, @function
L2_fun_isdigit:
	# FRAME L2_fun_isdigit(1 formals, 32 locals)
	pushl %ebp
	movl %esp, %ebp
	subl $132, %esp
	# SP, FP, calleesaves, argregs have values
L4_blocks:                                        # x86gen:142
	movl 8(%ebp), %ebx                        # x86gen:253 x86frame:345
	movl %ebx, -4(%ebp)                       # x86gen:253 x86frame:350
	movl -4(%ebp), %ebx                       # x86gen:253 x86frame:393
	movl -4(%ebx), %ecx                       # x86gen:253 x86frame:398
	movl %ecx, -8(%ebp)                       # x86gen:253 x86frame:403
	movl -8(%ebp), %eax                       # x86gen:234 x86frame:626
	pushl %eax                                # x86gen:239
	movl 8(%ebp), %ebx                        # x86gen:253 x86frame:345
	movl %ebx, -12(%ebp)                      # x86gen:253 x86frame:350
	movl -12(%ebp), %ebx                      # x86gen:253 x86frame:393
	movl 8(%ebx), %ecx                        # x86gen:253 x86frame:398
	movl %ecx, -16(%ebp)                      # x86gen:253 x86frame:403
	movl -16(%ebp), %eax                      # x86gen:234 x86frame:626
	pushl %eax                                # x86gen:239
	call ord                                  # x86gen:73
	addl $8, %esp                             # x86gen:60
	movl %eax, -20(%ebp)                      # x86gen:75 x86frame:619
	movl -20(%ebp), %ebx                      # x86gen:137 x86frame:633
	movl %ebx, -36(%ebp)                      # x86gen:137 x86frame:638
	movl $L3_string, %ebx                     # x86gen:431 x86frame:328
	movl %ebx, -24(%ebp)                      # x86gen:431 x86frame:333
	movl -24(%ebp), %eax                      # x86gen:234 x86frame:626
	pushl %eax                                # x86gen:239
	movl 8(%ebp), %ebx                        # x86gen:253 x86frame:345
	movl %ebx, -28(%ebp)                      # x86gen:253 x86frame:350
	movl -28(%ebp), %ebx                      # x86gen:253 x86frame:393
	movl 8(%ebx), %ecx                        # x86gen:253 x86frame:398
	movl %ecx, -32(%ebp)                      # x86gen:253 x86frame:403
	movl -32(%ebp), %eax                      # x86gen:234 x86frame:626
	pushl %eax                                # x86gen:239
	call ord                                  # x86gen:73
	addl $8, %esp                             # x86gen:60
	movl %eax, -40(%ebp)                      # x86gen:75 x86frame:619
	movl -36(%ebp), %ebx                      # x86gen:169 x86frame:633
	movl %ebx, -48(%ebp)                      # x86gen:169 x86frame:638
	movl -40(%ebp), %ebx                      # x86gen:170 x86frame:633
	movl %ebx, -44(%ebp)                      # x86gen:170 x86frame:638
	movl -44(%ebp), %ebx                      # x86gen:175 x86frame:550
	movl -48(%ebp), %edx                      # x86gen:175 x86frame:555
	cmpl %ebx, %edx                           # x86gen:175 x86frame:560
	jge L10_if_then 
	jmp L11_if_else                           # x86gen:181
L11_if_else:                                      # x86gen:142
	movl $0, %ebx                             # x86gen:438 x86frame:328
	movl %ebx, -52(%ebp)                      # x86gen:438 x86frame:333
	movl -52(%ebp), %ebx                      # x86gen:137 x86frame:633
	movl %ebx, -112(%ebp)                     # x86gen:137 x86frame:638
L12_if_join:                                      # x86gen:142
	movl -112(%ebp), %eax                     # x86gen:137 x86frame:626
	jmp L3_block_done                         # x86gen:188
L10_if_then:                                      # x86gen:142
	movl $1, %ebx                             # x86gen:438 x86frame:328
	movl %ebx, -56(%ebp)                      # x86gen:438 x86frame:333
	movl -56(%ebp), %ebx                      # x86gen:137 x86frame:633
	movl %ebx, -116(%ebp)                     # x86gen:137 x86frame:638
	movl 8(%ebp), %ebx                        # x86gen:253 x86frame:345
	movl %ebx, -60(%ebp)                      # x86gen:253 x86frame:350
	movl -60(%ebp), %ebx                      # x86gen:253 x86frame:393
	movl -4(%ebx), %ecx                       # x86gen:253 x86frame:398
	movl %ecx, -64(%ebp)                      # x86gen:253 x86frame:403
	movl -64(%ebp), %eax                      # x86gen:234 x86frame:626
	pushl %eax                                # x86gen:239
	movl 8(%ebp), %ebx                        # x86gen:253 x86frame:345
	movl %ebx, -68(%ebp)                      # x86gen:253 x86frame:350
	movl -68(%ebp), %ebx                      # x86gen:253 x86frame:393
	movl 8(%ebx), %ecx                        # x86gen:253 x86frame:398
	movl %ecx, -72(%ebp)                      # x86gen:253 x86frame:403
	movl -72(%ebp), %eax                      # x86gen:234 x86frame:626
	pushl %eax                                # x86gen:239
	call ord                                  # x86gen:73
	addl $8, %esp                             # x86gen:60
	movl %eax, -76(%ebp)                      # x86gen:75 x86frame:619
	movl -76(%ebp), %ebx                      # x86gen:137 x86frame:633
	movl %ebx, -92(%ebp)                      # x86gen:137 x86frame:638
	movl $L4_string, %ebx                     # x86gen:431 x86frame:328
	movl %ebx, -80(%ebp)                      # x86gen:431 x86frame:333
	movl -80(%ebp), %eax                      # x86gen:234 x86frame:626
	pushl %eax                                # x86gen:239
	movl 8(%ebp), %ebx                        # x86gen:253 x86frame:345
	movl %ebx, -84(%ebp)                      # x86gen:253 x86frame:350
	movl -84(%ebp), %ebx                      # x86gen:253 x86frame:393
	movl 8(%ebx), %ecx                        # x86gen:253 x86frame:398
	movl %ecx, -88(%ebp)                      # x86gen:253 x86frame:403
	movl -88(%ebp), %eax                      # x86gen:234 x86frame:626
	pushl %eax                                # x86gen:239
	call ord                                  # x86gen:73
	addl $8, %esp                             # x86gen:60
	movl %eax, -96(%ebp)                      # x86gen:75 x86frame:619
	movl -92(%ebp), %ebx                      # x86gen:169 x86frame:633
	movl %ebx, -104(%ebp)                     # x86gen:169 x86frame:638
	movl -96(%ebp), %ebx                      # x86gen:170 x86frame:633
	movl %ebx, -100(%ebp)                     # x86gen:170 x86frame:638
	movl -100(%ebp), %ebx                     # x86gen:175 x86frame:550
	movl -104(%ebp), %edx                     # x86gen:175 x86frame:555
	cmpl %ebx, %edx                           # x86gen:175 x86frame:560
	jle L8_unEx_t 
	jmp L9_unEx_f                             # x86gen:181
L9_unEx_f:                                        # x86gen:142
	movl $0, %ebx                             # x86gen:438 x86frame:328
	movl %ebx, -108(%ebp)                     # x86gen:438 x86frame:333
	movl -108(%ebp), %ebx                     # x86gen:137 x86frame:633
	movl %ebx, -116(%ebp)                     # x86gen:137 x86frame:638
L8_unEx_t:                                        # x86gen:142
	movl -116(%ebp), %ebx                     # x86gen:137 x86frame:633
	movl %ebx, -112(%ebp)                     # x86gen:137 x86frame:638
	jmp L12_if_join                           # x86gen:188
L3_block_done:                                    # x86gen:142
	# FP, SP, RV, calleesaves still live
	leave
	ret
	.size	L2_fun_isdigit, .-L2_fun_isdigit
	.endfunc
# END L2_fun_isdigit


	.data
L4_string:
	.long 1
	.asciz "9"
	.data
L3_string:
	.long 1
	.asciz "0"
	.data
L1_string:
	.long 1
	.asciz "5"
	.data
L0_string:
	.long 13
	.asciz "DefaultString"
