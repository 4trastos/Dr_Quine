# Dr_Quine

> Proyecto de 42 — Introducción al Teorema de Recursión de Kleene a través de los **quines** y la auto-reproducción de programas.

---

## ¿Qué es un quine?

## - Ayuda: 

[¿Cómo construyo un Quine?](#cómo-construyo-un-quine)

Un quine es un metaprograma cuya salida es idéntica a su propio código fuente. No puede leer el fichero fuente ni usar ninguna entrada de datos externa. Un programa con el código fuente vacío se considera solución trivial (para la mayoría de lenguajes no produce salida, que es exactamente su código fuente).

---

## Estructura del repositorio

```
Dr_Quine/
├── C/
│   ├── Makefile
│   ├── Colleen.c
│   ├── Grace.c
│   └── Sully.c
└── ASM/
    ├── Makefile
    ├── Colleen.s
    ├── Grace.s
    └── Sully.s
```

Cada carpeta contiene su propio `Makefile` con las reglas habituales (`all`, `clean`, `fclean`, `re`).

---

## Instrucciones generales

- El proyecto es corregido **únicamente por personas** (peer-evaluation).
- **Ambas implementaciones son obligatorias**: C y ensamblador x86-64 (Linux).
- El `Makefile` solo recompila y re-enlaza cuando es necesario.
- No se permiten crashes inesperados (segfault, bus error, double free, etc.).
- Arquitectura ensamblador esperada: **x86-64 Linux** con NASM:
  ```
  nasm -f elf64 fichero.s -o fichero.o && gcc fichero.o -o fichero
  ```

---

## Parte Obligatoria

### Programa #1 — Colleen

**Comportamiento:** Al ejecutarse, imprime por stdout una salida **idéntica** a su código fuente.

**Requisitos C:**
- Función `main`.
- Al menos dos comentarios distintos (uno dentro de `main`, otro fuera).
- Al menos una función adicional a `main` que sea llamada.

**Requisitos ASM:**
- Un punto de entrada claro (`_start` o símbolo enlazado a `main`).
- Al menos dos comentarios distintos (uno dentro del entry point o rutina llamada inmediatamente, otro fuera).
- Al menos una rutina/función adicional llamada desde el entry point.

**Verificación:**
```bash
# C
clang -Wall -Wextra -Werror -o Colleen Colleen.c
./Colleen > tmp_Colleen ; diff tmp_Colleen Colleen.c

# ASM
nasm -f elf64 Colleen.s -o Colleen.o && gcc Colleen.o -o Colleen
./Colleen > tmp_Colleen ; diff tmp_Colleen Colleen.s
```
El `diff` debe salir vacío.

---

### Programa #2 — Grace

**Comportamiento:** Al ejecutarse, escribe en un fichero llamado `Grace_kid.c` / `Grace_kid.s` el código fuente del programa. El fichero generado debe ser idéntico al original.

**Requisitos C (estrictos):**
- Sin `main` declarado — sin ninguna función declarada.
- Exactamente **tres `#define`**.
- Exactamente **un comentario**.
- El programa se ejecuta invocando una macro.

**Requisitos ASM (estrictos):**
- Sin rutinas extra más allá del entry point.
- Exactamente **tres macros** (o equivalente más cercano del ensamblador).
- Exactamente **un comentario**.

**Verificación:**
```bash
# C
clang -Wall -Wextra -Werror -o Grace Grace.c
./Grace ; diff Grace.c Grace_kid.c

# ASM
nasm -f elf64 Grace.s -o Grace.o && gcc Grace.o -o Grace
rm -f Grace_kid.s ; ./Grace ; diff Grace_kid.s Grace.s
```
El `diff` debe salir vacío.

---

### Programa #3 — Sully

**Comportamiento:** Al ejecutarse, escribe un fichero `Sully_X.c` / `Sully_X.s` donde `X` es un entero presente en el código fuente. Una vez escrito el fichero, lo compila y ejecuta el programa resultante. Cada generación decrementa el entero en 1. La cadena de ejecución se detiene cuando `X < 0`.

**Reglas:**
- El entero inicial en el fuente es **5**.
- No hay restricciones de estructura más allá de la presencia del entero.
- El programa hijo solo se ejecuta si `X >= 0`.

**Verificación:**
```bash
# C
clang -Wall -Wextra -Werror ../Sully.c -o Sully ; ./Sully
ls -al | grep Sully | wc -l   # debe dar 13
diff ../Sully.c Sully_0.c     # solo difieren en el valor del entero (5 vs 0)

# ASM
nasm -f elf64 ../Sully.s -o Sully.o && gcc Sully.o -o Sully
./Sully
ls -al | grep Sully | wc -l   # debe dar 13
```

---

## Normas adicionales

**Formato de comentario obligatorio:**
```c
/*
** Este programa imprime su propio código fuente al ejecutarse.
*/
```

**Formato de programa sin `main` declarado:**
```c
#include <stdio.h>
#define FT(x) int main(){ /* code */ }
/* ... */
FT(xxxxxxxx)
```

> ⚠️ **Trampa prohibida:** Abrir y leer el fichero fuente, usar `argv`/`argc` o cualquier entrada de datos externa se considera **trampa** y anula el ejercicio.

> ℹ️ Se recomienda el uso de **macros avanzadas** para este proyecto.

---

## Parte Bonus

Rehacer el proyecto completo en un **lenguaje de tu elección** (distinto de C y ASM).

- Copiar el código C a ficheros `.cpp` y llamarlo C++ **no cuenta**.
- Si el lenguaje no tiene macros/define, adapta el programa en consecuencia.
- El bonus **solo se evalúa si la parte obligatoria está completa y perfectamente funcional**.

---

## Conceptos clave a estudiar

- **Quines** y auto-reproducción de programas
- **Teorema de Recursión de Kleene** (fixed points)
- Macros avanzadas en C (stringification, token pasting)
- Escritura de ficheros y `system()`/`exec` en C y ASM
- Ensamblador x86-64 con NASM: syscalls `write`, `open`, `execve`

---

## Recursos recomendados

- [Quine en Wikipedia](https://en.wikipedia.org/wiki/Quine_(computing))
- [Fixed-point combinator](https://en.wikipedia.org/wiki/Fixed-point_combinator)
- [NASM documentation](https://nasm.us/doc/)
- Busca todo lo relacionado con **fixed points** — el subject lo recomienda explícitamente.

---

# ¿Cómo construyo un Quine?


## Indice:

 - [1. ¿Cómo funciona `printf()`?](#1-cómo-funciona-printf)
 - [2. ¿Cómo sería la idea correcta de quine?](#2-cómo-sería-la-idea-correcta-de-quine)

---

## 1. ¿Cómo funciona `printf()`?

Vamos a usar esta pequeña función como ejemplo:
```c
char *a = "Hola y fin\n";
printf("%s", a);
```

`printf()` interpreta el formato y printea por pantalla el argumento asociado al formato:

### Formato:
```c
printf("%s", ...);
        ^
```

### Argumentos (lista variadica):
```c
printf("%s", a);
             ^  
a → "Hola y fin\n"
```

- 👉 printf NO imprime "%s" tal cual
- 👉 Lo usa como cadena de formato

Recorre la cadena byte a byte y los va interpretando:
```c
H o l a   y   f i n \n
```

---

## 2. ¿Cómo sería la idea correcta de quine?

Un quine es un programa que imprime su propio código.

Para poder hacer eso, **guardamos dentro de un `char *` toda nuestra función**.

Vamos a usar esta función y la vamos a imprimir paso por paso:
```c
int main(){char*a="int main(){char*a=%c%s%c;printf(a, 34,a, 34);}";printf(a, 34,a, 34);}
```

Desplegamos la función y partimos del último `printf(a, 34,a, 34);` para que se entienda mejor:
```c
int main()
{
    char *a = "int main(){char*a=%c%s%c;printf(a, 34,a, 34);}";
    printf(a, 34,a, 34);
}
```

### Formato:
```c
printf(a, 34,a, 34);
       ^
char *a = "int main(){char*a=%c%s%c;printf(a, 34,a, 34);}"
```

### Argumentos (lista variadica):
```c
printf(a, 34,a, 34);
          ^  ^  ^
34 → "
a → "int main(){char*a=%c%s%c;printf(a, 34,a, 34);}"
34 → "
```

###  Ejecución:

**`printf(a,...)`** → Recorre y printea byte a byte la cadena almacenada en `a`  hasta que encuentra el primer indentifiador de formato:
```bash
./aout
int main(){char*a=
```

**`char*a=%c`** → Una vez que se topa con el primer indentifiador de formato `%c`, printf siguiendo la secuencias de sus argumentos (lista variable) `printf(a, 34...)` lo printea (`"` = 34 en Ascii):
```bash
int main(){char*a="
```

**`char*a=%c%s`** → Se desplaza un byte a través del identificador de formato y se topa con el formato `%s`.

printf siguiendo la secuencia de argumentos, interpreta el argumento asociado a `%s` en `printf(a, 34,a,...)` que es el contenido completo de `*a`:
```bash
int main(){char*a="int main(){char*a=%c%s%c;printf(a, 34,a, 34);}
```

**`char*a=%c%s%c`** → Se desplaza otro byte e interpreta `%c` que son las comillas que cierran el string:
```bash
int main(){char*a="int main(){char*a=%c%s%c;printf(a, 34,a, 34);}"
```

Y acto seguido se sigue desplazando y printeando byte a byte el el formato `*a` hasta el final:
```bash
int main(){char*a="int main(){char*a=%c%s%c;printf(a, 34,a, 34);}";printf(a, 34,a, 34);}
```

