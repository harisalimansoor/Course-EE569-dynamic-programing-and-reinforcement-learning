clear all
clc
close all

%%

A=[0.5 1 0;0 0.5 1;0 0 0.5];
C=[1 0 0];

mu=[0 0 0];
Q=eye(3);
R=1;

x0=[0 0 0]'; %initial state
P_previous= eye(3); %initial covariance
iterations=1000;
states=3;
original=zeros(1,iterations+1);
estimated=zeros(3,iterations+1);


%%
for i=1:iterations
    i
    P_=A*P_previous*A'+Q;
    K=P_*C'*inv(C*P_*C'+R);
    
    x_=A*x0;
    x0=x_+K*(C*(A*x_+mvnrnd(mu,Q)')+mvnrnd(0,1)-C*x_);
    original(1,i)=C*(A*x_+mvnrnd(mu,Q)');
    estimated(:,i)=x0;
    
    P_previous=(Q-K*C)*P_;
   
    
end
    
    
%%
figure()
plot(original)

hold on

plot(estimated(1,:))
    

%%

clear all
clc
close all


% riccati equation


P_prev=eye(3);
A=[0.5 1 0;0 0.5 1;0 0 0.5];
C=[1 0 0];

mu=[0 0 0];
Q=eye(3);
R=1;

for i=1:20
i
P_=A*P_prev*A'+Q+A*P_prev*C'*inv(C*P_prev*C'+R)*C*P_prev*A';
P_prev=P_;
p1(1,i)=P_(1,1);
p2(1,i)=P_(1,2);
p3(1,i)=P_(1,3);
p4(1,i)=P_(2,1);
p5(1,i)=P_(2,2);
p6(1,i)=P_(2,3);
p7(1,i)=P_(3,1);
p8(1,i)=P_(3,2);
p9(1,i)=P_(3,3);

end

%%
figure()
plot(p1)
hold on
plot(p2)
hold on
plot(p3)
hold on
plot(p4)
hold on
plot(p5)
hold on
plot(p6)
hold on
plot(p7)
hold on
plot(p8)
hold on
plot(p9)

