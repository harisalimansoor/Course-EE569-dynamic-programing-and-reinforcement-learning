clear all
clc
close all
%%
etta=0.5;
gamma=0.9;


q=[1 1;1 1];

a_g1=[0.3 0.7];
a_g0=[0.8 0.2];
a_b1=[0.5 0.5];
a_b0=[0.95 0.05];

c_g1=-0.5;
c_g0=0;
c_b1=0.5;
c_b0=0;


iterations=1000;
%initial state g=1, b=0
state=1;
%initial action action=1,0
action=1;

for i=1:iterations
    i
    
    alpha=1/(1+i);
    

    if action==1 && state==1
        a=0 + (1)*rand(1);
        if a<0.3
            next_state=1;
        end
        if a>0.3
            next_state=0;
        end
        
    if next_state==1  
       next_action=1;
       r=-0.5;
    end
    if next_state==0
       next_action=0;
       r=0;
       
    end
        
    if next_state==1 && next_action==1
        
        q(1,1)=q(1,1)+alpha*(r+gamma*q(1,1)-q(1,1));
    end
     
    if next_state==0 && next_action==0
        
        q(2,2)=q(2,2)+alpha*(r+gamma*q(2,2)-q(2,2));
    end
         
    end
       
    
    if action==0 && state==1
        a=0 + (1)*rand(1);
        if a<0.8
            next_state=1;
        end
        if a>0.8
            next_state=0;
        end
        
        if next_state==1  
       next_action=1;
       r=-0.5;
    end
    if next_state==0
       next_action=0;
       r=0;
       
    end
        
    if next_state==1 && next_action==1
        
        q(1,1)=q(1,1)+alpha*(r+gamma*q(1,1)-q(1,1));
    end
     
    if next_state==0 && next_action==0
        
        q(2,2)=q(2,2)+alpha*(r+gamma*q(2,2)-q(2,2));
    end
        
        
    end
    
    
    if action==1 && state==0
        a=0 + (1)*rand(1);
        if a<0.5
            next_state=1;
        end
        if a>0.5
            next_state=0;
        end
        if next_state==1  
       next_action=1;
       r=-0.5;
    end
    if next_state==0
       next_action=0;
       r=0;
       
    end
        
    if next_state==1 && next_action==1
        
        q(1,1)=q(1,1)+alpha*(r+gamma*q(1,1)-q(1,1));
    end
     
    if next_state==0 && next_action==0
        
        q(2,2)=q(2,2)+alpha*(r+gamma*q(2,2)-q(2,2));
    end
    end
    
    if action==0 && state==0
        a=0 + (1)*rand(1);
        if a<0.95
            next_state=1;
        end
        if a>0.95
            next_state=0;
        end
        
        if next_state==1  
       next_action=1;
       r=-0.5;
    end
    if next_state==0
       next_action=0;
       r=0;
       
    end
        
    if next_state==1 && next_action==1
        
        q(1,1)=q(1,1)+alpha*(r+gamma*q(1,1)-q(1,1));
    end
     
    if next_state==0 && next_action==0
        
        q(2,2)=q(2,2)+alpha*(r+gamma*q(2,2)-q(2,2));
    end
        
    end
    
    action=next_action;
    state=next_state;
    
    
end