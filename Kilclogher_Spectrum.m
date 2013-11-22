function [ HsO,TeO,TzO,TpO,eO,Spec,f10]= Kilclogher_Spectrum(Waterlevel)
SWE=Waterlevel;
SamplingFrequency=4;
Timesave=linspace(1/SamplingFrequency,length(SWE)/SamplingFrequency,length(SWE));
currentdir=pwd;
Notes=[];
y=SWE;

Nsamps = length(y);
t = (1/SamplingFrequency)*(1:Nsamps) ;         %Prepare time data for plot
RatioDivide = 2;
%Do Fourier Transform
y_fft = abs(fft(y,Nsamps));          %Retain Magnitude
y_fft = y_fft(1:Nsamps/RatioDivide+1);      %Discard Half of Points
% f =(0:Nsamps/RatioDivide-1)/Nsamps;
% f = (0:Nsamps/RatioDivide-1)/Nsamps;   %Prepare freq data for plot
f = SamplingFrequency/2*linspace(0,1,Nsamps/2+1);
f = f(1:length(f));%';
period = 1./f;


deltaF = f(3)-f(2);

%energy = 1.027/1000*9.81.*y_fft;
energy = 2*((y_fft.^2).*deltaF);   %Multiply by 2 Because spectrum is one sided, look at Lecture10 -Hydro page 89


% figure
% plot(f, energy)
%xlim([0 0.5])
%ylim([0 1*10^7])
%xlabel('Frequency')
%ylabel('Energy')
%title('Frequency Response ')



%power of 9 for full sample, 

[energy10] = sub_resample( energy, length(energy), SamplingFrequency );
[f10] = sub_resample( f, length(f), SamplingFrequency );
period10 = 1./f10;
%figure
deltaf10=f10(2)-f10(1);

% set(0,'DefaultFigureVisible','on');
figle= figure;
plot(f10, energy10,'g');
% xlabel('Frequency (Hz)')
% ylabel('Spectral Energy')
% xlim([0 2]);

% end

%max_val = max(energy10(((length(energy10))/10):length(energy10)));
max_val = max(energy10);
index = find(energy10 == max_val, 1, 'first');
TpO = 1/f10(index);

%xlim([0 0.5])

%LinkTopAxisData(f10 ,period10,'T / K');

%ylim([0 max_val])

m0 = trapz(f10,energy10);
m1 = trapz(f10,f10.*energy10);
m2 = trapz(f10, f10.^2.*energy10);
m4 = trapz(f10, f10.^4.*energy10);

Hs = 4*sqrt(m0);

T1 = m0/m1;
Tz = sqrt(m0/m2);
Tc = sqrt (m2/m4);

e = sqrt((m0*m4-m2^2)/(m0*m4));


%%%%%%%%%%%%%%%%%%%%%%%%%%
% m0O = trapz(f',energy);
% m_1 = trapz(f', f'.^-1.*energy);
% m1O = trapz(f',f'.*energy);
% m2O = trapz(f', f'.^2.*energy);
% m4O = trapz(f', f'.^4.*energy);

m0O = trapz(f10,energy10);
m_1 = trapz(f10, f10.^-1.*energy10);
m1O = trapz(f10,f10.*energy10);
m2O = trapz(f10, f10.^2.*energy10);
m4O = trapz(f10, f10.^4.*energy10);

HsO = 4*sqrt(m0O);

T1O = m0O/m1O;
TzO = sqrt(m0O/m2O);
TcO = sqrt (m2O/m4O);
TeO = m_1/m0O;

eO = sqrt((m0O*m4O-m2O^2)/(m0O*m4));
%%%%%%%%%%%%%%%%%%%%%%%%%
%if Tp > 30
%    
%    h = figure('visible','off')
%    plot(f10(1:(length(f10)/4)), energy10(1:(length(f10)/4)),'g')
%    title(Time);
%    filename = [Time(1:2) Time(4:6) Time(8:11) Time(13:14) Time(16:17)] ;
%    saveas(h,filename,'jpg')
%    Notes = 1;
%else
%    Notes = 0;
%end

Spec = energy10;

%f10(2)-f10(1);
%hold on
%plot(ValeFreq,ValeEnergy2,'--')