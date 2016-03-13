
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
	movl $2, %ebx                             # x86gen:438 x86frame:328
	movl %ebx, -8(%ebp)                       # x86gen:438 x86frame:333
	movl $3, %ebx                             # x86gen:438 x86frame:328
	movl %ebx, -4(%ebp)                       # x86gen:438 x86frame:333
	movl -4(%ebp), %eax                       # x86gen:340 x86frame:626
	movl -8(%ebp), %ebx                       # x86gen:345 x86frame:361
	imull %ebx                                # x86gen:345 x86frame:366
	movl %eax, -20(%ebp)                      # x86gen:346 x86frame:619
	movl $4, %ebx                             # x86gen:438 x86frame:328
	movl %ebx, -12(%ebp)                      # x86gen:438 x86frame:333
	movl -12(%ebp), %eax                      # x86gen:340 x86frame:626
	movl -20(%ebp), %ebx                      # x86gen:345 x86frame:361
	imull %ebx                                # x86gen:345 x86frame:366
	movl %eax, -24(%ebp)                      # x86gen:346 x86frame:619
	movl -24(%ebp), %eax                      # x86gen:137 x86frame:626
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
