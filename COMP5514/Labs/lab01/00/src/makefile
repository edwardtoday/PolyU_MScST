# =======================================================================
# Author:        George Baciu
# Revised:       04 Nov. 2006
# =======================================================================

TOP	= ..
BINDIR	= $(TOP)/bin
LIBDIR	= $(TOP)/lib
SRCDIR	= $(TOP)/src
EXEC	= $(BINDIR)/main 
NULL	= 

# -----------------------------------------------------------------------

SRCS	=			\
	$(SRCDIR)/main.c	\
	$(SRCDIR)/iterateA.c	\
	$(SRCDIR)/iterateB.c	\
	$(NULL)

OBJS	= $(SRCS:.c=.o)

LINK	= gcc

CC	= gcc

CFLAGS	= -c

LFLAGS	= -g

LDLIBS	= -lm -lc -ldl

# -----------------------------------------------------------------------

default	:	$(EXEC)
		sleep 4
		$(EXEC)


$(EXEC)	:	$(OBJS)
		$(LINK) $(OBJS) $(LFLAGS) $(LDLIBS) -o $(EXEC)

.c.o	:
		$(CC) $(CFLAGS) $<

clear	:	clean
		/bin/rm -rf *.exe
		/bin/rm -rf $(BINDIR)/*.exe

clean	:;	/bin/rm -rf *.o
		/bin/rm -rf $(BINDIR)/*.o


run:;		$(EXEC)
