%% Inicializirane
T0=1;
z = tf([0 1],1,T0,'variable','z^-1');
n=1;
G0=0.5*z/(1-0.8*z); % osnovna predavatelna funkciq, koqto shte ocenqvame
m=2;
C=(0.0012+0.0002*z-0.001*z*z)/(0.5-0.9656*z+0.4656*z*z);% kontrolera
H0=(1-1.56*z+1.045*z*z-0.3338*z*z*z)/(1-2.35*z+2.09*z*z-0.6675*z*z*z); %filtura
r=idinput(1000); % pravim si 1000 tochkov unikalen signal
% r=linspace(1,1,1000)';
t=1:1000;
R2=[t',r];
scale = 0.008; % snr ~15dB
sim('data_generator_plant');
signal=signal_and_noice(:,1);
noice=signal_and_noice(:,2);
disp(['SNR: ',num2str(snr(signal,noice))]);
closed=feedback(G0*C,1);
sample_data=iddata(signal_and_noice(2:end,1),r,T0);
tmp=C.num{1,1}/.5;
tmp=tmp(tmp~=0);
Q=tmp;
tmp=C.den{1,1}/.5;
tmp=tmp(tmp~=0);
P=tmp(2:end);
%% Harakteristiki na izsledvanite modeli
figure,step(G0,closed),legend toggle;
figure, bode(G0,closed),legend toggle;
figure,step(H0),legend toggle;
figure,bode(H0),legend toggle;
savefigs('images/harakteristiki-na-obekta-');
%% Poluchavane na modelite
arx_model=arx(sample_data,[1 1 1]);
figure,resid(arx_model,sample_data);
% figure,compare(sample_data,arx_model);
figure, step(G0,arx_model);
display(tf(arx_model));
%% iv4
iv4optimalen=iv4(sample_data,[1 1 1]);
figure,resid(iv4optimalen,sample_data);
% figure,compare(sample_data,iv4optimalen);
figure, step(G0,tf(1000*iv4optimalen.b,iv4optimalen.a,T0,'variable','z^-1'));
display(tf(1000*iv4optimalen.b,iv4optimalen.a,T0,'variable','z^-1'));
%po-dobre e da se izpolzva ivx kato metod za identifikaciq za da moje da se
%izpolzvat instrumentalni promenlivi zadavani v aftorska funkciq. ne tezi,
%koito izchislqva IV4 algorituma na matlab.
%% izpolzvame zadanieto kato instrumenti - variant na M1 
close all;
i=1;
instruments=[zeros(1,i),  r(i+1:end)']';
ivx_model=ivx(sample_data,[1 1 1],instruments); %neoptimalen nachin za
%presmqtane no e nachin sega trqbav da oprabotq vektora na istrumentite po
%nachina deto e opisan v statiite
% figure,resid(ivx_model,sample_data);
% figure,compare(sample_data,iv4optimalen);
figure, step(G0,tf(170*ivx_model.b,ivx_model.a,T0,'variable','z^-1'));
display(tf(ivx_model.b,ivx_model.a,T0,'variable','z^-1'));
%% closed-loop basic IV method
titas=0;
monteCarlo=100;
N=1000;
rb=2;
for intr=1:monteCarlo
    sim('data_generator_plant');
    signal=signal_and_noice(:,1);
    noice=signal_and_noice(:,2);
    sample_data=iddata(signal_and_noice(2:end,1),r,T0);
    y=-signal;
    u=signal_and_noice(:,3);
    tempsum=0;
    tempsum2=0;
    for t=rb+1:N
        fic=[-y(t-1:-1:t-n),r(t-1:-1:t-n)]';
        fi=[-y(t-1:-1:t-n),u(t-1:-1:t-n)]';
        fir=r(t-1:-1:t-rb);
        tempsum=tempsum+fir*fi';
        tempsum2=tempsum2+fir*y(t);
    end
    tempsum=tempsum/(N-rb-1);
    tempsum2=tempsum2/(N-rb-1);
    titas=titas+tempsum^-1*tempsum2;
end
titas=titas/monteCarlo;
result=tf([0 -titas(2)],[1 titas(1)],T0,'variable','z^-1');
disp(monteCarlo);
display(titas);
display(result);
step(G0,result);
%     0.5 z^-1
%   ------------
%   1 - 0.8 z^-1
% 
% result =
%  
%       0.4799 z^-1
%   ---------------
%   1 - 0.8122 z^-1
%  
% Sample time: 1 seconds
% Discrete-time transfer function.
% 
% 
% titas =
% 
%    -0.8122
%    -0.4799
%% Closed-loop extended IV method
titas=0;
monteCarlo=100;
N=1000;
n=1;
rb=2;
Q=1000*eye(n);
L=eye(n);
xmin=100000;
for intr=1:monteCarlo
    sim('data_generator_plant');
    signal=signal_and_noice(:,1);
    noice=signal_and_noice(:,2);
    sample_data=iddata(signal_and_noice(2:end,1),r,T0);
    y=-signal;
    u=signal_and_noice(:,3);
    tempsum=0;
    tempsum2=0;
    for t=rb+1:N
        fic=[-y(t-1:-1:t-n),r(t-1:-1:t-n)]';
        fi=[-y(t-1:-1:t-n),u(t-1:-1:t-n)]';
        fir=r(t-1:-1:t-rb);
        tempsum=tempsum+fir*L*fi';
        tempsum2=tempsum2+fir*L*y(t);
    end
    tempsum=tempsum/(N-rb-1);
    tempsum2=tempsum2/(N-rb-1);
    xc=tempsum^-1*tempsum2;
    x=xc'*Q*xc;
    if(x<xmin)
        xmin=x;
        titas=xc;
    end
end
result=tf(-titas(2),[1 titas(1)],T0,'variable','z^-1');
display(titas);
display(result);
%     0.5 z^-1
%   ------------
%   1 - 0.8 z^-1
% titas =
% 
%    -0.7300
%    -0.5252
% 
% 
% result =
%  
%      0.5252
%   -------------
%   1 - 0.73 z^-1
%% Tailor-made IV identification (M1)
titas=0;
monteCarlo=100;
n=1;
F=1000*eye(length(r));
xmin=100000;
for intr=1:monteCarlo
    sim('data_generator_plant');
    signal=signal_and_noice(:,1);
    noice=signal_and_noice(:,2);
    
    sample_data=iddata(signal_and_noice(2:end,1),r,T0);
    ivx_model=ivx(sample_data,[1 1 1],F*[0 0 r(3:end)']');
    titas=titas+[ivx_model.a(n+1:end);ivx_model.b(n+1:end)];
end
titas=titas/monteCarlo;
result=tf([0 100*titas(2)],[1 titas(1)],T0,'variable','z^-1');
display(titas);
display(result);
step(G0,result);
% titas =
% 
%    -0.8135
%    -0.5346
% 
% 
% result =
%  
%     0.5346 z^-1
%   ---------------
%   1 - 0.8135 z^-1
%% BELS method
N=1000;
tmp=C.num{1,1}/.5;
tmp=tmp(tmp~=0);
Q=tmp;
tmp=C.den{1,1}/.5;
tmp=tmp(tmp~=0);
P=tmp(2:end);
ps=[1 P];
qs=[Q];
Qc=sylvester_bels(qs);
Pc=sylvester_bels(ps);
Pcc=[Pc;zeros(1,length(Pc(1,:)))];
M=[Pc Qc;zeros(size(Pcc)),Pcc];
titas=0;
monteCarlo=100;
N=1000;
n=1;
rb=m+n;
Q=1000*eye(n);
L=eye(n);
xmin=100000;
for intr=1:monteCarlo
    sim('data_generator_plant');
    signal=signal_and_noice(:,1);
    noice=signal_and_noice(:,2);
    sample_data=iddata(signal_and_noice(2:end,1),r,T0);
    y=-signal;
    u=signal_and_noice(:,3);
    tempsum=0;
    tempsum2=0;
    for t=rb+1:N
        fic=[-y(t-1:-1:t-n),r(t-1:-1:t-n)]';
        fi=[-y(t-1:-1:t-n),u(t-1:-1:t-n)]';
        fir=r(t-1:-1:t-rb);
        tempsum=tempsum+fir*L*fi';
        tempsum2=tempsum2+fir*L*y(t);
    end
    tempsum=tempsum/(N-rb-1);
    tempsum2=tempsum2/(N-rb-1);
    xc=tempsum^-1*tempsum2;
    x=xc'*Q*xc;
    if(x<xmin)
        xmin=x;
        titas=xc;
    end
end
result=tf([0 -titas(2)],[1 titas(1)],T0,'variable','z^-1');
display(titas);
display(result);
step(G0,result);
% titas =
% 
%    -0.2901
%    -0.2470
% 
% 
% result =
%  
%     0.247 z^-1
%   ---------------
%   1 - 0.2901 z^-1
%% dalin
Wd=result
d=1;
[ Bin,Bout,Bplus,Bminus ] = bsbu([Wd.num{1}(2:end)]);

% proektirane na regulator na dalin
Ad=Wd.den{1};
Tsau=2;
[ Q,P ] = dalin_nomin(Bplus,Bminus,Ad,d,Tsau,T0);
Wd=G0;
sim('model',100);
h=pilot(ScopeData,d,T0,Tsau);







