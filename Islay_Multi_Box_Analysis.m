function [ Box ] = Islay_Multi_Box_Analysis( Data,Hmin,Hmax,Tmin,Tmax )
%Analyse datasets that inhabit the same scatter plot box to assess
%variations in power depending on formula used
%Time_Stamp=[Data.datelist(1,4:6),'-',Data.datelist(length(Data.datenumber),4:6),' ',Data.datelist(1,8:11)];

Hm0=Data.Hm0;
T02=Data.T02;
Te=Data.T02;
% Te=Data.Te;
Spec=Data.Sf;
freq=Data.freq;

Fig1=figure;

for m=1:length(Hmin)
clear Box
%% Allocate Occurrences
k=0;
for i=1:length(Hm0)
   if Hm0(i)>=Hmin(m) && Hm0(i)<= Hmax(m) && Te(i)>=Tmin(m) && Te(i)<=Tmax(m)
      k=k+1;
      Box.Hm0(k)=Data.Hm0(i);
      Box.T02(k)=Data.T02(i);
      Box.Te(k)=Data.Te(i);
      Box.Spec(:,k)=Data.Sf(:,i);
      Box.freq(:,k)=Data.freq(:,i);
     
      
      
   end
    
    
end
    
    
clear i  

%% Plot Combined Spectral values
Box.Spec_No=k;
Box.Spec_Total= zeros(size(Box.Spec(:,1)));
for i=1:Box.Spec_No

if  isnan(Box.Spec(1,i))~=1 
Box.Spec_Total= Box.Spec_Total + Box.Spec(:,i); %Sum of all spectra
end
end

Box.Avg_Spectrum=Box.Spec_Total./Box.Spec_No; %Average Monthly spectrum
Box.Upper_Bound=max(Box.Spec,[],2);
Box.Lower_Bound=min(Box.Spec,[],2);
% Box.Tav=(sum(Box.T02))/length(Box.T02); 
% Box.Hav=(sum(Box.Hm0))/length(Box.Hm0);
Box.Tav=mean(Box.T02);
Box.Hav=mean(Box.Hm0);
Box.BS_freq=Box.freq(:,1)';
%% Calculate Pierson-Moskowitz Spectrum based on average of Hm0 and T02
A=172.8*Box.Hav^2*Box.Tav^-4;
B=691*Box.Tav^-4;
Box.PMS=(A.*(Box.BS_freq(1,:).^-5)).*exp(-B.*(Box.BS_freq(1,:).^-4));
% Box.PMS=(8.1/10^3).*((9.81^2)./(Box.freq(:,1)').^5).*exp(-0.032.*(9.81./(Box.Hav.*Box.freq(:,1)'.^2).^2));
%% Calculate Bretschneider Spectrum based on Average of Hm0 and T02
% Box.Tav=(sum(Box.T02))/length(Box.T02); 
% Box.Hav=(sum(Box.Hm0))/length(Box.Hm0); 

% Box.BS_freq=0.005:0.001:.516;
% Box.BS = (A.*Box.BS_freq(1,:).^(-5)).*exp(-B.*Box.BS_freq(1,:).^(-4));
% Box.BS_df=Box.BS_freq(1,2)-Box.BS_freq(1,1);
%%
%% Calculate Bretschneider Spectrum based on Hm0 and T02 from the average
% spectrum

B = (0.751/Box.Tav)^4;
A = B*(Box.Hav^2)/4;
% Box.BS_freq=0.005:0.001:.516;
Box.BS_freq=Box.freq(:,1)';
Box.BS = (A.*Box.BS_freq(1,:).^(-5)).*exp(-B.*(Box.BS_freq(1,:).^(-4)));
Box.BS_df=Box.BS_freq(1,2)-Box.BS_freq(1,1);

%% Calculate JONSWAP
% Box.T1=1.073*Box.Tav;
Box.HJS=((Hmax(m)+Hmin(m))/2);
Box.T1=1.073*((Tmax(m)+Tmin(m))/2);


% gamma=[1,2,3.3,5,6];
% F1=[1,1.24,1.52,1.86,2.04];
% F2=[1,.95,.92,.9,.89];


gamma=3.3;

% T&P Table 5.1
F1=1.52;
F2=.92;

sigma_a=0.07;
sigma_b=0.09;
sigma=zeros(size(Box.BS_freq));
Gf=zeros(1,length(Box.BS_freq));
% T&P 5.5-16

for i=1:length(Box.BS_freq)
   if Box.BS_freq(i)<(1.296*F2*Box.T1)^-1
       sigma(i)=sigma_a;       
   else
       sigma(i)=sigma_b;
   end
end
Temp1=(((1.296.*F2.*Box.T1.*Box.BS_freq)-1).^2);
Temp2=(2.*(sigma.^2));
Gf=gamma.^exp(-Temp1./Temp2);

Box.JS=Gf.*(1./(F1*(F2^4))).*0.11.*(Box.HJS.^2).*Box.T1.*((Box.T1.*Box.BS_freq).^-5).*exp(-0.44./((F2.*Box.T1.*Box.BS_freq).^4));


% Calculate spectral Moments and asummary stats
%%
l = length(Box.BS);
% SPEC summing for m0
m0_temp = zeros(l,1); 
for k = 1:l;
    m0_temp(k) = (Box.BS_df*Box.BS(k)*Box.BS_freq(1,k)^0);
end
Box.BS_m0 = sum(m0_temp);
clear m0_temp k

% SPEC summkng for m-1
m_1_temp = zeros(l,1);           
for k = 1:l;
    m_1_temp(k) = (Box.BS_df*Box.BS(k)*Box.BS_freq(1,k)^-1); 
    % m-1 = (f^-1 S(f) df)
end
Box.BS_m_1 = sum(m_1_temp);
clear m_1_temp k

% SPEC summkng for m1
m1_temp = zeros(l,1);          
for k = 1:l;
    m1_temp(k) = (Box.BS_df*Box.BS(k)*Box.BS_freq(1,k));
    % m1 = (f^1 S(f) df)
end
Box.BS_m1 = sum(m1_temp);
clear m1_temp k

% SPEC summkng for m2
m2_temp = zeros(l,1);           
for k = 2:l;
    m2_temp(k) = (Box.BS_df*Box.BS(k)*Box.BS_freq(1,k)^2); 
    % m2 = (f^2 S(f) df)
end
Box.BS_m2 = sum(m2_temp);
clear m2_temp k

% SPEC summkng for m4
m4_temp = zeros(l,1);           
for k = 2:l;
    m4_temp(k) = (Box.BS_df*Box.BS(k)*Box.BS_freq(1,k)^4); 
    % m4 = (f^4 S(f) df)
end
Box.BS_m4 = sum(m4_temp);
clear m4 k

% Determine Parameters of interest

Box.BS_Hm0 = 4*sqrt(Box.BS_m0);
Box.BS_T02 = sqrt(Box.BS_m0/Box.BS_m2);
Box.BS_Te= (Box.BS_m_1/Box.BS_m0);

%% Calculate Bretschneider Spectrum based on Hm0 and T02 from the average
% spectrum

B_alt = (0.751/Box.BS_T02)^4;
A_alt = B_alt*(Box.BS_Hm0^2)/4;

Box.BS_alt = (A_alt.*Box.BS_freq(1,:).^(-5)).*exp(-B_alt.*Box.BS_freq(1,:).^(-4));

%% Calculate Bretschneider Spectrum based on Hm0 and T02 from centre of the
% box
% spectrum

B_centre = (0.751/((Tmax(m)+Tmin(m))/2))^4;
A_centre = B_centre*(((Hmax(m)+Hmin(m))/2)^2)/4;

Box.BS_centre = (A_centre.*Box.BS_freq(1,:).^(-5)).*exp(-B_centre.*Box.BS_freq(1,:).^(-4));


%%
% plot of all spectra + upper/lower bound + monthly average
    subplot((length(Hmin))/2,2,m)
          hold on
for i=1:Box.Spec_No

    specplot(:,i)=plot(Box.freq(:,1)',Box.Spec(:,i),'-','Color',[.8 .8 .8]);
    

   
   
   

    hold on
end

SpecGroup = hggroup;
set(specplot,'Parent',SpecGroup)
set(get(get(SpecGroup,'Annotation'),'LegendInformation'),'IconDisplayStyle','on');
% plot(Box.freq(:,1),Box.Upper_Bound,'-k',Box.freq(:,1),Box.Lower_Bound,'-k',Box.freq(:,1),Box.Avg_Spectrum,'-b',Box.BS_freq,Box.BS,'-r',Box.BS_freq,Box.BS_alt,'-c',Box.BS_freq,Box.BS_centre,'-m');
% plot(Box.freq(:,1),Box.Upper_Bound,'-k',Box.freq(:,1),Box.Lower_Bound,'-k',Box.freq(:,1),Box.Avg_Spectrum,'-b',Box.BS_freq,Box.BS_centre,'-r',Box.BS_freq,Box.JS,'-m');
plot(Box.freq(:,1),Box.Upper_Bound,'-k',Box.freq(:,1),Box.Lower_Bound,'-k',Box.freq(:,1),Box.Avg_Spectrum,'-b',Box.freq(:,1),Box.BS,'-r',Box.BS_freq,Box.JS,'-m',Box.BS_freq,Box.PMS,'-c');
head = title({['H_m_0 = ',num2str(Hmin(m)),'-',num2str(Hmax(m)),'m  T_0_2 = ',num2str(Tmin(m)),'-',num2str(Tmax(m)),'s']});
set(head, 'fontname', 'times new roman', 'fontsize', 14,...
    'fontweight', 'bold')
% h = legend('All Spectra','Upper Bound','Lower Bound','Average Spectrum','Bretschneider Spectrum (Avg summary stats)','Bretschneider Spectrum (Avg spectrum)','Bretschneider Spectrum (centre of box)');
% legend('All Spectra','Upper Bound','Lower Bound','Average Spectrum','Bretschneider Spectrum ','JONSWAP (\gamma = 3.3)')
legend('All Spectra','Upper Bound','Lower Bound','Average Spectrum','Bretschneider Spectrum ','JONSWAP (\gamma = 3.3)','Pierson Moskowitz Spectrum')
xlabel('frequency [Hz]','fontweight', 'bold','FontSize',14)
ylabel('S(f) [m^2/Hz] ','fontweight', 'bold','FontSize',14)
set(gca,'Fontsize',12)
xlim([0 inf])
grid minor
end
% p=mtit(Data.Location,'fontsize',14);
end

