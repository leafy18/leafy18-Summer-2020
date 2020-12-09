/* Q3: Applying a selection sort algorithm to sort the numbers entered in ascending order*/


#include<stdio.h>
#include<stdlib.h>
#define MAX 50											/* Maximum size of the array is defined to be 50 */
int main()
{
	int ar[MAX],num,i,j,m,t,n,next;								/* Variable declaration*/
	printf("How many numbers do u want to sort?");
	scanf("%d",&num);
	for(i=0; i< num; i++)
	{
		printf("Enter the %d  number\n",i+1);				
		scanf("%d",&ar[i]);
	}
	for(i=0; i<num-1;i++)						/* Nested loop to compare the ith element of the list to all others (from i+1)     */
	{
		m= i;
		for(j=i+1;j<num;j++)
		{
			if(ar[m] > ar[j])
				m=j;				
		}
		if(m!=i)
		{
			next= ar[i];
			ar[i]= ar[m];
			ar[m]= next;
		}
		printf("The %d intermediate list is: ",i+1);		/* prints the intermediate sorted lists*/
		for(t=0;t<num;t++)
		{
			printf("%d",ar[t]);
		}
		printf("\n");
	}
	printf("The sorted list is :");
	for(i=0;i<num;i++)
	{
		printf("%d",ar[i]);
	}
	printf("\n");
	
}
