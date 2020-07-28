/* Copyright 2011-2012 Nicholas J. Kain, licensed under standard MIT license */
.macro OCCLUM_SYSCALL
	// Is running on Occlum?
	cmpq $0, __occlum_entry(%rip)
	je 1f
	// Do Occlum syscall
	lea 8(%rip), %rcx
	jmp __occlum_entry(%rip)
1:
	// Do Linux syscall
	syscall
.endm

.text
.global __unmapself_on_x86_64
.type   __unmapself_on_x86_64,@function
__unmapself_on_x86_64:
	movl $11,%eax   /* SYS_munmap */
	OCCLUM_SYSCALL  /* munmap(arg2,arg3) */
	xor %rdi,%rdi   /* exit() args: always return success */
	movl $60,%eax   /* SYS_exit */
	OCCLUM_SYSCALL  /* exit(0) */
