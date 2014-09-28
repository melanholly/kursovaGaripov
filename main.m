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
disp(['SNR: ',num2str(snr(signal_and_noice(:,1),signal_and_noice(:,2)))]);
closed=feedback(G0*C,1);
sample_data=iddata(signal_and_noice(2:end,1),r,T0);
%% Harakteristiki na izsledvanite modeli
figure,step(G0,closed),legend toggle;
figure, bode(G0,closed),legend toggle;
figure,step(H0),legend toggle;
figure,bode(H0),legend toggle;
%% Poluchavane na modelite
iv4optimalen=iv4(sample_data,[2 2 1]);
figure,resid(iv4optimalen,d);
figure,compare(d,iv4optimalen);
figure, step(G0,iv4optimalen);
%po-dobre e da se izpolzva ivx kato metod za identifikaciq za da moje da se
%izpolzvat instrumentalni promenlivi zadavani v aftorska funkciq. ne tezi,
%koito izchislqva IV4 algorituma na matlab.
ivx(sample_data,[1 1 1],[0 0 0 0  r(5:end)']') %neoptimalen nachin za
%presmqtane no e nachin sega trqbav da oprabotq vektora na istrumentite po
%nachina deto e opisan v statiite














