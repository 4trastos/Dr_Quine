; Este programa imprime su propio codigo fuente al ejecutarse
global main
extern printf
section .text
ft_b:
    ret
main:
    push rbp
    mov rbp, rsp
    ; [Llamamos ft_b()]
    call ft_b
    mov rdi, fmt
    mov rsi, 10
    mov rdx, 34
    lea rcx, [rel fmt]
    mov rax, 0
    call printf
    mov rax, 0
    mov rsp, rbp
    pop rbp
    ret
section .data
    fmt: db "; Este programa imprime su propio codigo fuente al ejecutarse%1$cglobal main%1$cextern printf%1$csection .text%1$cft_b:%1$c    ret%1$cmain:%1$c    push rbp%1$c    mov rbp, rsp%1$c    ; [Llamamos ft_b()]%1$c    call ft_b%1$c    mov rdi, fmt%1$c    mov rsi, 10%1$c    mov rdx, 34%1$c    lea rcx, [rel fmt]%1$c    mov rax, 0%1$c    call printf%1$c    mov rax, 0%1$c    mov rsp, rbp%1$c    pop rbp%1$c    ret%1$csection .data%1$c    fmt: db %2$c%3$s%2$c, 0%1$c", 0
