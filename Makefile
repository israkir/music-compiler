# Makefile for music-compiler
# Author: b96902133, Hakki Caner KIRMIZI
# Date: 20100613

LEX=flex
YACC=bison
PROG=music-compiler
SCNR=notation-scanner
SCORE=Score
CC=gcc
SRCS=$(PROG).y $(SCNR).l
FLAGS=-g -O -lm
YFLAGS=-ly -ll -lfl

all: $(PROG)

$(PROG): $(SRCS)
	$(LEX) $(SCNR).l
	$(YACC) -dv $(PROG).y
	$(CC) $(FLAGS) -o $(PROG) $(PROG).tab.c $(YFLAGS)

clean:
	rm -rf $(PROG) lex.yy.c $(PROG).tab.h $(PROG).tab.c $(PROG).output *.o $(SCORE).java $(SCORE).class *.mid
