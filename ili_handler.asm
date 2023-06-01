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
    pushq %rdi
    xor %rbx, %rbx
    xor %rdi, %rdi

    movq 8(%rbp), %r8
    addq 16(%rbp), %r8
    movb (%r8), %bl

    cmpb $0x0F, %bl
    movq $1, %r10
    jne decide_action_ili
    inc %r10
    movb 1(%r8), %bl

decide_action_ili:
    addq %rbx, %rdi
    call what_to_do

    cmpl $0, %eax
    jnz update_rip_ili
    call old_ili_handler
    jmp end_ili

update_rip_ili:
    addq %r10, 8(%rbp)

end_ili:
    popq %rdi
    popq %r10
    popq %rbx
    popq %r8
    popq %rax

    movq %rbp, %rsp
    popq %rbp
    iretq
