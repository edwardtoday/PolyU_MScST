#include <stdio.h>
#include <stdlib.h>

#include "iterateB.h"

void iterateA(int n);

void iterateA(int n)
{
     int  j = 0;
     for (j = 0; j < n; j++)
	{
		printf("iterateA j = %d\n", j);
	}   
     printf("\n");
     iterateB(5);
}
