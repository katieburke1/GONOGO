function varargout = GONOGOGUI(varargin)
% GONOGOGUI MATLAB code for GONOGOGUI.fig
%      GONOGOGUI, by itself, creates a new GONOGOGUI or raises the existing
%      singleton*.
%
%      H = GONOGOGUI returns the handle to a new GONOGOGUI or the handle to
%      the existing singleton*.
%
%      GONOGOGUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GONOGOGUI.M with the given input arguments.
%
%      GONOGOGUI('Property','Value',...) creates a new GONOGOGUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GONOGOGUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GONOGOGUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GONOGOGUI

% Last Modified by GUIDE v2.5 19-Sep-2013 17:23:21

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GONOGOGUI_OpeningFcn, ...
                   'gui_OutputFcn',  @GONOGOGUI_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT


% --- Executes just before GONOGOGUI is made visible.
function GONOGOGUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GONOGOGUI (see VARARGIN)
% Choose default command line output for GONOGOGUI
handles.output = hObject;
Ship_Import(hObject,eventdata,handles);


% --- Outputs from this function are returned to the command line.
function varargout = GONOGOGUI_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes during object creation, after setting all properties.
function LocationListbox_CreateFcn(hObject, eventdata, handles)
% hObject    handle to LocationListbox (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --- Executes during object creation, after setting all properties.
function text1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to text1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called


% --- Executes on selection change in ShipChoiceDrpDwn.
function ShipChoiceDrpDwn_Callback(hObject, eventdata, handles)
% hObject    handle to ShipChoiceDrpDwn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns ShipChoiceDrpDwn contents as cell array
%        contents{get(hObject,'Value')} returns selected item from ShipChoiceDrpDwn
Ships=get(handles.ShipChoiceDrpDwn,'string');
Shipval=get(handles.ShipChoiceDrpDwn,'value');
handles.ShipChoice=Ships{Shipval};
handles.SelectedShipData=(handles.Ship.(Ships{Shipval}));
guidata(hObject,handles);
%struct2dataset(handles.Ship.(Ships{Shipval}))

% --- Executes during object creation, after setting all properties.
function ShipChoiceDrpDwn_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ShipChoiceDrpDwn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in NewShipDataBtn.
function NewShipDataBtn_Callback(hObject, eventdata, handles)
% hObject    handle to NewShipDataBtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
DefineShip();
waitfor(DefineShip)
handles.NewShipData=getappdata(0,'NewShipDetails');
handles.NewShipName=getappdata(0,'NewShipName');
%WriteCell=(struct2cell(handles.NewShipData));
Name=handles.NewShipName;
Data=handles.NewShipData
%WriteCell2=[Name;WriteCell];
fid=fopen('Ships.csv','a')
fprintf(fid,'%s, %g, %g, %g, %g, %g, %g,\n',Name,Data.Deadweight,Data.Length,Data.Beam,Data.Draft,Data.IncomingDraft,Data.Displacement);
fclose(fid);
[handles]=Ship_Import(hObject,eventdata,handles);
guidata(hObject,handles);

function WaterDepth_Callback(hObject, eventdata, handles)

function WaterDepth_CreateFcn(hObject, eventdata, handles)

if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in SeeShipDataBtn.
function SeeShipDataBtn_Callback(hObject, eventdata, handles)
% hObject    handle to SeeShipDataBtn (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
SelectedShipData=handles.SelectedShipData;
AllVars=dataset2cell(dataset(SelectedShipData))';
set(handles.ShipDetailTable,'ColumnName',{'Characteristic' 'Value'},'ColumnWidth',{220 175},'Data',AllVars);


% --- Executes during object creation, after setting all properties.
function ShipDetailTable_CreateFcn(hObject, eventdata, handles)

function PollBuoy_Callback(hObject, eventdata, handles)
DataImportKilclogher();
Waterlevel=getappdata(0,'Waterlevel');
Waterlevel=horzcat(Waterlevel(:));
Waterlevel=(filterTide(Waterlevel))';
handles.Waterlevel=Waterlevel;
guidata(hObject,handles);

% --- Executes on button press in DoCalcs.
function DoCalcs_Callback(hObject, eventdata, handles)
% hObject    handle to DoCalcs (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
%%-----Basic Parameters-----%%
WaterDepth=handles.WaterDepth;
SelectedShipData=handles.SelectedShipData;
KnotSpeed=str2num(get(handles.KnotSpeed,'String'));
MetersSpeed=KnotSpeed*.514444;
TravelTime=3000/MetersSpeed;
WaterDepth=str2num(get(handles.WaterDepth,'string'));
Draft=handles.SelectedShipData.Draft;
Waterlevel=handles.Waterlevel;

%%-----Calculate Ship Squat-----%%
[ShipSquat]=Squat_Calculation(hObject, eventdata, handles);


%%-----Calculate Wave Spectral parameters-----%%
SampleFreq=3;
[Hm0,T1,T02,Tp0,Te,~,freq,m0,m2] = GUISpectra(Waterlevel,SampleFreq);
Hs=4*sqrt(m0);
setappdata(0,'UWotM2',m2);
Za_one_third=2*sqrt(m0);

%%-----Next Steps----%%
%From here we must use the response spectrum to determine the movement of the ship
%S= .5*Za^2 %Spectral energy of wavespectrum
%S=(Za/Ampl)^2 * 0.5 Ampl^2 %Spectral energy of heave motion
%S=(Za/Ampl)^2 * S(W)
%SpectalDensityHeaving=(Za_one_third/calc);

%%-----Calculate Probability of Channel Bottom Touch-----%%
KC=WaterDepth-Draft-ShipSquat;
if KC <=0
P_BottomTouch=1
else
P_BottomTouch=1-exp(-Tp0*sqrt(m2/m0)*exp(-KC^2/(2*m0)))
end


%A1_Percent=
Z=WaterDepth-Draft-ShipSquat-A1_Percent;
set(handles.ShipZ,'string',Z);
% figajig=figure;
% loadsadsdasd=imread('KilclogherBarImage.png');
% image(loadsadsdasd);
% axis tight
% set(gca,'yticklabel',[])
% set(gca,'xticklabel',[])
% set(gca,'xtick',[])
% set(gca,'ytick',[])


function [handles]=Ship_Import(hObject,eventdata,handles)
[num txt raw]=xlsread('Ships.xls'); %Importation of ship option excel file
[rows,numVars]=size(raw);
countships=0;
for ShipInd=2:rows %Collects Ship Names0
    ShipName=txt{ShipInd,1};
    ShipName=genvarname(ShipName);
    countships=countships+1;
for varInd=2:numVars %Collects variable values
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
ShipNames{countships}=ShipName;
end
handles.Ship=Ship;
ShipList=ShipNames;
set(handles.ShipChoiceDrpDwn,'string',ShipList); %Gets available ship choices and populates the drop down menu with them.
set(handles.ShipDetailTable,'Data',{}); %Creating Neat Table for Ship Details. Does not populate.
handles.SelectedShipData=(handles.Ship.(ShipList{1}));
guidata(hObject, handles);


% --- Executes on button press in checkbox4.
function checkbox4_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of checkbox4

function [Zv]=Squat_Calculation(hObject, eventdata, handles)
KnotSpeed=str2num(get(handles.KnotSpeed,'String'));
WaterDepthCD=str2num(get(handles.WaterDepth,'String'));
MetersSpeed=KnotSpeed*.514444;
Fh=MetersSpeed/(sqrt(9.81*WaterDepthCD)); %Froude Depth number
C=[1.5 1.75 2];
ChannelWidth=handles.ChannelWidth;
if ChannelWidth>=9*handles.SelectedShipData.Beam
   ChannelWidth=9*handles.SelectedShipData.Beam;
end
Displacement=handles.SelectedShipData.Displacement;
Length=handles.SelectedShipData.Length;
Zv=C.*Displacement*((Fh^2)/(Length^2)*sqrt(1-Fh^2));
Zv=max(Zv);
Am=(handles.SelectedShipData.Beam*handles.SelectedShipData.Draft);
Ac=(ChannelWidth/WaterDepthCD);
Am_Ac=Am/Ac;
if Am_Ac<=0.032
    Am_Ac=0.032;
elseif Am_Ac>=0.15
    Am_Ac=0.15;
end
Eps=7.45*(Am_Ac)+.76;
Mod_Zv=Zv*Eps;
set(handles.MaxSquat,'string',Mod_Zv);



function KnotSpeed_Callback(hObject, eventdata, handles)
% hObject    handle to KnotSpeed (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of KnotSpeed as text
%        str2double(get(hObject,'String')) returns contents of KnotSpeed as a double


% --- Executes during object creation, after setting all properties.
function KnotSpeed_CreateFcn(hObject, eventdata, handles)
% hObject    handle to KnotSpeed (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function MaxSquat_Callback(hObject, eventdata, handles)
% hObject    handle to MaxSquat (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of MaxSquat as text
%        str2double(get(hObject,'String')) returns contents of MaxSquat as a double


% --- Executes during object creation, after setting all properties.
function MaxSquat_CreateFcn(hObject, eventdata, handles)
% hObject    handle to MaxSquat (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function MaxVerticalMotion_Callback(hObject, eventdata, handles)
% hObject    handle to MaxVerticalMotion (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of MaxVerticalMotion as text
%        str2double(get(hObject,'String')) returns contents of MaxVerticalMotion as a double


% --- Executes during object creation, after setting all properties.
function MaxVerticalMotion_CreateFcn(hObject, eventdata, handles)
% hObject    handle to MaxVerticalMotion (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ShipDraft_Callback(hObject, eventdata, handles)
% hObject    handle to ShipDraft (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ShipDraft as text
%        str2double(get(hObject,'String')) returns contents of ShipDraft as a double


% --- Executes during object creation, after setting all properties.
function ShipDraft_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ShipDraft (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ShipZ_Callback(hObject, eventdata, handles)
% hObject    handle to ShipZ (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ShipZ as text
%        str2double(get(hObject,'String')) returns contents of ShipZ as a double


% --- Executes during object creation, after setting all properties.
function ShipZ_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ShipZ (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ChannelWidth_Callback(hObject, eventdata, handles)
% hObject    handle to ChannelWidth (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ChannelWidth as text
%        str2double(get(hObject,'String')) returns contents of ChannelWidth as a double


% --- Executes during object creation, after setting all properties.
function ChannelWidth_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ChannelWidth (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
