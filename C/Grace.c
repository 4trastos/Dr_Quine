#include <stdio.h>
#define CODE "#include <stdio.h>%c#define CODE %c%s%c%c#define RETURN return(0);%c#define FT_B()int main(){ FILE *fb = fopen(%cGrace_kid.c%c, %cw%c); if (!fb) return (1); fprintf(fb, CODE, 10, 34, CODE, 34, 10, 10, 34, 34, 34, 34, 10, 10, 10, 10); fclose(fb);RETURN;}%c%c/* Este programa imprime su propio código fuente al ejecutarse */%c%cFT_B()"
#define RETURN return(0);
#define FT_B()int main(){ FILE *fb = fopen("Grace_kid.c", "w"); if (!fb) return (1); fprintf(fb, CODE, 10, 34, CODE, 34, 10, 10, 34, 34, 34, 34, 10, 10, 10, 10); fclose(fb);RETURN;}

/* Este programa imprime su propio código fuente al ejecutarse */

FT_B()