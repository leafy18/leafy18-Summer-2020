v_f={};
v_prof=[];


T= a;
for i= 1:length(T)-1
    dx= (T(i+1)-T(i))*100;
    i=i+1;
    v_f=[v_f,dx];
end

v_prof=vertcat(v_f{:});



plot(v_prof)


title('velocity profile')
%line([0, 100000], [100, 100], 'Color', [1,0,0]);
