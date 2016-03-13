
	.text
# PROCEDURE tigermain
	.globl	tigermain
	.func	tigermain
	.type	tigermain, @function
tigermain:
	# FRAME tigermain(1 formals, 31 locals)
	pushl %ebp
	movl %esp, %ebp
	subl $124, %esp
	# SP, FP, calleesaves, argregs have values
L18_blocks:
	movl %ebp, -8(%ebp)
	movl -8(%ebp), %ebx
	addl $-4, %ebx
	movl %ebx, -8(%ebp)
	movl -8(%ebp), %ebx
	movl %ebx, -24(%ebp)
	movl -12(%ebp), %ebx
	movl $2, %ebx
	movl %ebx, -12(%ebp)
	movl -12(%ebp), %ebx
	pushl %ebx
	call allocRecord
	addl $4, %esp
	movl %eax, -28(%ebp)
	movl -16(%ebp), %ebx
	movl $L1_string, %ebx
	movl %ebx, -16(%ebp)
	movl -28(%ebp), %ebx
	movl -16(%ebp), %ecx
	movl %ecx, 0(%ebx)
	movl -20(%ebp), %ebx
	movl $1000, %ebx
	movl %ebx, -20(%ebp)
	movl -28(%ebp), %ebx
	movl -20(%ebp), %ecx
	movl %ecx, 4(%ebx)
	movl -24(%ebp), %ebx
	movl -28(%ebp), %ecx
	movl %ecx, (%ebx)
	movl -4(%ebp), %ebx
	movl %ebx, -32(%ebp)
	movl -32(%ebp), %ebx
	movl %ebx, -36(%ebp)
	movl -36(%ebp), %ebx
	cmpl $0, %ebx
	je L2_fvar_nil
	jmp L3_fvar_nnil
L3_fvar_nnil:
	movl -36(%ebp), %ebx
	movl %ebx, -52(%ebp)
	movl -40(%ebp), %ebx
	movl $4, %ebx
	movl %ebx, -40(%ebp)
	movl -40(%ebp), %ebx
	movl %ebx, -48(%ebp)
	movl -44(%ebp), %ebx
	movl $0, %ebx
	movl %ebx, -44(%ebp)
	movl -44(%ebp), %eax
	movl -48(%ebp), %ebx
	imull %ebx
	movl %eax, -48(%ebp)
	movl -52(%ebp), %ebx
	movl -48(%ebp), %ecx
	addl %ecx, %ebx
	movl %ebx, -52(%ebp)
	movl -56(%ebp), %ebx
	movl $L4_string, %ebx
	movl %ebx, -56(%ebp)
	movl -52(%ebp), %ebx
	movl -56(%ebp), %ecx
	movl %ecx, (%ebx)
	movl -4(%ebp), %ebx
	movl %ebx, -60(%ebp)
	movl -4(%ebp), %ebx
	movl %ebx, -64(%ebp)
	movl -60(%ebp), %ebx
	movl -64(%ebp), %ecx
	cmpl %ebx, %ecx
	je L14_if_then
	jmp L15_if_else
L15_if_else:
	movl -68(%ebp), %ebx
	movl $L13_string, %ebx
	movl %ebx, -68(%ebp)
	movl -68(%ebp), %ebx
	pushl %ebx
	movl 8(%ebp), %ebx
	movl %ebx, -72(%ebp)
	movl -72(%ebp), %ebx
	pushl %ebx
	call print
	addl $8, %esp
L16_if_join:
	jmp L17_block_done
L2_fvar_nil:
	call recFieldError
	addl $0, %esp
	jmp L3_fvar_nnil
L14_if_then:
	movl -4(%ebp), %ebx
	movl %ebx, -76(%ebp)
	movl -76(%ebp), %ebx
	movl %ebx, -84(%ebp)
	movl -84(%ebp), %ebx
	cmpl $0, %ebx
	je L5_fvar_nil
	jmp L6_fvar_nnil
L6_fvar_nnil:
	movl -80(%ebp), %ebx
	movl $L7_string, %ebx
	movl %ebx, -80(%ebp)
	movl -80(%ebp), %ebx
	pushl %ebx
	movl -84(%ebp), %ebx
	movl %ebx, -100(%ebp)
	movl -88(%ebp), %ebx
	movl $4, %ebx
	movl %ebx, -88(%ebp)
	movl -88(%ebp), %ebx
	movl %ebx, -96(%ebp)
	movl -92(%ebp), %ebx
	movl $0, %ebx
	movl %ebx, -92(%ebp)
	movl -92(%ebp), %eax
	movl -96(%ebp), %ebx
	imull %ebx
	movl %eax, -96(%ebp)
	movl -100(%ebp), %ebx
	movl -96(%ebp), %ecx
	addl %ecx, %ebx
	movl %ebx, -100(%ebp)
	movl -100(%ebp), %ebx
	movl (%ebx), %ecx
	movl %ecx, -104(%ebp)
	movl -104(%ebp), %ebx
	pushl %ebx
	call stringEqual
	addl $8, %esp
	movl %eax, -108(%ebp)
	movl -108(%ebp), %ebx
	cmpl $0, %ebx
	jne L10_if_then
	jmp L11_if_else
L11_if_else:
	movl -112(%ebp), %ebx
	movl $L9_string, %ebx
	movl %ebx, -112(%ebp)
	movl -112(%ebp), %ebx
	pushl %ebx
	movl 8(%ebp), %ebx
	movl %ebx, -116(%ebp)
	movl -116(%ebp), %ebx
	pushl %ebx
	call print
	addl $8, %esp
L12_if_join:
	jmp L16_if_join
L5_fvar_nil:
	call recFieldError
	addl $0, %esp
	jmp L6_fvar_nnil
L10_if_then:
	movl -120(%ebp), %ebx
	movl $L8_string, %ebx
	movl %ebx, -120(%ebp)
	movl -120(%ebp), %ebx
	pushl %ebx
	movl 8(%ebp), %ebx
	movl %ebx, -124(%ebp)
	movl -124(%ebp), %ebx
	pushl %ebx
	call print
	addl $8, %esp
	jmp L12_if_join
L17_block_done:
	# FP, SP, RV, calleesaves still live
	leave
	ret
	.size	tigermain, .-tigermain
	.endfunc
# END tigermain


	.data
L13_string:
	.long 4
	.asciz "FAIL"
	.data
L9_string:
	.long 4
	.asciz "FAIL"
	.data
L8_string:
	.long 7
	.asciz "SUCCESS"
	.data
L7_string:
	.long 8
	.asciz "Somebody"
	.data
L4_string:
	.long 8
	.asciz "Somebody"
	.data
L1_string:
	.long 6
	.asciz "Nobody"
	.data
L0_string:
	.long 13
	.asciz "DefaultString"
