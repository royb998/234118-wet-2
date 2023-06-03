.global my_ili_handler

.text
.align 4, 0x90
my_ili_handler:
    push %rbp
    movq %rsp, %rbp

    pushq %rax
    pushq %rbx
    pushq %r8
    pushq %r10

    xor %rbx, %rbx
    xor %rdi, %rdi

    movq 8(%rbp), %r8		# rsi -> r8
    movb (%r8), %bl		# ins -> bl

    cmpb $0x0F, %bl		# 0f == bl
    movq $1, %r10		# 1 -> r10
    jne decide_action_ili
    inc %r10			# 2 -> r10
    movb 1(%r8), %bl		# next ins -> bl

decide_action_ili:
    movq %rbx, %rdi
    pushq %rcx
    pushq %rdx
    pushq %rsi
    pushq %rdi
    pushq %r8
    pushq %r9
    pushq %r10
    pushq %r11
    call what_to_do
    popq %r11
    popq %r10
    popq %r9
    popq %r8
    popq %rdi
    popq %rsi
    popq %rdx
    popq %rcx

    cmpq $0, %rax
    jnz update_rip_ili
    popq %r10
    popq %r8
    popq %rbx
    popq %rax
    jmp *old_ili_handler

update_rip_ili:
    movq %rax, %rdi
    addq %r10, 8(%rbp)

    popq %r10
    popq %r8
    popq %rbx
    popq %rax

    movq %rbp, %rsp
    popq %rbp
    iretq
