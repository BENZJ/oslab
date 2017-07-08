#include "strncmp.h"
#include <stdio.h>
int main (void){
	char a[100] , b[100];
	printf("input string a:");
	scanf("%s",a);
	printf("input string b:");
	scanf("%s",b);
	int res = strncmp(a,b,2);
	//printf("%d\n",res);
	if(res<0)
		printf("a<b\n");
	else if(res ==0 )
		printf("a=b\n");
	else
		printf("a>b\n");
	return 0;
}
