function [Hm0,T1,T02,Tp0,Te,Energy,freq,m0,m2] = GUISpectra(Waterlevel,SampleFreq)

Fs = SampleFreq;              % Sampling frequency
T = 1/Fs;                     % Sample time
L = length(Waterlevel);       % Length of signal

NFFT = 2^nextpow2(L); % Next power of 2 from length of y
Y = fft(Waterlevel,L);
Energy = Y.*conj(Y)/L;
Energy=Energy(1:L/2+1)';
freq = Fs/2*linspace(0,1,L/2+1);
deltaF=freq(3)-freq(2);
% Energy=2*abs(Y(1:L/2+1)).^2';
m0=sum((freq.^0).*Energy).*deltaF;
m1=sum((freq.^1).*Energy).*deltaF;
m2=sum((freq.^2).*Energy).*deltaF;
m4=sum((freq.^4).*Energy).*deltaF;
m_1=sum((freq.^-1).*Energy)*deltaF;
Hm0=4*sqrt(m0);
T1=(m0/m1);
T02=sqrt(m0/m2);
Te=(m_1/m0);
max_val = max(Energy);
index = find(Energy == max_val, 1, 'first');
Tp0 = 1/freq(index);
[w,SW]=KilclogherPiersonMoskowitz(Hm0,T1);
setappdata(0,'w',w)
setappdata(0,'SW',SW)
end

