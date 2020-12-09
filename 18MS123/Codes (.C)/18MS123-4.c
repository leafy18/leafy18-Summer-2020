/* using a binary search algorithm to search foa a number inserted by the user*/


#include <stdio.h>
//#define MAX 50


int Search(int *ar, int start, int end, int element)
{
   while (start <= end)
   {
      int middle = start + (end- start )/2;
      if (ar[middle] == element)
         return middle;
      if (ar[middle] < element)
         start = middle + 1;
      else
         end = middle - 1;
   }
   return -1;
}
int main(){
/* sorting algorithm is used to sort the elements used in the following search algorithm*/
   int element,i,j,n,found,t,next,m,k;
   //float ar[j+1];
   int ar[k+1];
   n=10;													// max elements the program take is 10
   for(k=0;k<n;k++)											// for loop to take elements from the user
   {
   		printf("Enter a number: \n");
   		scanf("%d",&ar[k]);
   }
   
   printf("Enter the element to be found:\n");				// element to be found is entered
   scanf("%d",&element);
   for(i=0; i<n-1;i++)						/* Nested loop to compare the ith element of the list to all others (from i+1)     */
	{
		m= i;
		for(j=i+1;j<n;j++)
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
		/*printf("The %d intermediate list is: ",i+1);		// prints the intermediate sorted lists
		for(t=0;t<n;t++)
		{
			printf("%f",ar[t]);
		}
		printf("\n");
		*/
	}
	printf("The sorted list is :");							// prints the sorted list
	for(i=0;i<n;i++)
	{
		printf("%d",ar[i]);
	}
	printf("\n");
   /* binary search algorithm is used */
   found = Search(ar, 0, n-1, element);
   if(found == -1 ) {											// if the found is -1 that means while loop was not executes in search function
      printf("Element not found in the array \n");
   }
   else {
      printf("Element found at index : %d\n",found);
   }
   return 0;
}