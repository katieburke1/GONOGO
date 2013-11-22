function [ H1Third,H1Tenth,Hs_WaveHeight, HmoTuckDrap,Tz_WavePeriod,Tz_WavebyWave,P1Third,P1Tenth,MaxCrest,MinCrest,Outnotes]= TimeSeries(SWE,limit,samplingfreq)
clear('Data')

%SWE = Waves2
%limit = 0.01
% samplingfreq=3;

Xold = 1;
countUp = 0;
waveperiod =0;
Hsquare = 0;
crest = 0;
trough = 0;
maxcrest = 0;
Data = [0 0 0 0];

%limit = .010;
range = length(SWE);

for y = 1:range;
    
    Xnew = SWE(y) ;
    Hsquare = Hsquare + (Xnew)^2;
    waveperiod = 1/samplingfreq + waveperiod;
    if Xnew > crest && Xnew > limit
        crest = Xnew;
        if crest > maxcrest
            maxcrest = crest;
        end
    else
    end
    
    if Xnew < trough && Xnew < limit
        trough = Xnew;
    else
    end
    
    if Xnew >= 0 && Xold < 0
     
     
     waveheight = abs(crest)+abs(trough);
     
     if waveheight > limit
     wavesteepness = (2*pi* waveheight*0.001)/(9.81*waveperiod^2);
     waveenergy = 1025*9.81*((waveheight*0.001)^2)/8;
     new_row = [waveheight waveperiod wavesteepness waveenergy];
     Data = [Data ; new_row];
     countUp = countUp + 1;
     end
     
     waveheight = 0;
     waveperiod = 0;
     crest = 0;
     trough = 0;
     
    else
    end
 
    Xold = Xnew;
end


RMS = (Hsquare/range)^0.5;

Tz_WavePeriod = (range/samplingfreq)/countUp;

Tz_WavebyWave = mean(Data(:,2));

Hs_WaveHeight = (RMS)*4;

H_OneThird = 1.41*Hs_WaveHeight;

H_OneTenth = 1.8*Hs_WaveHeight;

H_Max_Rayleigh = H_OneThird*sqrt(0.5*log(countUp));

H_Max_50Percentile = H_OneThird*0.5*log(1.45*countUp);

Ss_SignificantSteepness = (2*pi*Hs_WaveHeight*.001)/(9.81*Tz_WavePeriod^2);


%Start Tucker-Draper (Historical Method)

    ATuckDrap = max(SWE);
    BTuckDrap = max(SWE(SWE~=max(SWE)));
    CTuckDrap = min(SWE);
    DTuckDrap = min(SWE(SWE~=min(SWE)));
    H1TuckDrap = ATuckDrap - CTuckDrap;
    H2TuckDrap = BTuckDrap - DTuckDrap;
    alpha = log(countUp);
   MoH1TuckDrap = ((H1TuckDrap/(2*(1+0.289*(alpha^-1)-0.247*(alpha^-2))))^2)/(2*alpha);
   MoH2TuckDrap = ((H2TuckDrap/(2*(1-0.211*(alpha^-1)-0.103*(alpha^-2))))^2)/(2*alpha);
   HmoH1TuckDrap = 4*sqrt(MoH1TuckDrap);
   HmoH2TuckDrap = 4*sqrt(MoH2TuckDrap);
    
   HmoTuckDrap = (HmoH1TuckDrap +HmoH2TuckDrap)/2;
    %HmoTuckDrap =0;
    MaxCrest = ATuckDrap;
    MinCrest = CTuckDrap;
    
%End Tucker-Draper (Historical Method) 
clear('Outnotes')
Outnotes=[];
%Start Statistical Outlier Checks
if MaxCrest > 5*RMS
Outnotes = 2;
end

if abs(MinCrest) > 5*RMS
Outnotes = [Outnotes 3];
end

%End OUtlier

%Start Determing heighest 1/3 Waves

SortHeightData=sort(Data(2:end,1));
max1third = SortHeightData(floor((length(SortHeightData))*(2/3)):(length(SortHeightData)));
avgmax1third = mean(max1third);
H1Third = avgmax1third;
%End Determing heighest 1/3 Waves

%Start Determing heighest 1/10 Waves
max1tenth = SortHeightData(floor((length(SortHeightData))*(9/10)):(length(SortHeightData)));
avgmax1tenth = mean(max1tenth);
H1Tenth = avgmax1tenth;
%End Determing heighest 1/10 Waves

%Start Determing 1/3 Longest Waves 
SortPeriodData=sort(Data(2:end,2));
Pmax1third = SortPeriodData(floor((length(SortPeriodData))*(2/3)):(length(SortPeriodData)));
Pavgmax1third = mean(Pmax1third);
P1Third = Pavgmax1third;
%End Determing  1/3 Longest Waves 

%Start Determing  1/10 Longest Waves 
Pmax1tenth = SortPeriodData(floor((length(SortPeriodData))*(9/10)):(length(SortPeriodData)));
Pavgmax1tenth = mean(Pmax1tenth);
P1Tenth = Pavgmax1tenth;
%End Determing  1/10 Longest Waves 

%Start Probability of 'Spurious' Spikes in the Record

    MaxUpCrossHeight = max(Data());
    Probx = maxcrest/RMS;
    ProbXmax = exp(-countUp*exp(-((Probx)^2)/2));
    
%End Probability of 'Spurious' Spikes in the Record



%subplot(1,4,1); plot(X,C,X,f,'r')

%subplot(1,4,2); plot(X,D)

%Tz_WavePeriod
%Tz_WavebyWave
%Hs_WaveHeight
%H_OneThird
%HmoTuckDrap
%avgmax1third
%H_OneTenth
%H_Max_Rayleigh
%H_Max_50Percentile

%x= 0:250;
%p = raylpdf(x,100);


%wave = Data(:,1);
%X =1:1:length(wave);
%subplot(1,4,3);hist(wave)
%ylabels = get(gca, 'YTickLabel');
%ylabels = linspace(0,100,length(ylabels));
%set(gca,'YTickLabel',ylabels); 
 
%subplot(1,4,4);hist(wave)

%Y = wave./sum(wave);
%subplot(1,4,4);bar(X,Y,1)
%h = findobj(gca,'Type','patch');
%set(h,'FaceColor','r','EdgeColor','w')