
	.text
# PROCEDURE tigermain
	.globl	tigermain
	.func	tigermain
	.type	tigermain, @function
tigermain:
	# FRAME tigermain(1 formals, 37 locals)
	pushl %ebp
	movl %esp, %ebp
	subl $152, %esp
	# SP, FP, calleesaves, argregs have values
L2_blocks:                                        # x86gen:142
	movl %ebp, -8(%ebp)                       # x86gen:280 x86frame:619
	movl -8(%ebp), %ebx                       # x86gen:285 x86frame:377
	addl $-4, %ebx                            # x86gen:285 x86frame:382
	movl %ebx, -8(%ebp)                       # x86gen:285 x86frame:387
	movl -8(%ebp), %ebx                       # x86gen:137 x86frame:633
	movl %ebx, -32(%ebp)                      # x86gen:137 x86frame:638
	movl $20, %ebx                            # x86gen:438 x86frame:328
	movl %ebx, -12(%ebp)                      # x86gen:438 x86frame:333
	movl -12(%ebp), %eax                      # x86gen:234 x86frame:626
	pushl %eax                                # x86gen:239
	movl $6, %ebx                             # x86gen:438 x86frame:328
	movl %ebx, -16(%ebp)                      # x86gen:438 x86frame:333
	movl -16(%ebp), %eax                      # x86gen:234 x86frame:626
	pushl %eax                                # x86gen:239
	movl $L1_string, %ebx                     # x86gen:431 x86frame:328
	movl %ebx, -20(%ebp)                      # x86gen:431 x86frame:333
	movl -20(%ebp), %eax                      # x86gen:234 x86frame:626
	pushl %eax                                # x86gen:239
	movl $0, %ebx                             # x86gen:438 x86frame:328
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
	movl -48(%ebp), %ebx                      # x86gen:137 x86frame:633
	movl %ebx, -84(%ebp)                      # x86gen:137 x86frame:638
	movl -84(%ebp), %ebx                      # x86gen:158 x86frame:633
	movl %ebx, -52(%ebp)                      # x86gen:158 x86frame:638
	movl -52(%ebp), %ebx                      # x86gen:163 x86frame:361
	cmpl $0, %ebx                             # x86gen:163 x86frame:366
	je L4_subs_nilerror 
	jmp L6_subs_nnil                          # x86gen:166
L6_subs_nnil:                                     # x86gen:142
	movl $2, %ebx                             # x86gen:438 x86frame:328
	movl %ebx, -56(%ebp)                      # x86gen:438 x86frame:333
	movl -56(%ebp), %ebx                      # x86gen:137 x86frame:633
	movl %ebx, -124(%ebp)                     # x86gen:137 x86frame:638
	movl -84(%ebp), %ebx                      # x86gen:269 x86frame:393
	movl -4(%ebx), %ecx                       # x86gen:269 x86frame:398
	movl %ecx, -60(%ebp)                      # x86gen:269 x86frame:403
	movl -60(%ebp), %ebx                      # x86gen:137 x86frame:633
	movl %ebx, -128(%ebp)                     # x86gen:137 x86frame:638
	movl -124(%ebp), %ebx                     # x86gen:158 x86frame:633
	movl %ebx, -64(%ebp)                      # x86gen:158 x86frame:638
	movl -64(%ebp), %ebx                      # x86gen:163 x86frame:361
	cmpl $0, %ebx                             # x86gen:163 x86frame:366
	jge L2_subs_nneg 
	jmp L3_subs_idxerror                      # x86gen:166
L3_subs_idxerror:                                 # x86gen:142
	movl $9, %ebx                             # x86gen:438 x86frame:328
	movl %ebx, -68(%ebp)                      # x86gen:438 x86frame:333
	movl -68(%ebp), %eax                      # x86gen:234 x86frame:626
	pushl %eax                                # x86gen:239
	movl $8, %ebx                             # x86gen:438 x86frame:328
	movl %ebx, -72(%ebp)                      # x86gen:438 x86frame:333
	movl -72(%ebp), %eax                      # x86gen:234 x86frame:626
	pushl %eax                                # x86gen:239
	movl $L1_string, %ebx                     # x86gen:431 x86frame:328
	movl %ebx, -76(%ebp)                      # x86gen:431 x86frame:333
	movl -76(%ebp), %eax                      # x86gen:234 x86frame:626
	pushl %eax                                # x86gen:239
	movl $2, %ebx                             # x86gen:438 x86frame:328
	movl %ebx, -80(%ebp)                      # x86gen:438 x86frame:333
	movl -80(%ebp), %eax                      # x86gen:234 x86frame:626
	pushl %eax                                # x86gen:239
	call arrInxError                          # x86gen:208
	addl $16, %esp                            # x86gen:60
L5_subs_noerror:                                  # x86gen:142
	movl -84(%ebp), %ebx                      # x86gen:298 x86frame:633
	movl %ebx, -100(%ebp)                     # x86gen:298 x86frame:638
	movl $4, %ebx                             # x86gen:438 x86frame:328
	movl %ebx, -92(%ebp)                      # x86gen:438 x86frame:333
	movl -124(%ebp), %eax                     # x86gen:340 x86frame:626
	movl -92(%ebp), %ebx                      # x86gen:345 x86frame:361
	imull %ebx                                # x86gen:345 x86frame:366
	movl %eax, -96(%ebp)                      # x86gen:346 x86frame:619
	movl -100(%ebp), %ebx                     # x86gen:303 x86frame:571
	movl -96(%ebp), %ecx                      # x86gen:303 x86frame:576
	addl %ecx, %ebx                           # x86gen:303 x86frame:581
	movl %ebx, -100(%ebp)                     # x86gen:303 x86frame:586
	movl -100(%ebp), %ebx                     # x86gen:137 x86frame:633
	movl %ebx, -104(%ebp)                     # x86gen:137 x86frame:638
	movl -104(%ebp), %ebx                     # x86gen:276 x86frame:393
	movl (%ebx), %ecx                         # x86gen:276 x86frame:398
	movl %ecx, -108(%ebp)                     # x86gen:276 x86frame:403
	movl -108(%ebp), %eax                     # x86gen:137 x86frame:626
	jmp L1_block_done                         # x86gen:188
L4_subs_nilerror:                                 # x86gen:142
	movl $9, %ebx                             # x86gen:438 x86frame:328
	movl %ebx, -112(%ebp)                     # x86gen:438 x86frame:333
	movl -112(%ebp), %eax                     # x86gen:234 x86frame:626
	pushl %eax                                # x86gen:239
	movl $8, %ebx                             # x86gen:438 x86frame:328
	movl %ebx, -116(%ebp)                     # x86gen:438 x86frame:333
	movl -116(%ebp), %eax                     # x86gen:234 x86frame:626
	pushl %eax                                # x86gen:239
	movl $L1_string, %ebx                     # x86gen:431 x86frame:328
	movl %ebx, -120(%ebp)                     # x86gen:431 x86frame:333
	movl -120(%ebp), %eax                     # x86gen:234 x86frame:626
	pushl %eax                                # x86gen:239
	call arrNilError                          # x86gen:208
	addl $12, %esp                            # x86gen:60
	jmp L6_subs_nnil                          # x86gen:188
L2_subs_nneg:                                     # x86gen:142
	movl -124(%ebp), %ebx                     # x86gen:169 x86frame:633
	movl %ebx, -136(%ebp)                     # x86gen:169 x86frame:638
	movl -128(%ebp), %ebx                     # x86gen:170 x86frame:633
	movl %ebx, -132(%ebp)                     # x86gen:170 x86frame:638
	movl -132(%ebp), %ebx                     # x86gen:175 x86frame:550
	movl -136(%ebp), %edx                     # x86gen:175 x86frame:555
	cmpl %ebx, %edx                           # x86gen:175 x86frame:560
	jl L5_subs_noerror 
	jmp L3_CJUMP_NONE                         # x86gen:181
L3_CJUMP_NONE:                                    # x86gen:142
	jmp L3_subs_idxerror                      # x86gen:188
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
	.asciz "../testcases/test30.tig"
	.data
L0_string:
	.long 13
	.asciz "DefaultString"
