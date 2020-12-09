/*Program of priority 
queue to execute the most 
eligible process*/



#include<stdio.h>
#include<stdlib.h>								// calling libraries

#define MAX 10									// A max value is defined

typedef struct node								// a struct is defined to store the value and priority associated with it  
{
	int priority;
	int time;
	
}NODE;

int insert(int data, int data_priority);					// functions are declared: insert functions takes two arguments 
int delete();
int display();
int rear=-1;												// rear and front variables are assigned to -1 initially (at the starting of the queue)
int front=-1;

NODE queue[MAX];

int main()
{
	int choice,data,data_priority, i;
	while(1)													// switch is used to run through options
	{
		printf("1.Insert\n");
		printf("2.Delete\n");
		printf("3.Display\n");
		printf("4.Quit\n");
		printf("Enter your choice : ");
		scanf("%d", &choice);

		switch(choice)											// switches between the main menu
		{
		 case 1:
			insert(data, data_priority);
			break;
		 case 2:
			printf("Deleted time is %d\n",delete());						
			break;
		 case 3:
			display();
			break;
		 case 4:
			exit(1);
		 default :
			printf("Wrong choice\n");
		}

	}
}

int insert(int data, int data_priority)										
{
	printf("Input the time taken : ");			// data value and associated priority is taken up
	scanf("%d",&data);
	printf("Enter its priority : ");
	scanf("%d",&data_priority);
	
    int i, j;

	if( rear== MAX-1 )												// to check if the queue is full
	{
		printf("Queue Overflow\n");
		return 0;
	}

    if( front == -1 )  											
		front = 0;
	
	
	if((front==-1&& rear== -1) || data_priority < queue[front].priority) 	/*Lower priority value means higher priority
															if the queue is empty or the priority associated with the inserted 
															data is lower that the pre-existing data *If loop runs* */
	{														
		for(i = rear ; i >= front ; i--)
        {
            queue[i + 1] = queue[i];
        }

         queue[front].time = data;
         queue[front].priority = data_priority;

         rear = rear + 1;
	}
	else 													/* if the queue is not empty and the inserted data has a priority value higher
																than the previous numbers.    */
	{
        i = front;
		
		while(i <= rear)
        {
            if(data_priority <= queue[i].priority && data <= queue[i].time)			//lower priority element found aswell as the element taking least time is also found
            {
                break;        
            }
			i++;
        }   
		
        if(i > rear)										//lower priority element not found (insertion to be done at end)
        {
            rear = i;
        }
        else												//lower priority element found (insert before that element)
        {
            for(j = rear ; j >= i ; j--)
            {
                queue[j + 1] = queue[j];
            }
             
            rear++;
        }

        queue[i].time = data;								// data and priorities are stored
        queue[i].priority = data_priority;
        
	}

    display();												// the inserted time and priorities are seen after every insertion
    return 0;
}
int delete()												// function to delete an item
{
	
	int data;
	if(front == -1 && rear== -1) 							// criteria involves when the front and rear are still on initial values
	{
		printf("Queue Underflow\n");
		exit(1);
	}
	else
	{
		data = queue[front].time;							// deletes from the front and the front gets updated by the next value
        front++;
	}
	return data;
}
int display()												// function to display the values inserted
{
	int  i = front;
	if( front== -1&& rear == -1 )
		printf("Queue is empty\n");
	else
	{	printf("Queue is :\n");								// when the queue is not empty and the element index is less than or equal to the rear
		printf("Time       Priority\n");
		while(i <= rear)
		{
			printf("%5d        %5d\n", queue[i].time, queue[i].priority);			// prints the priority and time 
			i++;
		}
	}
	return 0;
}