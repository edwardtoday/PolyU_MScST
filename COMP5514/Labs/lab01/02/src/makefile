# =======================================================================
# Makefile:	Compile and Link C++ programs with g++ in Unix/Linux/CygWin
# Paths:	/usr/lib/gcc/i686-pc-cygwin/3.4.4/include/c++
# Author:	George Baciu
# Revised:	26 Jan. 2007
# =======================================================================

TOP	= ..
BINDIR	= $(TOP)/bin
LIBDIR	= $(TOP)/lib
SRCDIR	= $(TOP)/src
DATDIR	= $(TOP)/dat
EXEC	= $(BINDIR)/main 
NULL	= 

# -----------------------------------------------------------------------

INCDIR	=			\
	 -I/usr/include/opengl	\
	  $(NULL)

# -----------------------------------------------------------------------

SRCS	=			\
	$(SRCDIR)/main.cpp	\
	$(NULL)


DATF	= $(DATDIR)/input.dat

OBJS	= $(SRCS:.cpp=.o)

LINK	= g++

CC	= g++

CFLAGS	= -c -Wno-deprecated $(INCDIR)

LFLAGS	= -g

LDLIBS	= -lglut32 -lglu32 -lopengl32 -lgdi32 -lm -lc -ldl -lg -lutil

# -----------------------------------------------------------------------

default	:	$(EXEC)
		$(EXEC) < $(DATF)


$(EXEC)	:	$(OBJS)
		$(LINK) $(OBJS) $(LFLAGS) $(LDLIBS) -o $(EXEC)

.cpp.o	:
		$(CC) $(CFLAGS) $<

clear	:	clean
		/bin/rm -rf *.exe
		/bin/rm -rf *.exe.*
		/bin/rm -rf $(BINDIR)/*.exe

clean	:;	/bin/rm -rf *.o
		/bin/rm -rf $(BINDIR)/*.o

run	:;	$(EXEC) < $(DATF)

