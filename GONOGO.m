%----Go/No-Go System----%

%%Organised Priority System%%

%%--------------Make Ship Structs--------------%%
[num txt raw]=xlsread('Ships.xlsx')
[rows,numVars]=size(raw);
for ShipInd=2:rows
    ShipName=txt{ShipInd,1}
    ShipName=genvarname(ShipName)   
for varInd=2:numVars
    varName=txt{1,varInd};
    varName=genvarname(varName);
    stringData=txt(2:end,varInd);
    strInds=~cellfun(@isempty,stringData);
    
    if( any(strInds) )
        varData={};    
        try %#ok<TRYNC>
            varData=num2cell( raw(ShipInd,varInd) );
        end
        varData(strInds)=stringData(strInds); %#ok<AGROW>     
    else
        varData=cell2mat(raw(ShipInd,varInd));        
               
        if(flag)
            varData=num2cell(varData);
        end       
    end
    if(flag)
        [Ship(1:length(varData)).(varName)]=deal(varData{:});
    else
        Ship.(ShipName).(varName)=varData;
    end
end
end

%%--------------Probability of bottom touching--------------%%
% P_BottomTouch=1-exp(-Tp*sqrt(m2/m0)*exp(-KC^2/(2*m0)));
% lambda=sqrt(m2/m0)*exp(-KC^2/(2*m0));
% P_BottomTouchAlt=1-exp(-lambda*Tp);

%%--------------Required depth for passing--------------%%

%Draught and initial trim - Known

%Squat - Downward displacement of a vessel moving along a waterway
%presenting bottom or side restriction

%Ship Motion in waves - Need RAOs

%Lpp=Ship.Length;
%iv=Ship.Volume
%Tuck/Taylor solution for maximum squat
WaterDepthCD=16.3; %Conservative Minimum
C=1.75; %Local Constant(function of hull form)
Lpp=258;
iv=139700;
KnotSpeed=4;
Fh=(KnotSpeed*.514444)/(sqrt(9.81*WaterDepthCD));
Zv=C*iv*((Fh^2)/(Lpp^2)*sqrt(1-Fh^2)); %Tuck/Taylor Maximum Squat

%%--------------Overall Determination of GO/NO-GO--------------%%

Z=WD-DR-SQ-A1_Percent

%WD= Water Depth
%DR= Draught
%SQ= Squat
%A1%= Maximum vertical motion amplitude due to waves (chance of exceeding
%during passage =1%)

