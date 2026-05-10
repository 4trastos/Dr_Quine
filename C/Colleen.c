#include <stdio.h>

/* Este programa imprime su propio código fuente al ejecutarse */

void ft_b(){
    return;
}

int main(){
    char *a = "#include <stdio.h>%c%c/* %s */%c%cvoid ft_b(){%c    return;%c}%c%cint main(){%c    char *a = %c%s%c;%c    char *b = %c%s%c;%c    /* Llamamos ft_b() */%c    ft_b();%c    printf(a, 10, 10, b, 10, 10, 10, 10, 10, 10, 10, 34, a, 34, 10, 34, b, 34, 10, 10, 10, 10, 10);%c    return (0);%c}";
    char *b = "Este programa imprime su propio código fuente al ejecutarse";
    /* Llamamos ft_b() */
    ft_b();
    printf(a, 10, 10, b, 10, 10, 10, 10, 10, 10, 10, 34, a, 34, 10, 34, b, 34, 10, 10, 10, 10, 10);
    return (0);
}