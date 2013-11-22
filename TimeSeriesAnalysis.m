load('KilclogherTS.mat');
Matsize=size(TSeriesdata);
for j=1:Matsize(2)
    [ H1Third,H1Tenth,Hs_WaveHeight, HmoTuckDrap,Tz_WavePeriod,Tz_WavebyWave,P1Third,P1Tenth,MaxCrest,MinCrest,Outnotes]= TimeSeries(TSeriesdata(:,j),0.01,2);
     HoneThird(j)=H1Third;
     HoneTenth(j)=H1Tenth;
     Hs(j)=Hs_WaveHeight;
     HmoTuck(j)=HmoTuckDrap;
     Tz_Period(j)=Tz_WavePeriod;
end
