clear all;
clc;
p(2) = 0.95;
q(1) = 0.6; 
q(2) = 0.4;
err = 1e-100;
test =1;
if test ==1
    p(1) = 0.2;
    mend = 1;
else
    incr = 0.01;
mend = ((0.95-incr)/incr+2);
end
for m=1:mend 
    if test == 2
        p(1) = (m-1)*incr; 
        end
J = (p(1)+0.1).*ones(4, 4, 2);
FVal = ones(4, 4, 2);
costToGo = zeros(4, 4, 2);

 iter = 0;
 while (1)
 iter = iter+1;
 if (mod(iter,1e3)==0)
 disp(['Value Iteration Number ',num2str(iter)]);
 end
 for i = 1:3
 [costToGo(4,i,1),FVal(4,i,1)] = max(q.*p + (1-q).*p.*J(4,i+1,1)+(1-p).*J(4,i,2));
 [costToGo(4,i,2),FVal(4,i,2)] = max(q.*p + (1-q.*p).*J(4,i+1,1));
 [costToGo(i,4,1),FVal(i,4,1)] = max(q.*p.*J(i+1,4,1) + (1-p).*J(i,4,2));
 [costToGo(i,4,2),FVal(i,4,2)] = max(q.*p.*J(i+1,4,1));
 for j = 1:3

 [costToGo(i,j,1),FVal(i,j,1)] = max(q.*p.*J(i+1,j,1) + (1-q).*p.*J(i,j+1,1)+(1-p).*J(i,j,2));
 [costToGo(i,j,2),FVal(i,j,2)] = max(q.*p.*J(i+1,j,1) + (1-q.*p).*J(i,j+1,1));
 end
 end
 [costToGo(4,4,1),FVal(4,4,1)] = max(q.*p.*J(4,3,1) + (1-q).*p.*J(3,4,1)+(1-p).*J(4,4,2));
 [costToGo(4,4,2),FVal(4,4,2)] = max(q.*p.*J(4,3,1) + (1-q.*p).*J(3,4,1));
 
 if (max(max(max(J-costToGo)))/max(max(max(costToGo))) < err)
 
 J = costToGo;
 break;
 else
 J = costToGo;
 end
 end
 
 JValsave(m)=J(1, 1, 1);
end;
for m=1:mend
 if test == 2
 p(1) = (m-1)*incr; 
 end
 FPol = 2.*ones(32,1);
 iter = 0;
 while (1)
 iter = iter+1;
 disp(['Policy Iteration Number ',num2str(iter)]);
 if (mod(iter,1e3)==0)
 disp(['Policy Iteration Number ',num2str(iter)]);
 end
 APol = zeros(32,32);
 bPol = zeros(32,1);
 for i = 1:3
 % [costToGo(4,i,1),FVal(4,i,1)] = max(q.*p + (1-q).*p.*J(4,i+1,1)+(1-p).*J(4,i,2));
 f = FPol(12+i);
 APol(12+i,12+i)=-1;
 bPol(12+i)= -q(f)*p(f);
 APol(12+i,13+i)= (1-q(f))*p(f);
 APol(12+i,28+i)= (1-p(f));
 % [costToGo(4,i,2),FPol(4,i,2)] = max(q.*p + (1-q.*p).*J(4,i+1,1));
f = FPol(28+i);
 APol(28+i,28+i)=-1;
 bPol(28+i)= -q(f)*p(f);
 APol(28+i,13+i)= 1-p(f)*q(f);
 % [costToGo(i,4,1),FPol(i,4,1)] = max(q.*p.*J(i+1,4,1) + (1-p).*J(i,4,2));
 f = FPol(4*i);
 APol(4*i,4*i)=-1;
 APol(4*i,4*i+4)= q(f)*p(f);
 APol(4*i,20+4*(i-1))= 1-p(f);
 % [costToGo(i,4,2),FPol(i,4,2)] = max(q.*p.*J(i+1,4,1));
 f = FPol(4*i+16);
 APol(4*i+16,4*i+16)=-1;
 APol(4*i+16,4*i+4)= q(f)*p(f);
 for j = 1:3
 % Maximize over input 1 and 2
% [costToGo(i,j,1),FPol(i,j,1)] = max(q.*p.*J(i+1,j,1) + (1-q).*p.*J(i,j+1,1)+(1-p).*J(i,j,2));
 f = FPol(4*(i-1)+j);
 APol(4*(i-1)+j,4*(i-1)+j)=-1;
 APol(4*(i-1)+j,4*i+j)= q(f)*p(f);
 APol(4*(i-1)+j,4*(i-1)+j+1)= (1-q(f))*p(f);
 APol(4*(i-1)+j,4*(i-1)+j+16)= (1-p(f));
 % [costToGo(i,j,2),FPol(i,j,2)] = max(q.*p.*J(i+1,j,1) + (1-q.*p).*J(i,j+1,1));
 f = FPol(4*(i-1)+j+16);
 APol(4*(i-1)+j+16,4*(i-1)+j+16)=-1;
 APol(4*(i-1)+j+16,4*i+j)= q(f)*p(f);
 APol(4*(i-1)+j+16,4*(i-1)+j+1)= 1-q(f)*p(f);
 end
 end
 % [costToGo(4,4,1),FPol(4,4,1)] = max(q.*p.*J(4,3,1) + (1-q).*p.*J(3,4,1)+(1-p).*J(4,4,2));
 f = FPol(16);
 APol(16,16)=-1;
 APol(16,15)= q(f)*p(f);
 APol(16,12)= (1-q(f))*p(f);
 APol(16,32)= (1-p(f));
 % [costToGo(4,4,2),FPol(4,4,2)] = max(q.*p.*J(4,3,1) + (1-q.*p).*J(3,4,1));
 f = FPol(32);
 APol(32,32)=-1;
 APol(32,15)= q(f)*p(f);
 APol(32,12)= 1-q(f)*p(f);

 
 JPol = zeros(32,1);
 JPol = APol\bPol;

 
 FPolNew = FPol;
 JPolNew = JPol;

 JPol_re = reshape(JPol,4,4,2);
 JPol_re(:,:,1)= JPol_re(:,:,1)';
 JPol_re(:,:,2)= JPol_re(:,:,2)';

 
 costToGo = zeros(4, 4, 2);
 FPolNew_re = zeros(4, 4, 2);


 for i = 1:3
 [costToGo(4,i,1),FPolNew_re(4,i,1)] = max(q.*p + (1-q).*p.*JPol_re(4,i+1,1)+(1-p).*JPol_re(4,i,2));
 [costToGo(4,i,2),FPolNew_re(4,i,2)] = max(q.*p + (1-q.*p).*JPol_re(4,i+1,1));
 [costToGo(i,4,1),FPolNew_re(i,4,1)] = max(q.*p.*JPol_re(i+1,4,1)+ (1-p).*JPol_re(i,4,2));
 [costToGo(i,4,2),FPolNew_re(i,4,2)] = max(q.*p.*JPol_re(i+1,4,1));
 for j = 1:3
 % Maximize over input 1 and 2
 [costToGo(i,j,1),FPolNew_re(i,j,1)] = max(q.*p.*JPol_re(i+1,j,1)+ (1-q).*p.*JPol_re(i,j+1,1)+(1-p).*JPol_re(i,j,2));
 [costToGo(i,j,2),FPolNew_re(i,j,2)] = max(q.*p.*JPol_re(i+1,j,1)+ (1-q.*p).*JPol_re(i,j+1,1));
 end
 end
 [costToGo(4,4,1),FPolNew_re(4,4,1)] = max(q.*p.*JPol_re(4,3,1) + (1-q).*p.*JPol_re(3,4,1)+(1-p).*JPol_re(4,4,2));
 [costToGo(4,4,2),FPolNew_re(4,4,2)] = max(q.*p.*JPol_re(4,3,1) + (1-q.*p).*JPol_re(3,4,1));
 JPolNew(1:16) = reshape(costToGo(:,:,1)', 16,1);
 JPolNew(17:32) = reshape(costToGo(:,:,2)', 16,1);
 FPolNew(1:16) = reshape(FPolNew_re(:,:,1)', 16,1);
 FPolNew(17:32) = reshape(FPolNew_re(:,:,2)', 16,1);

 
 if ((norm(JPol - JPolNew)/norm(JPol) < 1e-10) )
 break;
 else
 FPol = FPolNew;
 end
 end
 JPolsave(m)=JPolNew(1,1);
end;
if test ==2
 plot(0:incr:(0.95-incr), JValsave,'.');
 hold on
 plot(0:incr:(0.95-incr), JPolsave,'r');
 grid on
 title('Probability of the server winning a game')
 xlabel('p_F')
 ylabel('Probability of winning')
 legend('Value Iteration', 'Policy Iteration')
else
 disp(['Probability of player 1 winning ',num2str(JValsave(1))]);

 subplot(1,2,1)
 bar3(FVal(:,:,1),0.25,'detached')
 title(['First Serve for p_F =', num2str(p(1))])
 ylabel('Score Player 1')
 xlabel('Score Player 2')
 zlabel('Input: Fast Serve (1) or Slow Serve (2)')
 subplot(1,2,2)
 bar3(FVal(:,:,2),0.25,'detached')
 title(['Second Serve for p_F =', num2str(p(1))])
 ylabel('Score Player 1')
 xlabel('Score Player 2')
 zlabel('Input: Fast Serve (1) or Slow Serve (2)')
end
