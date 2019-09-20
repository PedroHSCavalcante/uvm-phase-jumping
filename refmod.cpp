#include <stdio.h>
#include <math.h>

extern "C" int my_ula(int a,int b, int instru){
	switch (instru){
		case 0:
			return a+b;
		break;
		case 1:
			if(a>b) return a-b;
			else return b-a;
		break;
		case 2:
			return a+1;
		break;
		case 3:
			return b+1;
		break;
	}
}
