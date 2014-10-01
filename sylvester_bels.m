function [ Cont ] = sylvester_bels( ps )
%SYLVESTER_BELS Summary of this function goes here
%   Detailed explanation goes here
broi=length(ps);
Cont=zeros(broi*2-1,broi);
for i=1:broi
    Cont(i:broi+i-1,i)=Cont(i:broi+i-1,i)+ps';
end

end

