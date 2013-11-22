function [ w,SW ] = KilclogherPiersonMoskowitz( Hm0,T1)
A=172.8*Hm0^2*T1^-4;
B=691*T1^-4;
w=linspace(0,2,2048);
SW=(A.*(w.^-5)).*exp(-B.*(w.^-4));
% plot(w,SW)
% hold on
end

