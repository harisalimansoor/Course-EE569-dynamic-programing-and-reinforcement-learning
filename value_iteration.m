clear all;
clc;

%%
flag_errbnds = true;
MAX_ITER = 1000;
ERR_TOL = 1e-6;

etta=0.95;
g = [etta-1 0; etta 0];
P = zeros(2,2,2);
P(:,:,1) = [0.3 0.7; 0.5 0.5];
P(:,:,2) = [0.8 0.2; 0.95 0.05];
alpha = 0.95;
costJ = [0,0];
costJnew = [0,0];
policy = [0,0];
doBreak = false;
for k=1:MAX_ITER

 for i=1:2 
 [costJnew(i),policy(i)] = max( g(i,:) + alpha*costJ*squeeze(P(i,:,:)) );
 end;

 res_J(k,:) = costJnew;
 dispstr = ['k=',num2str(k,'%5d'), ...
 ' J(1)=',num2str(costJnew(1),'%6.4f'), ...
 ' J(2)=',num2str(costJnew(2),'%6.4f'), ...
 ' mu(1)=',num2str(policy(1),'%3d'), ...
 ' mu(2)=',num2str(policy(2),'%3d')];

 if flag_errbnds

 lower = costJnew + alpha/(1-alpha)*min(costJnew-costJ); 
 upper = costJnew + alpha/(1-alpha)*max(costJnew-costJ); 

 
 dispstr = [dispstr,' lower=[',num2str(lower,'%9.4f'), ...
 '] upper=[',num2str(upper,'%9.4f'),']'];

 if all((upper-lower)<=ERR_TOL)
 costJnew = mean([lower; upper],1);

 dispstr = [dispstr, ...
 sprintf('\nResult within desired tolerance. Terminate.\n')];
 doBreak = true;
 end;

 res_lower(k,:) = lower;
 res_upper(k,:) = upper;
 end;


 costJ = costJnew;


 disp(dispstr);

 if doBreak
 break;
 end;
end;
disp('Result:');
disp([' J*(1) = ',num2str(costJ(1),'%9.6f')]);
disp([' J*(2) = ',num2str(costJ(2),'%9.6f')]);
disp([' mu*(1) = ',num2str(policy(1))]);
disp([' mu*(2) = ',num2str(policy(2))]);
kk = 1:size(res_J,1);
figure;
subplot(2,1,1);
if(flag_errbnds)
 plot(kk,[res_J(:,1),res_lower(:,1), res_upper(:,1)], ...
 [kk(1),kk(end)],[costJ(1), costJ(1)],'k');
else
 plot(kk,[res_J(:,1)],[kk(1),kk(end)],[costJ(1), costJ(1)],'k');
end;
grid;
subplot(2,1,2);
if(flag_errbnds)
 plot(kk,[res_J(:,2),res_lower(:,2), res_upper(:,2)], ...
 [kk(1),kk(end)],[costJ(2),costJ(2)],'k');
else
 plot(kk,[res_J(:,2)],[kk(1),kk(end)],[costJ(2), costJ(2)],'k');
end;
grid;
if(flag_errbnds)
 legend('J_k','lower bound','upper bound','J*');
else
 legend('J_k','J*');
end;
xlabel('iteration');

%%

flag_errbnds = true;
MAX_ITER = 1000;
ERR_TOL = 1e-6;

etta=0.5;
g = [etta-1 0; etta 0];
P = zeros(2,2,2);
P(:,:,1) = [0.3 0.7; 0.5 0.5];
P(:,:,2) = [0.8 0.2; 0.95 0.05];
alpha = 0.95;
costJ = [0,0];
costJnew = [0,0];
policy = [0,0];
doBreak = false;
for k=1:MAX_ITER

 for i=1:2 
 [costJnew(i),policy(i)] = max( g(i,:) + alpha*costJ*squeeze(P(i,:,:)) );
 end;

 res_J(k,:) = costJnew;
 dispstr = ['k=',num2str(k,'%5d'), ...
 ' J(1)=',num2str(costJnew(1),'%6.4f'), ...
 ' J(2)=',num2str(costJnew(2),'%6.4f'), ...
 ' mu(1)=',num2str(policy(1),'%3d'), ...
 ' mu(2)=',num2str(policy(2),'%3d')];

 if flag_errbnds

 lower = costJnew + alpha/(1-alpha)*min(costJnew-costJ); 
 upper = costJnew + alpha/(1-alpha)*max(costJnew-costJ); 

 
 dispstr = [dispstr,' lower=[',num2str(lower,'%9.4f'), ...
 '] upper=[',num2str(upper,'%9.4f'),']'];

 if all((upper-lower)<=ERR_TOL)
 costJnew = mean([lower; upper],1);

 dispstr = [dispstr, ...
 sprintf('\nResult within desired tolerance. Terminate.\n')];
 doBreak = true;
 end;

 res_lower(k,:) = lower;
 res_upper(k,:) = upper;
 end;


 costJ = costJnew;


 disp(dispstr);

 if doBreak
 break;
 end;
end;
disp('Result:');
disp([' J*(1) = ',num2str(costJ(1),'%9.6f')]);
disp([' J*(2) = ',num2str(costJ(2),'%9.6f')]);
disp([' mu*(1) = ',num2str(policy(1))]);
disp([' mu*(2) = ',num2str(policy(2))]);
kk = 1:size(res_J,1);
figure;
subplot(2,1,1);
if(flag_errbnds)
 plot(kk,[res_J(:,1),res_lower(:,1), res_upper(:,1)], ...
 [kk(1),kk(end)],[costJ(1), costJ(1)],'k');
else
 plot(kk,[res_J(:,1)],[kk(1),kk(end)],[costJ(1), costJ(1)],'k');
end;
grid;
subplot(2,1,2);
if(flag_errbnds)
 plot(kk,[res_J(:,2),res_lower(:,2), res_upper(:,2)], ...
 [kk(1),kk(end)],[costJ(2),costJ(2)],'k');
else
 plot(kk,[res_J(:,2)],[kk(1),kk(end)],[costJ(2), costJ(2)],'k');
end;
grid;
if(flag_errbnds)
 legend('J_k','lower bound','upper bound','J*');
else
 legend('J_k','J*');
end;
xlabel('iteration');

%%

flag_errbnds = true;
MAX_ITER = 1000;
ERR_TOL = 1e-6;

etta=0.05;
g = [etta-1 0; etta 0];
P = zeros(2,2,2);
P(:,:,1) = [0.3 0.7; 0.5 0.5];
P(:,:,2) = [0.8 0.2; 0.95 0.05];
alpha = 0.95;
costJ = [0,0];
costJnew = [0,0];
policy = [0,0];
doBreak = false;
for k=1:MAX_ITER

 for i=1:2 
 [costJnew(i),policy(i)] = max( g(i,:) + alpha*costJ*squeeze(P(i,:,:)) );
 end;

 res_J(k,:) = costJnew;
 dispstr = ['k=',num2str(k,'%5d'), ...
 ' J(1)=',num2str(costJnew(1),'%6.4f'), ...
 ' J(2)=',num2str(costJnew(2),'%6.4f'), ...
 ' mu(1)=',num2str(policy(1),'%3d'), ...
 ' mu(2)=',num2str(policy(2),'%3d')];

 if flag_errbnds

 lower = costJnew + alpha/(1-alpha)*min(costJnew-costJ); 
 upper = costJnew + alpha/(1-alpha)*max(costJnew-costJ); 

 
 dispstr = [dispstr,' lower=[',num2str(lower,'%9.4f'), ...
 '] upper=[',num2str(upper,'%9.4f'),']'];

 if all((upper-lower)<=ERR_TOL)
 costJnew = mean([lower; upper],1);

 dispstr = [dispstr, ...
 sprintf('\nResult within desired tolerance. Terminate.\n')];
 doBreak = true;
 end;

 res_lower(k,:) = lower;
 res_upper(k,:) = upper;
 end;


 costJ = costJnew;


 disp(dispstr);

 if doBreak
 break;
 end;
end;
disp('Result:');
disp([' J*(1) = ',num2str(costJ(1),'%9.6f')]);
disp([' J*(2) = ',num2str(costJ(2),'%9.6f')]);
disp([' mu*(1) = ',num2str(policy(1))]);
disp([' mu*(2) = ',num2str(policy(2))]);
kk = 1:size(res_J,1);
figure;
subplot(2,1,1);
if(flag_errbnds)
 plot(kk,[res_J(:,1),res_lower(:,1), res_upper(:,1)], ...
 [kk(1),kk(end)],[costJ(1), costJ(1)],'k');
else
 plot(kk,[res_J(:,1)],[kk(1),kk(end)],[costJ(1), costJ(1)],'k');
end;
grid;
subplot(2,1,2);
if(flag_errbnds)
 plot(kk,[res_J(:,2),res_lower(:,2), res_upper(:,2)], ...
 [kk(1),kk(end)],[costJ(2),costJ(2)],'k');
else
 plot(kk,[res_J(:,2)],[kk(1),kk(end)],[costJ(2), costJ(2)],'k');
end;
grid;
if(flag_errbnds)
 legend('J_k','lower bound','upper bound','J*');
else
 legend('J_k','J*');
end;
xlabel('iteration');


