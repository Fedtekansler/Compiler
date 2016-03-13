
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
	movl $3, %ebx                             # x86gen:438 x86frame:328
	movl %ebx, -12(%ebp)                      # x86gen:438 x86frame:333
	movl $3, %ebx                             # x86gen:438 x86frame:328
	movl %ebx, -4(%ebp)                       # x86gen:438 x86frame:333
	movl -4(%ebp), %eax                       # x86gen:340 x86frame:626
	movl -12(%ebp), %ebx                      # x86gen:345 x86frame:361
	imull %ebx                                # x86gen:345 x86frame:366
	movl %eax, -16(%ebp)                      # x86gen:346 x86frame:619
	movl -16(%ebp), %eax                      # x86gen:137 x86frame:626
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
