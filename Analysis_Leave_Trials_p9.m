all_patches;
%%% all leave trials together %%%%%%
leave_trials= {};
for xx= 1:length(all_patches)
    leave_trials= [leave_trials,all_patches{xx}(end)];
end
Q= [leave_trials{:}];

%%% code numbers on 4 th event %%%%%
h={};
for o= Q
    for p= 1:length(bhvmat.CodeNumbers{1,o})
        if bhvmat.CodeNumbers{1,o}(p)/4 == 1
            h=[h,p];
        end
    end
end
h_1= [h{:}];                 % indices of the 4 th events
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
c=[];
s=[];
p=[];
t=[];
stack={};
comb_f={};
comb=[];
N_1= Q;
for i_1 = N_1
    c(i_1)= max(size(bhvmat.CodeTimes{1,i_1}));
    
end
 
 m=max(c);
 for i_2= N_1
    s(i_2)= m-c(i_2);
    
 end
 

 
 for i_3 = N_1
     
     p= bhvmat.CodeTimes{1,i_3};
     t= zeros(s(i_3),1);
     comb= cat(1,p,t);
     i_3=i_3+1;
     comb_f= [comb_f,comb];
 end
 
 see= vertcat(comb_f{:});
 
 for i_4= 1:length(see)
    if see(i_4) == 0
        see(i_4)= NaN;
        
    end
 end
 see_f= fix(see);
 %%%%% corresponding values in codetimes %%%%5
 times={};
 times_9={};
 time_f={};
 for i_5= 1:length(N_1)-1
     time_1= see_f(h_1(1));
     times= [times,see_f((i_5*m)+h_1(1)+1)];
     
 end
 times_9= vertcat([times{:}]);
 time_f= [time_f,time_1,times_9];
 codetime= [time_f{:}];
  %%%%%% test_ana  %%%%%%
c=[];
s=[];
p=[];
t=[];
stack={};
comb_f={};
comb=[];
N=length(bhvmat.AnalogData);
for i = N_1
    c(i)= max(size(bhvmat.AnalogData{i}.General.Gen1));
    
end
 
 m_1=max(c);
 for i= N_1
    s(i)= m_1-c(i);
    
 end
 

 
 for i = N_1
     
     p= bhvmat.AnalogData{1,i}.General.Gen1;
     t= zeros(s(i),1);
     comb= cat(1,p,t);
     i=i+1;
     comb_f= [comb_f,comb];
 end
 
 see_1= vertcat(comb_f{:});
 
 for i= 1:length(see_1)
    if see_1(i) == 0
        see_1(i)= NaN;
        
    end
 end
%%%% leave trials smoothing %%%%
y= see_1;


N = 128;

for i=1:N
  w(i) = 0.5 - 0.5*cos(2*pi*(i-1)/N);
  
end
% subplot(2,2,3);
% plot(n,w);
y1= conv(y,w);


%plot(y1)  ;                          % smoothed plot
%%% pupil data for leave trials on event 4 %%%
p_1=codetime;
t={};
for e= 0:length(N_1)-1
    t= [t,y1(((e*m_1)+p_1(e+1))-2000:((e*m_1)+p_1(e+1))+2000)];
end
t_1= [t{:}];
t_2= t_1(:);
%%% average %%%%
t_1(isnan(t_1))= 0;
% mean of the data %%%%%
v={};
zz={};
for j= 1:1:4000
    for i= 1:length(t)
        v=[v,t_1(:,i)];
        zz=[zz,v{:,i}(j)];
    end
end
qq={};
for k= 1:length(zz)
    qq=[qq,mean(zz{:,k})];
end
ff= [qq{:}];


q={};
n= length(t);
N= length(ff(:));
p= fix(N/n)*n;

s= fix(N/n);


x = reshape(ff(1:p),n,s);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%
avg={};
for g= 1:length(x)
    avg= [avg,mean(x(:,g))];
end
average=[avg{:}];
%plot(average)
%%%%%%%%%%%%%%%%%%%%%%%%%
box=[];
trial_13= t_1(:,13);
l=[];
thres= input('enter you threshold (13):');  
p=  find(trial_13< thres);               % enter threshold according to the velocity profile

s= length(p);

for i= 1:s
    box= p(i)-90:p(i)+100;              % identification of blink
    
    
    for j= 1:length(trial_13)
        for j= box
            trial_13(j)= NaN;
        end
    end
    i=i+1;
end

hold on 
trial= trial_13;
t_3= isnan(trial);
p= find(t_3==1);
q= find(t_3==0);
z_f={};
z={};
for i= 1:length(t_3)-1
    if t_3(i)+t_3(i+1)== 1
        z= [z,i];
        i=i+1;
    end
end
for j= 1:length(z)
    z{1,j}= z{1,j}+1;
    j=j+1;
end
w= [z{:}];
c=1:2:length(w)-1;
t2_f={};
t3_f={};
t1_f={};
t4_f={};
xx={};
u={};
for k= c(1:length(c))
    t2= w(k)-1;    % blink onset
    t3= w(k+1);   % blink offset
    t1= t2-5;       % (t1,t4) points to generate a spline 
    t4= t3+5;       
    xx= [t1,t2,t3,t4];
    yy= trial(xx);
    pp= linspace(t2,t3,(t3-t2));
    u=[u,spline(xx,yy,pp)];
    
end
u_1=[u{:}];
hold on 
avg={};


for i= c(1:length(c))
    avg= [avg,average(w(i):w(i+1))];
end
for k= 1:length(c)
    [avg{:,k}]= u{:,k};
end
trial(w(1):w(2))= [avg{:,1}];
plot(trial)
%%%%%%%%%%%%%%%%%%%%%%%%
box=[];

l=[];
thres= input('enter you threshold:');  
p=  find(t_1< thres);               % enter threshold according to the velocity profile

s= length(p);

for i= 1:s
    box= p(i)-90:p(i)+100;              % identification of blink
    
    
    for j= 1:length(t_1)
        for j= box
            t_1(j)= NaN;
        end
    end
    i=i+1;
end

%plot(t_1)                           % blink removed  data

%%% blink removal for avg %%%%
box=[];

l=[];
thres= input('enter you threshold:');  
p=  find(average< thres);               % enter threshold according to the velocity profile

s= length(p);

for i= 1:s
    box= p(i)-90:p(i)+100;              % identification of blink
    
    
    for j= 1:length(average)
        for j= box
            average(j)= NaN;
        end
    end
    i=i+1;
end
plot(average)
hold on
%%% blink reconstruction for average %%%
t_3= isnan(average);
p= find(t_3==1);
q= find(t_3==0);
z_f={};
z={};
for i= 1:length(t_3)-1
    if t_3(i)+t_3(i+1)== 1
        z= [z,i];
        i=i+1;
    end
end
for j= 1:length(z)
    z{1,j}= z{1,j}+1;
    j=j+1;
end
w= [z{:}];
c=1:2:length(w)-1;
t2_f={};
t3_f={};
t1_f={};
t4_f={};
xx={};
u={};
for k= c(1:length(c))
    t2= w(k)-1;    % blink onset
    t3= w(k+1);   % blink offset
    t1= t2-5;       % (t1,t4) points to generate a spline 
    t4= t3+5;       
    xx= [t1,t2,t3,t4];
    yy= average(xx);
    pp= linspace(t2,t3,(t3-t2));
    u=[u,spline(xx,yy,pp)];
    
end
u_1=[u{:}];
hold on 
avg={};
plot(average)

for i= c(1:length(c))
    avg= [avg,average(w(i):w(i+1))];
end
for k= 1:length(c)
    [avg{:,k}]= u{:,k};
end

average(w(1):w(2))= [avg{:,1}];
average(w(3):w(4))= [avg{:,2}];
plot(average,'Linewidth',2)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
hold on
trial= t_1(:,1);
t_3= isnan(trial);
p= find(t_3==1);
q= find(t_3==0);
z_f={};
z={};
for i= 1:length(t_3)-1
    if t_3(i)+t_3(i+1)== 1
        z= [z,i];
        i=i+1;
    end
end
for j= 1:length(z)
    z{1,j}= z{1,j}+1;
    j=j+1;
end
w= [z{:}];
c=1:2:length(w)-1;
t2_f={};
t3_f={};
t1_f={};
t4_f={};
xx={};
u={};
for k= c(1:length(c))
    t2= w(k)-1;    % blink onset
    t3= w(k+1);   % blink offset
    t1= t2-5;       % (t1,t4) points to generate a spline 
    t4= t3+5;       
    xx= [t1,t2,t3,t4];
    yy= trial(xx);
    pp= linspace(t2,t3,(t3-t2));
    u=[u,spline(xx,yy,pp)];
    
end
u_1=[u{:}];
hold on 
avg={};


for i= c(1:length(c))
    avg= [avg,average(w(i):w(i+1))];
end
for k= 1:length(c)
    [avg{:,k}]= u{:,k};
end
trial(w(1):w(2))= [avg{:,1}];
trial(w(3):w(4))= [avg{:,2}];
plot(trial)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
hold on
trial= t_1(:,2);
plot(trial)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
hold on 
trial= t_1(:,3);
t_3= isnan(trial);
p= find(t_3==1);
q= find(t_3==0);
z_f={};
z={};
for i= 1:length(t_3)-1
    if t_3(i)+t_3(i+1)== 1
        z= [z,i];
        i=i+1;
    end
end
for j= 1:length(z)
    z{1,j}= z{1,j}+1;
    j=j+1;
end
w= [z{:}];
c=2:2:length(w)-1;
t2_f={};
t3_f={};
t1_f={};
t4_f={};
xx={};
u={};
for k= c(1:length(c))
    t2= w(k)-1;    % blink onset
    t3= w(k+1);   % blink offset
    t1= t2-5;       % (t1,t4) points to generate a spline 
    t4= t3+5;       
    xx= [t1,t2,t3,t4];
    yy= trial(xx);
    pp= linspace(t2,t3,(t3-t2));
    u=[u,spline(xx,yy,pp)];
    
end
u_1=[u{:}];
hold on 
avg={};


for i= c(1:length(c))
    avg= [avg,average(w(i):w(i+1))];
end
for k= 1:length(c)
    [avg{:,k}]= u{:,k};
end
trial(w(2):w(3))= [avg{:,1}];
plot(trial)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
hold on
trial= t_1(:,4);
t_3= isnan(trial);
p= find(t_3==1);
q= find(t_3==0);
z_f={};
z={};
for i= 1:length(t_3)-1
    if t_3(i)+t_3(i+1)== 1
        z= [z,i];
        i=i+1;
    end
end
for j= 1:length(z)
    z{1,j}= z{1,j}+1;
    j=j+1;
end
w= [z{:}];
c=2:2:length(w)-1;
t2_f={};
t3_f={};
t1_f={};
t4_f={};
xx={};
u={};
for k= c(1:length(c))
    t2= w(k)-1;    % blink onset
    t3= w(k+1);   % blink offset
    t1= t2-5;       % (t1,t4) points to generate a spline 
    t4= t3+5;       
    xx= [t1,t2,t3,t4];
    yy= trial(xx);
    pp= linspace(t2,t3,(t3-t2));
    u=[u,spline(xx,yy,pp)];
    
end
u_1=[u{:}];
hold on 
avg={};


for i= c(1:length(c))
    avg= [avg,average(w(i):w(i+1))];
end
for k= 1:length(c)
    [avg{:,k}]= u{:,k};
end
trial(w(2):w(3))= [avg{:,1}];
trial(w(4):w(5))= [avg{:,2}];
plot(trial)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
hold on
trial= t_1(:,5);
plot(trial)
%%%%%%%%%%%%%%%%%%%%%%%%%
trial= t_1(:,6);
t_3= isnan(trial);
p= find(t_3==1);
q= find(t_3==0);
z_f={};
z={};
for i= 1:length(t_3)-1
    if t_3(i)+t_3(i+1)== 1
        z= [z,i];
        i=i+1;
    end
end
for j= 1:length(z)
    z{1,j}= z{1,j}+1;
    j=j+1;
end
w= [z{:}];
c=2:2:length(w)-1;
t2_f={};
t3_f={};
t1_f={};
t4_f={};
xx={};
u={};
for k= c(1:length(c))
    t2= w(k)-1;    % blink onset
    t3= w(k+1);   % blink offset
    t1= t2-5;       % (t1,t4) points to generate a spline 
    t4= t3+5;       
    xx= [t1,t2,t3,t4];
    yy= trial(xx);
    pp= linspace(t2,t3,(t3-t2));
    u=[u,spline(xx,yy,pp)];
    
end
u_1=[u{:}];
hold on 
avg={};


for i= c(1:length(c))
    avg= [avg,average(w(i):w(i+1))];
end
for k= 1:length(c)
    [avg{:,k}]= u{:,k};
end
trial(w(2):w(3))= [avg{:,1}];
trial(w(4):w(5))= [avg{:,2}];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
hold on
trial= t_1(:,7);
plot(trial)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
hold on
trial= t_1(:,8);
t_3= isnan(trial);
p= find(t_3==1);
q= find(t_3==0);
z_f={};
z={};
for i= 1:length(t_3)-1
    if t_3(i)+t_3(i+1)== 1
        z= [z,i];
        i=i+1;
    end
end
for j= 1:length(z)
    z{1,j}= z{1,j}+1;
    j=j+1;
end
w= [z{:}];
c=2:2:length(w)-1;
t2_f={};
t3_f={};
t1_f={};
t4_f={};
xx={};
u={};
for k= c(1:length(c))
    t2= w(k)-1;    % blink onset
    t3= w(k+1);   % blink offset
    t1= t2-5;       % (t1,t4) points to generate a spline 
    t4= t3+5;       
    xx= [t1,t2,t3,t4];
    yy= trial(xx);
    pp= linspace(t2,t3,(t3-t2));
    u=[u,spline(xx,yy,pp)];
    
end
u_1=[u{:}];
hold on 
avg={};


for i= c(1:length(c))
    avg= [avg,average(w(i):w(i+1))];
end
for k= 1:length(c)
    [avg{:,k}]= u{:,k};
end
trial(w(2):w(3))= [avg{:,1}];

plot(trial)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
hold on
trial= t_1(:,9);
t_3= isnan(trial);
p= find(t_3==1);
q= find(t_3==0);
z_f={};
z={};
for i= 1:length(t_3)-1
    if t_3(i)+t_3(i+1)== 1
        z= [z,i];
        i=i+1;
    end
end
for j= 1:length(z)
    z{1,j}= z{1,j}+1;
    j=j+1;
end
w= [z{:}];
c=1:2:length(w)-1;
t2_f={};
t3_f={};
t1_f={};
t4_f={};
xx={};
u={};
for k= c(1:length(c))
    t2= w(k)-1;    % blink onset
    t3= w(k+1);   % blink offset
    t1= t2-5;       % (t1,t4) points to generate a spline 
    t4= t3+5;       
    xx= [t1,t2,t3,t4];
    yy= trial(xx);
    pp= linspace(t2,t3,(t3-t2));
    u=[u,spline(xx,yy,pp)];
    
end
u_1=[u{:}];
hold on 
avg={};


for i= c(1:length(c))
    avg= [avg,average(w(i):w(i+1))];
end
for k= 1:length(c)
    [avg{:,k}]= u{:,k};
end
trial(w(1):w(2))= [avg{:,1}];
plot(trial)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
hold on
trial= t_1(:,10);
t_3= isnan(trial);
p= find(t_3==1);
q= find(t_3==0);
z_f={};
z={};
for i= 1:length(t_3)-1
    if t_3(i)+t_3(i+1)== 1
        z= [z,i];
        i=i+1;
    end
end
for j= 1:length(z)
    z{1,j}= z{1,j}+1;
    j=j+1;
end
w= [z{:}];
c=2:2:length(w)-1;
t2_f={};
t3_f={};
t1_f={};
t4_f={};
xx={};
u={};
for k= c(1:length(c))
    t2= w(k)-1;    % blink onset
    t3= w(k+1);   % blink offset
    t1= t2-5;       % (t1,t4) points to generate a spline 
    t4= t3+5;       
    xx= [t1,t2,t3,t4];
    yy= trial(xx);
    pp= linspace(t2,t3,(t3-t2));
    u=[u,spline(xx,yy,pp)];
    
end
u_1=[u{:}];
hold on 
avg={};


for i= c(1:length(c))
    avg= [avg,average(w(i):w(i+1))];
end
for k= 1:length(c)
    [avg{:,k}]= u{:,k};
end
trial(w(2):w(3))= [avg{:,1}];
plot(trial)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
hold on

trial= t_1(:,11);
plot(trial)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
hold on
trial= t_1(:,12);
t_3= isnan(trial);
p= find(t_3==1);
q= find(t_3==0);
z_f={};
z={};
for i= 1:length(t_3)-1
    if t_3(i)+t_3(i+1)== 1
        z= [z,i];
        i=i+1;
    end
end
for j= 1:length(z)
    z{1,j}= z{1,j}+1;
    j=j+1;
end
w= [z{:}];
c=2:2:length(w)-1;
t2_f={};
t3_f={};
t1_f={};
t4_f={};
xx={};
u={};
for k= c(1:length(c))
    t2= w(k)-1;    % blink onset
    t3= w(k+1);   % blink offset
    t1= t2-5;       % (t1,t4) points to generate a spline 
    t4= t3+5;       
    xx= [t1,t2,t3,t4];
    yy= trial(xx);
    pp= linspace(t2,t3,(t3-t2));
    u=[u,spline(xx,yy,pp)];
    
end
u_1=[u{:}];
hold on 
avg={};


for i= c(1:length(c))
    avg= [avg,average(w(i):w(i+1))];
end
for k= 1:length(c)
    [avg{:,k}]= u{:,k};
end
trial(w(2):w(3))= [avg{:,1}];
trial(w(4):w(5))= [avg{:,2}];
plot(trial)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
hold on
trial= t_1(:,14);
t_3= isnan(trial);
p= find(t_3==1);
q= find(t_3==0);
z_f={};
z={};
for i= 1:length(t_3)-1
    if t_3(i)+t_3(i+1)== 1
        z= [z,i];
        i=i+1;
    end
end
for j= 1:length(z)
    z{1,j}= z{1,j}+1;
    j=j+1;
end
w= [z{:}];
c=2:2:length(w)-1;
t2_f={};
t3_f={};
t1_f={};
t4_f={};
xx={};
u={};
for k= c(1:length(c))
    t2= w(k)-1;    % blink onset
    t3= w(k+1);   % blink offset
    t1= t2-5;       % (t1,t4) points to generate a spline 
    t4= t3+5;       
    xx= [t1,t2,t3,t4];
    yy= trial(xx);
    pp= linspace(t2,t3,(t3-t2));
    u=[u,spline(xx,yy,pp)];
    
end
u_1=[u{:}];
hold on 
avg={};


for i= c(1:length(c))
    avg= [avg,average(w(i):w(i+1))];
end
for k= 1:length(c)
    [avg{:,k}]= u{:,k};
end
trial(w(2):w(3))= [avg{:,1}];
plot(trial)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
hold on
trial= t_1(:,15);
t_3= isnan(trial);
p= find(t_3==1);
q= find(t_3==0);
z_f={};
z={};
for i= 1:length(t_3)-1
    if t_3(i)+t_3(i+1)== 1
        z= [z,i];
        i=i+1;
    end
end
for j= 1:length(z)
    z{1,j}= z{1,j}+1;
    j=j+1;
end
w= [z{:}];
c=1:2:length(w)-1;
t2_f={};
t3_f={};
t1_f={};
t4_f={};
xx={};
u={};
for k= c(1:length(c))
    t2= w(k)-1;    % blink onset
    t3= w(k+1);   % blink offset
    t1= t2-5;       % (t1,t4) points to generate a spline 
    t4= t3+5;       
    xx= [t1,t2,t3,t4];
    yy= trial(xx);
    pp= linspace(t2,t3,(t3-t2));
    u=[u,spline(xx,yy,pp)];
    
end
u_1=[u{:}];
hold on 
avg={};


for i= c(1:length(c))
    avg= [avg,average(w(i):w(i+1))];
end
for k= 1:length(c)
    [avg{:,k}]= u{:,k};
end
trial(w(1):w(2))= [avg{:,1}];
trial(w(3):w(4))= [avg{:,2}];
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
hold on
trial= t_1(:,16);
t_3= isnan(trial);
p= find(t_3==1);
q= find(t_3==0);
z_f={};
z={};
for i= 1:length(t_3)-1
    if t_3(i)+t_3(i+1)== 1
        z= [z,i];
        i=i+1;
    end
end
for j= 1:length(z)
    z{1,j}= z{1,j}+1;
    j=j+1;
end
w= [z{:}];
c=1:2:length(w)-1;
t2_f={};
t3_f={};
t1_f={};
t4_f={};
xx={};
u={};
for k= c(1:length(c))
    t2= w(k)-1;    % blink onset
    t3= w(k+1);   % blink offset
    t1= t2-5;       % (t1,t4) points to generate a spline 
    t4= t3+5;       
    xx= [t1,t2,t3,t4];
    yy= trial(xx);
    pp= linspace(t2,t3,(t3-t2));
    u=[u,spline(xx,yy,pp)];
    
end
u_1=[u{:}];
hold on 
avg={};


for i= c(1:length(c))
    avg= [avg,average(w(i):w(i+1))];
end
for k= 1:length(c)
    [avg{:,k}]= u{:,k};
end
trial(w(1):w(2))= [avg{:,1}];
trial(w(3):w(4))= [avg{:,2}];
trial(w(5):w(6))= [avg{:,3}];
plot(trial)
title('Leave Trial')
%%%%%%%%%%%%%%%%% xx             xx %%%%%%%%%%%%%%%%%%%

