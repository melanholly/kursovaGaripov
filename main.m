%% Inicializirane
T0=1;
z = tf([0 1],1,T0,'variable','z^-1');
n=1;
G0=0.5*z/(1-0.8*z); % osnovna predavatelna funkciq, koqto shte ocenqvame
m=2;
C=(0.0012+0.0002*z-0.001*z*z)/(0.5-0.9656*z+0.4656*z*z);% kontrolera
H0=(1-1.56*z+1.045*z*z-0.3338*z*z*z)/(1-2.35*z+2.09*z*z-0.6675*z*z*z); %filtura
r=idinput(1000); % pravim si 1000 tochkov unikalen signal
