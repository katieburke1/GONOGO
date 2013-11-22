function [ Hm0,Hs,Tz,T02] = KilclogherWaveMeasurements(Waterlevel,SamplingFreq)
[ H1Third,H1Tenth,Hs_WaveHeight, HmoTuckDrap,Tz_WavePeriod,Tz_WavebyWave,P1Third,P1Tenth,MaxCrest,MinCrest,Outnotes]= TimeSeries(Waterlevel,0.01,SamplingFreq);
Hs=Hs_WaveHeight;
Tz=Tz_WavePeriod;
[Hm0,T1,T02,Tp0,Te,Energy,freq] = NewSpectra(Waterlevel,SamplingFreq);
end

