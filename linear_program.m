clear all
clc
close all


%% etta=0.5

eta=0.5;
alpha=0.9;
Aineq=[0.95*alpha 0.05*alpha-1;
        0.5*alpha 0.5*alpha-1;
        0.8*alpha-1 0.2*alpha;
        0.3*alpha-1 0.7*alpha];
bineq=[0;-eta;0;1-eta];
f=[1;1];
[x,fval]=linprog(f, Aineq, bineq)
