NAME = Colleen
NAME_B = Grace
NAME_C = Sully

CC = gcc
CFLAGS = -Wall -Wextra -Werror -g3
RM = rm -rf

SRC = Colleen.c
SRCB = Grace.c
SRCC = Sully.c

OBJT = $(SRC:.c=.o)
OBJTB = $(SRCB:.c=.o)
OBJTC = $(SRCC:.c=.o)

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

%.o: %.c
	$(CC) $(CFLAGS) -c $< -o $@

clean:
	$(RM) $(OBJT)
	$(RM) $(OBJTB)
	$(RM) $(OBJTC)

fclean: clean
	$(RM) $(NAME)
	$(RM) $(NAME_B)
	$(RM) $(NAME_C)

re: fclean all

.PHONY: all colleen grace sully clean fclean re