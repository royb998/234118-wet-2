.global my_ili_handler

.text
.align 4, 0x90
my_ili_handler:
    push %rbp
    movq %rsp, %rbp

    pushq %rax
    pushq %r8
    pushq %rbx
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
    call what_to_do

    cmpq $0, %rax
    jnz update_rip_ili
    popq %r10
    popq %rbx
    popq %r8
    popq %rax
    jmp *old_ili_handler
    jmp end_ili

update_rip_ili:
    movq %rax, %rdi
    addq %r10, 8(%rbp)

end_ili:
    popq %r10
    popq %rbx
    popq %r8
    popq %rax

    movq %rbp, %rsp
    popq %rbp
    iretq
