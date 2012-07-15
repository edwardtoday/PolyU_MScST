#include <stdio.h>
#include <stdlib.h>

void iterateB(int n);

void iterateB(int n)
{
     int  k = 0;
     for (k = 0; k < n; k++)
	{
		printf("iterateB k = %d\n", k);
	}   
}
