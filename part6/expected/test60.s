
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
	movl $L2_string, %ebx                     # x86gen:431 x86frame:328
	movl %ebx, -4(%ebp)                       # x86gen:431 x86frame:333
	movl -4(%ebp), %eax                       # x86gen:234 x86frame:626
	pushl %eax                                # x86gen:239
	movl $L1_string, %ebx                     # x86gen:431 x86frame:328
	movl %ebx, -8(%ebp)                       # x86gen:431 x86frame:333
	movl -8(%ebp), %eax                       # x86gen:234 x86frame:626
	pushl %eax                                # x86gen:239
	call stringNotEq                          # x86gen:73
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
L2_string:
	.long 12
	.asciz "whateverelse"
	.data
L1_string:
	.long 8
	.asciz "whatever"
	.data
L0_string:
	.long 13
	.asciz "DefaultString"
