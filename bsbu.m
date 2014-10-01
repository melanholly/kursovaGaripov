function [ Bin,Bout,Bplus,Bminus ] = bsbu(B)
%UNTITLED1 Summary of this function goes here
%   Detailed explanation goes here
Bin=[];
Bout=[];
s=B(1);
B=B/s;
Broots=roots(B);
for j=1:length(Broots)
    if abs(real(Broots(j)))<=1&&abs(imag(Broots(j)))<=1
        Bin=[Bin Broots(j)];
    else
        Bout=[Bout Broots(j)];
    end
end
Bplus=poly([Bin]);
Bminus=s*poly([Bout]);
