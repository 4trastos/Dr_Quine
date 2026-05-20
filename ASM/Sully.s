; i = 5
global main
extern sprintf
extern strcmp
extern fopen
extern fprintf
extern fclose
extern system
section .data
CODE_STR db "; i = %4$d%1$cglobal main%1$cextern sprintf%1$cextern strcmp%1$cextern fopen%1$cextern fprintf%1$cextern fclose%1$cextern system%1$csection .data%1$cCODE_STR db %2$c%3$s%2$c, 0%1$cSRC_TEMPLATE db %2$cSully_%%d.s%2$c, 0%1$cEXEC_TEMPLATE db %2$cSully_%%d%2$c, 0%1$cCURRENT_FILE db %2$cSully_%4$d.s%2$c, 0%1$cOPEN_PERM db %2$cw%2$c, 0%1$cCOMPILE_TEMPLATE db %2$cnasm -f elf64 %%s -o %%s.o && gcc -no-pie %%s.o -o %%s%2$c, 0%1$cRUN_TEMPLATE db %2$c./%%s%2$c, 0%1$cX_VALUE dq %4$d%1$cCOMPILE_CMD times 400 db 0%1$cRUN_CMD times 200 db 0%1$cSRC_FILENAME times 100 db 0%1$cEXEC_FILENAME times 100 db 0%1$cCURRENT_FILENAME times 100 db 0%1$csection .text%1$cmain:%1$c    push rbp%1$c    mov rbp, rsp%1$c    push r12%1$c    push r13%1$c    mov r12, qword[rel X_VALUE]%1$c    cmp r12, 0%1$c    jl .end%1$c    lea rdi, [rel CURRENT_FILENAME]%1$c    lea rsi, [rel SRC_TEMPLATE]%1$c    mov rdx, r12%1$c    mov rax, 0%1$c    call sprintf%1$c    lea rdi, [rel CURRENT_FILENAME]%1$c    lea rsi, [rel CURRENT_FILE]%1$c    call strcmp%1$c    test rax, rax%1$c    jnz .create_src%1$c    dec r12%1$c    cmp r12, 0%1$c    jl .end%1$c.create_src:%1$c    lea rdi, [rel SRC_FILENAME]%1$c    lea rsi, [rel SRC_TEMPLATE]%1$c    mov rdx, r12%1$c    mov rax, 0%1$c    call sprintf%1$c    lea rdi, [rel EXEC_FILENAME]%1$c    lea rsi, [rel EXEC_TEMPLATE]%1$c    mov rdx, r12%1$c    mov rax, 0%1$c    call sprintf%1$c    lea rdi, [rel SRC_FILENAME]%1$c    lea rsi, [rel OPEN_PERM]%1$c    call fopen%1$c    test rax, rax%1$c    jz .end%1$c    mov r13, rax%1$c    mov rdi, r13%1$c    lea rsi, [rel CODE_STR]%1$c    mov rdx, 10%1$c    mov rcx, 34%1$c    lea r8, [rel CODE_STR]%1$c    mov r9, r12%1$c    mov rax, 0%1$c    call fprintf%1$c    mov rdi, r13%1$c    call fclose%1$c    lea rdi, [rel COMPILE_CMD]%1$c    lea rsi, [rel COMPILE_TEMPLATE]%1$c    lea rdx, [rel SRC_FILENAME]%1$c    lea rcx, [rel EXEC_FILENAME]%1$c    lea r8, [rel EXEC_FILENAME]%1$c    lea r9, [rel EXEC_FILENAME]%1$c    mov rax, 0%1$c    call sprintf%1$c    lea rdi, [rel RUN_CMD]%1$c    lea rsi, [rel RUN_TEMPLATE]%1$c    lea rdx, [rel EXEC_FILENAME]%1$c    mov rax, 0%1$c    call sprintf%1$c    lea rdi, [rel COMPILE_CMD]%1$c    call system%1$c    lea rdi, [rel RUN_CMD]%1$c    call system%1$c.end:%1$c    pop r13%1$c    pop r12%1$c    mov rsp, rbp%1$c    pop rbp%1$c    ret%1$c", 0
SRC_TEMPLATE db "Sully_%d.s", 0
EXEC_TEMPLATE db "Sully_%d", 0
CURRENT_FILE db "Sully.s", 0
OPEN_PERM db "w", 0
COMPILE_TEMPLATE db "nasm -f elf64 %s -o %s.o && gcc -no-pie %s.o -o %s", 0
RUN_TEMPLATE db "./%s", 0
X_VALUE dq 5
COMPILE_CMD times 400 db 0
RUN_CMD times 200 db 0
SRC_FILENAME times 100 db 0
EXEC_FILENAME times 100 db 0
CURRENT_FILENAME times 100 db 0
section .text
main:
    push rbp
    mov rbp, rsp
    push r12
    push r13
    mov r12, qword[rel X_VALUE]
    cmp r12, 0
    jl .end
    lea rdi, [rel CURRENT_FILENAME]
    lea rsi, [rel SRC_TEMPLATE]
    mov rdx, r12
    mov rax, 0
    call sprintf
    lea rdi, [rel CURRENT_FILENAME]
    lea rsi, [rel CURRENT_FILE]
    call strcmp
    test rax, rax
    jnz .create_src
    dec r12
    cmp r12, 0
    jl .end
.create_src:
    lea rdi, [rel SRC_FILENAME]
    lea rsi, [rel SRC_TEMPLATE]
    mov rdx, r12
    mov rax, 0
    call sprintf
    lea rdi, [rel EXEC_FILENAME]
    lea rsi, [rel EXEC_TEMPLATE]
    mov rdx, r12
    mov rax, 0
    call sprintf
    lea rdi, [rel SRC_FILENAME]
    lea rsi, [rel OPEN_PERM]
    call fopen
    test rax, rax
    jz .end
    mov r13, rax
    mov rdi, r13
    lea rsi, [rel CODE_STR]
    mov rdx, 10
    mov rcx, 34
    lea r8, [rel CODE_STR]
    mov r9, r12
    mov rax, 0
    call fprintf
    mov rdi, r13
    call fclose
    lea rdi, [rel COMPILE_CMD]
    lea rsi, [rel COMPILE_TEMPLATE]
    lea rdx, [rel SRC_FILENAME]
    lea rcx, [rel EXEC_FILENAME]
    lea r8, [rel EXEC_FILENAME]
    lea r9, [rel EXEC_FILENAME]
    mov rax, 0
    call sprintf
    lea rdi, [rel RUN_CMD]
    lea rsi, [rel RUN_TEMPLATE]
    lea rdx, [rel EXEC_FILENAME]
    mov rax, 0
    call sprintf
    lea rdi, [rel COMPILE_CMD]
    call system
    lea rdi, [rel RUN_CMD]
    call system
.end:
    pop r13
    pop r12
    mov rsp, rbp
    pop rbp
    ret
