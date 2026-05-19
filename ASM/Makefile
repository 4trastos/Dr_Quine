NAME = Colleen
NAME_B = Grace
NAME_C = Sully

ASM = nasm
ASMFLAGS = -f elf64
CC = gcc
CFLAGS = -Wall -Wextra -Werror -g -no-pie

RM = rm -rf

SRC = Colleen.s
SRCB = Grace.s
SRCC = Sully.s

OBJT = $(SRC:.s=.o)
OBJTB = $(SRCB:.s=.o)
OBJTC = $(SRCC:.s=.o)

all: colleen grace sully

colleen: $(NAME)

$(NAME): $(OBJT)
	$(CC) $(CFLAGS) -o $(NAME) $(OBJT)

grace: $(NAME_B)

$(NAME_B): $(OBJTB)
	$(CC) $(CFLAGS) -o $(NAME_B) $(OBJTB)

sully: $(NAME_C)

$(NAME_C): $(OBJTC)
	$(CC) $(CFLAGS) -o $(NAME_C) $(OBJTC)

%.o: %.s
	$(ASM) $(ASMFLAGS) $< -o $@

clean:
	$(RM) $(OBJT)
	$(RM) $(OBJTB)
	$(RM) $(OBJTC)
	$(RM) Sully_*.s Sully_*.o Sully_*.c Sully_[0-9] Sully_[0-9][0-9]
	$(RM) Grace_kid.s Grace_kid.c

fclean: clean
	$(RM) $(NAME)
	$(RM) $(NAME_B)
	$(RM) $(NAME_C)

re: fclean all

.PHONY: all colleen grace sully clean fclean re