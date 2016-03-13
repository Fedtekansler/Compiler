
	.text
# PROCEDURE tigermain
	.globl	tigermain
	.func	tigermain
	.type	tigermain, @function
tigermain:
	# FRAME tigermain(1 formals, 6 locals)
	pushl %ebp
	movl %esp, %ebp
	subl $24, %esp
	# SP, FP, calleesaves, argregs have values
L11_blocks:
	movl -4(%ebp), %ebx
	movl $10, %ebx
	movl %ebx, -4(%ebp)
	movl -4(%ebp), %ebx
	pushl %ebx
	pushl %ebp
	call L1_nfactor
	addl $8, %esp
	movl %eax, -8(%ebp)
	movl -8(%ebp), %ebx
	cmpl $3628800, %ebx
	je L7_if_then
	jmp L8_if_else
L8_if_else:
	movl -12(%ebp), %ebx
	movl $L6_string, %ebx
	movl %ebx, -12(%ebp)
	movl -12(%ebp), %ebx
	pushl %ebx
	movl 8(%ebp), %ebx
	movl %ebx, -16(%ebp)
	movl -16(%ebp), %ebx
	pushl %ebx
	call print
	addl $8, %esp
L9_if_join:
	jmp L10_block_done
L7_if_then:
	movl -20(%ebp), %ebx
	movl $L5_string, %ebx
	movl %ebx, -20(%ebp)
	movl -20(%ebp), %ebx
	pushl %ebx
	movl 8(%ebp), %ebx
	movl %ebx, -24(%ebp)
	movl -24(%ebp), %ebx
	pushl %ebx
	call print
	addl $8, %esp
	jmp L9_if_join
L10_block_done:
	# FP, SP, RV, calleesaves still live
	leave
	ret
	.size	tigermain, .-tigermain
	.endfunc
# END tigermain


	.data
L6_string:
	.long 4
	.asciz "FAIL"
	.data
L5_string:
	.long 7
	.asciz "SUCCESS"

	.text
# PROCEDURE L1_nfactor
	.globl	L1_nfactor
	.func	L1_nfactor
	.type	L1_nfactor, @function
L1_nfactor:
	# FRAME L1_nfactor(2 formals, 10 locals)
	pushl %ebp
	movl %esp, %ebp
	subl $40, %esp
	# SP, FP, calleesaves, argregs have values
L13_blocks:
	movl 12(%ebp), %ebx
	movl %ebx, -4(%ebp)
	movl -4(%ebp), %ebx
	cmpl $0, %ebx
	je L2_if_then
	jmp L3_if_else
L3_if_else:
	movl 12(%ebp), %ebx
	movl %ebx, -8(%ebp)
	movl -8(%ebp), %ebx
	movl %ebx, -28(%ebp)
	movl 12(%ebp), %ebx
	movl %ebx, -12(%ebp)
	movl -12(%ebp), %ebx
	movl %ebx, -16(%ebp)
	movl -16(%ebp), %ebx
	subl $1, %ebx
	movl %ebx, -16(%ebp)
	movl -16(%ebp), %ebx
	pushl %ebx
	movl 8(%ebp), %ebx
	movl %ebx, -20(%ebp)
	movl -20(%ebp), %ebx
	pushl %ebx
	call L1_nfactor
	addl $8, %esp
	movl %eax, -24(%ebp)
	movl -24(%ebp), %ebx
	movl %ebx, -32(%ebp)
	movl -28(%ebp), %eax
	movl -32(%ebp), %ebx
	imull %ebx
	movl %eax, -32(%ebp)
	movl -32(%ebp), %ebx
	movl %ebx, -36(%ebp)
L4_if_join:
	movl -36(%ebp), %eax
	jmp L12_block_done
L2_if_then:
	movl -40(%ebp), %ebx
	movl $1, %ebx
	movl %ebx, -40(%ebp)
	movl -40(%ebp), %ebx
	movl %ebx, -36(%ebp)
	jmp L4_if_join
L12_block_done:
	# FP, SP, RV, calleesaves still live
	leave
	ret
	.size	L1_nfactor, .-L1_nfactor
	.endfunc
# END L1_nfactor


	.data
L0_string:
	.long 13
	.asciz "DefaultString"
