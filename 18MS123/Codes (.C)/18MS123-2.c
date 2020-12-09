/* Q2: To find the arithmetic and geometric mean of numbers inserted by the user*/


#include <stdio.h>
#include<math.h>

float sum(float* ar, int n)					// array is taken as a pointer 
{
    if(n <= 0)
        return ar[0];
    else
    	return ar[n] + sum(ar, n -1);			// recursion is implemented on sum  function 

}
float product(float* ar, int n)
{
    if(n <= 0)
        return ar[0];
    else
    	return ar[n] * product(ar, n-1);		// recursion is implemented on product fucntion
}


int main() 
{
   int n,i;
   float ar[]={1,2,3,4,5,6,7,8,9,10};			// array is pre defined
   /*printf("Enter the size of array: ");
   scanf("%d",&n);
   printf("Enter the elements:\n");
   for(i=0;i<n;i++)
   {
   		scanf("%f",&ar[i]);
   }*/
   n= sizeof(ar)/sizeof(ar[0]);
   //printf("%f\n",ar[n-1]);
   printf("Arithmetic mean of the numbers is %f\n", sum(ar,n-1)/n);
   printf("Geometric mean of the numbers is  %f\n",pow(product(ar,n-1),(1.0/n)));
   
}

