function [ Q,P ] = dahlin_nonmin( Bplus,Bminus,Ad,d,Tsau,T0)
nminus=length(Bminus)-1;
nplus=length(Bplus)-1;
beta=1-exp(-T0/Tsau);
kcor=1/sum(Bminus);
koef=kcor*beta;
%izchislqvane na kizhodnite polinomi
Q=[koef*Ad zeros(1,d)];
P2=koef*conv(Bminus,[zeros(1,d+1) 1]);
P1=[1 beta-1 zeros(1,d+nminus)]-P2;
P=conv(Bplus,P1);
