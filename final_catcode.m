c=[];
s=[];
p=[];
t=[];
stack={};
comb_f={};
comb=[];
N=length(bhvmat.AnalogData);
for i = 1:N
    c(i)= max(size(bhvmat.AnalogData{i}.General.Gen1));
    
end
 
 m=max(c);
 for i= 1:N
    s(i)= m-c(i);
    
 end
 

 
 for i = 1:N
     
     p= bhvmat.AnalogData{1,i}.General.Gen1;
     t= zeros(s(i),1);
     comb= cat(1,p,t);
     i=i+1;
     comb_f= [comb_f,comb];
 end
 
 see= vertcat(comb_f{:});
 
 for i= 1:length(see)
    if see(i) == 0
        see(i)= NaN;
        
    end
 end
