#include <stdio.h>
#include <stdlib.h>

#include "iterateA.h"

int  main(int argc, char **argv)
{
     int i = 0;
     int n = 10;

     for (i = 0; i < n; i++)
	{
		printf("main: i = %d\n", i);
	}   

     printf("\n");

     iterateA(n);

     exit(0);
}

