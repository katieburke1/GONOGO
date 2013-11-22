load('KilclogherTS.mat');
Matsize=size(TSeriesdata);
for j=1:Matsize(2)
        [Hm0,T1,T02,Tp0,Te,Energy,freq] = NewSpectra(TSeriesdata(:,j),2);
    Data.Hm0(j)=Hm0;
    Data.T02(j)=T02;
    Data.Te(j)=Te;
    Data.Sf(:,j)=Energy;
    Data.freq(:,j)=freq;
%     [ HsO,TeO,TzO,TpO,eO,Spec,f10]= Kilclogher_Spectrum(TSeriesdata(:,j));
%     Data.Hm0(j)=HsO;
%     Data.T02(j)=TzO;
%     Data.Te(j)=TeO;
%     Data.Sf(:,j)=Spec;
%     Data.freq(:,j)=f10;
end
