for i=1:5
    x=(i-1)*512+1
%     y=i*512
    y=(i-1)*512+1024
    
[Hm0(i),T1(i),T02(i),Tp0(i),Te(i),Energy,freq] = NewSpectra(Elevation(x:y),2.56);
end
Hm0Mean=mean(Hm0);
T1mean=mean(T1);
T02mean=mean(T02);