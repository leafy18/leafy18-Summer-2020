ss= {bhvmat.UserVars.rwrd};
s_1=[ss{:}];                % reward values in stay trials( leave trials have 0 values)
d=find(cellfun(@isempty,ss));  
vv= find(~cellfun(@isempty,ss)); 
patch={};
patch_1={};
for j= 1:length(vv)-1
    if vv(j+1)-vv(j)~= 1
        patch=[patch,vv(j)];
        patch_1=[patch_1,vv(j+1)];
    end
end
pp=[patch{:}];
pp_1=[patch_1{:}];
next={};
all_patches={};
for i= 1:length(pp)-1
    patch1= 1:pp(1)+1;
    next= [next,pp_1(i):pp(i+1)+1];
    last= pp_1(length(pp_1)):length(ss);
end
all_patches= [all_patches,patch1,next,last];

     