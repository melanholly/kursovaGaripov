titas=0;
monteCarlo=10;
rb=2*n;
L=1;
for intr=1:monteCarlo
    seed=static_noise(intr);
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
        fir=r(t-1:-1:t-rb)';
        tempsum=tempsum+fir*prefilter(fi,L);
        tempsum2=tempsum2+fir*prefilter(y(t),L);
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