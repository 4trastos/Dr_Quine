; Este programa escribe su propio codigo fuente en Grace_kid.s
%define FILENAME "Grace_kid.s"
%define OPEN "w"
%macro insert_main 0
global main
extern fopen
extern fprintf
extern fclose
section .text
main:
    push rbp
    mov rbp, rsp
    sub rsp, 16
    mov rdi, file
    mov rsi, mode
    call fopen
    test rax, rax
    je .end
    mov [rbp-8], rax
    mov rdi, [rbp-8]
    mov rsi, fmt
    mov rdx, 10
    mov rcx, 34
    lea r8, [rel fmt]
    mov rax, 0
    call fprintf
    mov rdi, [rbp-8]
    call fclose
.end:
    mov rax, 0
    mov rsp, rbp
    pop rbp
    ret
section .data
    file: db FILENAME, 0
    mode: db OPEN, 0
    fmt: db "; Este programa escribe su propio codigo fuente en Grace_kid.s%1$c%%define FILENAME %2$cGrace_kid.s%2$c%1$c%%define OPEN %2$cw%2$c%1$c%%macro insert_main 0%1$cglobal main%1$cextern fopen%1$cextern fprintf%1$cextern fclose%1$csection .text%1$cmain:%1$c    push rbp%1$c    mov rbp, rsp%1$c    sub rsp, 16%1$c    mov rdi, file%1$c    mov rsi, mode%1$c    call fopen%1$c    test rax, rax%1$c    je .end%1$c    mov [rbp-8], rax%1$c    mov rdi, [rbp-8]%1$c    mov rsi, fmt%1$c    mov rdx, 10%1$c    mov rcx, 34%1$c    lea r8, [rel fmt]%1$c    mov rax, 0%1$c    call fprintf%1$c    mov rdi, [rbp-8]%1$c    call fclose%1$c.end:%1$c    mov rax, 0%1$c    mov rsp, rbp%1$c    pop rbp%1$c    ret%1$csection .data%1$c    file: db FILENAME, 0%1$c    mode: db OPEN, 0%1$c    fmt: db %2$c%3$s%2$c, 0%1$c%%endmacro%1$cinsert_main%1$c", 0
%endmacro
insert_main
