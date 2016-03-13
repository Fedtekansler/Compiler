
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
	movl 8(%ebp), %ebx                        # x86gen:253 x86frame:345
	movl %ebx, -8(%ebp)                       # x86gen:253 x86frame:350
	movl -8(%ebp), %eax                       # x86gen:234 x86frame:626
	pushl %eax                                # x86gen:239
	call getChar                              # x86gen:85
	addl $4, %esp                             # x86gen:60
	movl %eax, -16(%ebp)                      # x86gen:87 x86frame:619
	movl %ebp, -12(%ebp)                      # x86gen:280 x86frame:619
	movl -12(%ebp), %ebx                      # x86gen:285 x86frame:377
	addl $-4, %ebx                            # x86gen:285 x86frame:382
	movl %ebx, -12(%ebp)                      # x86gen:285 x86frame:387
	movl -16(%ebp), %ebx                      # x86gen:88 x86frame:633
	movl %ebx, -12(%ebp)                      # x86gen:88 x86frame:638
	movl $0, %ebx                             # x86gen:438 x86frame:328
	movl %ebx, -20(%ebp)                      # x86gen:438 x86frame:333
	movl -20(%ebp), %eax                      # x86gen:137 x86frame:626
	jmp L1_block_done                         # x86gen:188
L1_block_done:                                    # x86gen:142
	# FP, SP, RV, calleesaves still live
	leave
	ret
	.size	tigermain, .-tigermain
	.endfunc
# END tigermain


	.data
L0_string:
	.long 13
	.asciz "DefaultString"
