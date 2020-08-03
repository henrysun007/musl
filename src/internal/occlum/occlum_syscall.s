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
