t= isnan(y1);
p= find(t==1);
q= find(t==0);
z_f={};
z={};
for i= 1:length(t)-1
    if t(i)+t(i+1)== 1
        z= [z,i];
        i=i+1;
    end
end
for j= 1:length(z)
    z{1,j}= z{1,j}+1;
    j=j+1;
end
w= [z{:}];
c=1:2:length(w);
t2_f={};
t3_f={};
xx={};
for k= c
    t2= w(k)-1;    % blink onset
    t3= w(k+1);   % blink offset
    t1= t2-5;       % (t1,t4) points to generate a spline 
    t4= t3+5;       
    xx= [t1,t2,t3,t4];
    yy= y1(xx);
    pp= linspace(t2,t3,(t3-t2));
    spline(xx,yy,pp);
    plot(pp,csapi(xx,yy,pp))
end


    
    










