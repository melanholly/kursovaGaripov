function [sf]=prefilter(signal,filter)
P=filter(end:-1:1);
P=1;
y=signal;
max_stepen=length(P);
yf=[];
for nt=1:length(y)
    z=y(nt);
    zf=0;
    for j=1:max_stepen
       zf=zf+P(j)*z^(j); 
    end
    yf=[yf zf];
end
sf=yf';
end