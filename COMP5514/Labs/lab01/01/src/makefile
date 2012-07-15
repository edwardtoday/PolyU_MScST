# =======================================================================
# Author:        George Baciu
# Revised:       04 Nov. 2006
# =======================================================================

TOP	= ..
BINDIR	= $(TOP)/bin
LIBDIR	= $(TOP)/lib
SRCDIR	= $(TOP)/src
EXEC	= $(BINDIR)/main.exe
NULL	= 

# -----------------------------------------------------------------------

INCDIR	= -I/usr/include/opengl	\
				\
	$(NULL)

# -----------------------------------------------------------------------

SRCS	=			\
	$(SRCDIR)/main.c	\
				\
	$(NULL)

OBJS	= $(SRCS:.c=.o)		\
				\
	$(NULL)


LINK	= gcc

CC	= gcc

CFLAGS	= -c $(INCDIR)

LFLAGS	= -g

LDLIBS	= -lglut32 -lglu32 -lopengl32 -lgdi32 -lm -lc -ldl -lg -lutil

DLLIBS	= /usr/bin/glut32.dll

# -----------------------------------------------------------------------

default	:	$(EXEC)
		sleep 4
		$(EXEC)


$(EXEC)	:	$(OBJS)
		$(LINK) -o $(EXEC) $(OBJS) $(LFLAGS) $(LDLIBS)

.c.o	:
		$(CC) $(CFLAGS) $<

clear	:	clean
		/bin/rm -rf *.exe
		/bin/rm -rf $(BINDIR)/*.exe

clean	:;	/bin/rm -rf *.o
		/bin/rm -rf $(BINDIR)/*.o


run:;		$(EXEC)
