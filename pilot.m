function h=pilot(ScopeData,d,T0,Tsau)
h=figure('Position',[100,100,700,330]);
subplot(1,2,1);
% gray(h)
stairs(ScopeData.time,ScopeData.signals(1).values);
hold on;
[a,b]=step(tf(1,[Tsau,1])*exp(-(d+2)*T0*tf([1 0],1)),T0*25);
plot(b,a,'g');
hold off;
title('Izhod na zatvorenata sistema');
xlabel('vreme, s');
ylabel('Amplituda');
subplot(1,2,2);
stairs(ScopeData.time,ScopeData.signals(2).values);
title('Upravlenie');
xlabel('vreme, s');
end