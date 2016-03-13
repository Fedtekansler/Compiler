
	.text
# PROCEDURE tigermain
	.globl	tigermain
	.func	tigermain
	.type	tigermain, @function
tigermain:
	# FRAME tigermain(1 formals, 19 locals)
	pushl %ebp
	movl %esp, %ebp
	subl $76, %esp
	# SP, FP, calleesaves, argregs have values
L11_blocks:
	movl %ebp, -8(%ebp)
	movl -8(%ebp), %ebx
	addl $-4, %ebx
	movl %ebx, -8(%ebp)
	movl -8(%ebp), %ebx
	movl %ebx, -20(%ebp)
	movl -12(%ebp), %ebx
	movl $0, %ebx
	movl %ebx, -12(%ebp)
	movl -12(%ebp), %ebx
	pushl %ebx
	movl -16(%ebp), %ebx
	movl $10, %ebx
	movl %ebx, -16(%ebp)
	movl -16(%ebp), %ebx
	pushl %ebx
	call initArray
	addl $8, %esp
	movl %eax, -24(%ebp)
	movl -20(%ebp), %ebx
	movl -24(%ebp), %ecx
	movl %ecx, (%ebx)
	movl -28(%ebp), %ebx
	movl $4, %ebx
	movl %ebx, -28(%ebp)
	movl -28(%ebp), %ebx
	movl %ebx, -68(%ebp)
	movl -4(%ebp), %ebx
	movl %ebx, -32(%ebp)
	movl -32(%ebp), %ebx
	movl %ebx, -40(%ebp)
	movl -68(%ebp), %ebx
	cmpl $0, %ebx
	jl L1_subs_neg
	jmp L2_subs_nneg
L2_subs_nneg:
	movl -40(%ebp), %ebx
	movl -4(%ebx), %ecx
	movl %ecx, -36(%ebp)
	movl -68(%ebp), %ebx
	movl -36(%ebp), %ecx
	cmpl %ebx, %ecx
	jle L3_subs_ovf
	jmp L4_subs_novf
L4_subs_novf:
	movl -40(%ebp), %ebx
	movl %ebx, -52(%ebp)
	movl -44(%ebp), %ebx
	movl $4, %ebx
	movl %ebx, -44(%ebp)
	movl -44(%ebp), %ebx
	movl %ebx, -48(%ebp)
	movl -68(%ebp), %eax
	movl -48(%ebp), %ebx
	imull %ebx
	movl %eax, -48(%ebp)
	movl -52(%ebp), %ebx
	movl -48(%ebp), %ecx
	addl %ecx, %ebx
	movl %ebx, -52(%ebp)
	movl -52(%ebp), %ebx
	movl (%ebx), %ecx
	movl %ecx, -56(%ebp)
	movl -56(%ebp), %ebx
	cmpl $0, %ebx
	je L7_if_then
	jmp L8_if_else
L8_if_else:
	movl -60(%ebp), %ebx
	movl $L6_string, %ebx
	movl %ebx, -60(%ebp)
	movl -60(%ebp), %ebx
	pushl %ebx
	movl 8(%ebp), %ebx
	movl %ebx, -64(%ebp)
	movl -64(%ebp), %ebx
	pushl %ebx
	call print
	addl $8, %esp
L9_if_join:
	jmp L10_block_done
L1_subs_neg:
	movl -68(%ebp), %ebx
	pushl %ebx
	call arrInxError
	addl $4, %esp
	jmp L2_subs_nneg
L3_subs_ovf:
	movl -68(%ebp), %ebx
	pushl %ebx
	call arrInxError
	addl $4, %esp
	jmp L4_subs_novf
L7_if_then:
	movl -72(%ebp), %ebx
	movl $L5_string, %ebx
	movl %ebx, -72(%ebp)
	movl -72(%ebp), %ebx
	pushl %ebx
	movl 8(%ebp), %ebx
	movl %ebx, -76(%ebp)
	movl -76(%ebp), %ebx
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
	.data
L0_string:
	.long 13
	.asciz "DefaultString"
