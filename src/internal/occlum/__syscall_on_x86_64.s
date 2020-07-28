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

.global __syscall_on_x86_64
.hidden __syscall_on_x86_64
.type __syscall_on_x86_64,@function
__syscall_on_x86_64:
	movq %rdi,%rax
	movq %rsi,%rdi
	movq %rdx,%rsi
	movq %rcx,%rdx
	movq %r8,%r10
	movq %r9,%r8
	movq 8(%rsp),%r9
	OCCLUM_SYSCALL
__end:
	ret
