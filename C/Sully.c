#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define CODE "#include <stdio.h>%c#include <stdlib.h>%c#include <string.h>%c%c#define CODE %c%s%c%cint main()%c{%c    int i = %d;%c    if (i < 0)%c        return (0);%c    char name[20];%c    char exec[20];%c    char cmd[100];%c    sprintf(name, %cSully_%%d.c%c, i);%c    if (strcmp(name, __FILE__) == 0)%c    {%c        i--;%c        sprintf(name, %cSully_%%d.c%c, i);%c    }%c    if (i < 0)%c        return (0);%c    FILE *fd = fopen(name, %cw%c);%c    if (!fd)%c        return (1);%c    fprintf(fd, CODE, 10, 10, 10, 10, 34, CODE, 34, 10, 10, 10, i, 10, 10, 10, 10, 10, 10, 34, 34, 10, 10, 10, 10, 34, 34, 10, 10, 10, 10, 34, 34, 10, 10, 10, 10, 10, 34, 34, 10, 34, 34, 10, 10, 10, 10);%c    fclose(fd);%c    sprintf(exec, %cSully_%%d%c, i);%c    sprintf(cmd, %cgcc -Wall -Wextra -Werror %%s -o %%s && ./%%s%c, name, exec, exec);%c    system(cmd);%c    return (0);%c}%c"
int main()
{
    int i = 5;
    if (i < 0)
        return (0);
    char name[20];
    char exec[20];
    char cmd[100];
    sprintf(name, "Sully_%d.c", i);
    if (strcmp(name, __FILE__) == 0)
    {
        i--;
        sprintf(name, "Sully_%d.c", i);
    }
    if (i < 0)
        return (0);
    FILE *fd = fopen(name, "w");
    if (!fd)
        return (1);
    fprintf(fd, CODE, 10, 10, 10, 10, 34, CODE, 34, 10, 10, 10, i, 10, 10, 10, 10, 10, 10, 34, 34, 10, 10, 10, 10, 34, 34, 10, 10, 10, 10, 34, 34, 10, 10, 10, 10, 10, 34, 34, 10, 34, 34, 10, 10, 10, 10);
    fclose(fd);
    sprintf(exec, "Sully_%d", i);
    sprintf(cmd, "gcc -Wall -Wextra -Werror %s -o %s && ./%s", name, exec, exec);
    system(cmd);
    return (0);
}
