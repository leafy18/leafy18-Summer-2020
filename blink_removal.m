%%%%%%%%%%% blink removal%%%%%
box=[];

l=[];
thres= input('enter you threshold:');  
p=  find(y1< thres);               % enter threshold according to the velocity profile

s= length(p);

for i= 1:s
    t= p(i)-90:p(i)+100;              % identification of blink
    box= t;
    
    for j= 1:length(y1)
        for j= box
            y1(j)= NaN;
        end
    end
    i=i+1;
end

plot(y1)


