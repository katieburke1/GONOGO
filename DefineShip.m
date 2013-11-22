function varargout = DefineShip(varargin)
% DEFINESHIP MATLAB code for DefineShip.fig
%      DEFINESHIP, by itself, creates a new DEFINESHIP or raises the existing
%      singleton*.
%
%      H = DEFINESHIP returns the handle to a new DEFINESHIP or the handle to
%      the existing singleton*.
%
%      DEFINESHIP('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in DEFINESHIP.M with the given input arguments.
%
%      DEFINESHIP('Property','Value',...) creates a new DEFINESHIP or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before DefineShip_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to DefineShip_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help DefineShip

% Last Modified by GUIDE v2.5 18-Sep-2013 12:09:39

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @DefineShip_OpeningFcn, ...
                   'gui_OutputFcn',  @DefineShip_OutputFcn, ...
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


% --- Executes just before DefineShip is made visible.
function DefineShip_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to DefineShip (see VARARGIN)

% Choose default command line output for DefineShip
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);

% UIWAIT makes DefineShip wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = DefineShip_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

NewShipDetails=struct('Displacement',str2num(get(handles.Displacement,'string')),'Deadweight',str2num(get(handles.Deadweight,'string')),'Length',str2num(get(handles.Length,'string')),'Beam',str2num(get(handles.Beam,'string')),'Draft',str2num(get(handles.Draft,'string')),'IncomingDraft',str2num(get(handles.IncomingDraft,'string')))
NewShipName=get(handles.ShipName,'String');
setappdata(0,'NewShipDetails',NewShipDetails);
setappdata(0,'NewShipName',NewShipName);
close()

function Deadweight_Callback(hObject, eventdata, handles)
% hObject    handle to Deadweight (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Deadweight as text
%        str2double(get(hObject,'String')) returns contents of Deadweight as a double


% --- Executes during object creation, after setting all properties.
function Deadweight_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Deadweight (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Length_Callback(hObject, eventdata, handles)
% hObject    handle to Length (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Length as text
%        str2double(get(hObject,'String')) returns contents of Length as a double


% --- Executes during object creation, after setting all properties.
function Length_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Length (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Beam_Callback(hObject, eventdata, handles)
% hObject    handle to Beam (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Beam as text
%        str2double(get(hObject,'String')) returns contents of Beam as a double


% --- Executes during object creation, after setting all properties.
function Beam_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Beam (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Draft_Callback(hObject, eventdata, handles)
% hObject    handle to Draft (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Draft as text
%        str2double(get(hObject,'String')) returns contents of Draft as a double


% --- Executes during object creation, after setting all properties.
function Draft_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Draft (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function IncomingDraft_Callback(hObject, eventdata, handles)
% hObject    handle to IncomingDraft (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of IncomingDraft as text
%        str2double(get(hObject,'String')) returns contents of IncomingDraft as a double


% --- Executes during object creation, after setting all properties.
function IncomingDraft_CreateFcn(hObject, eventdata, handles)
% hObject    handle to IncomingDraft (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function ShipName_Callback(hObject, eventdata, handles)
% hObject    handle to ShipName (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of ShipName as text
%        str2double(get(hObject,'String')) returns contents of ShipName as a double


% --- Executes during object creation, after setting all properties.
function ShipName_CreateFcn(hObject, eventdata, handles)
% hObject    handle to ShipName (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function Displacement_Callback(hObject, eventdata, handles)
% hObject    handle to Displacement (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of Displacement as text
%        str2double(get(hObject,'String')) returns contents of Displacement as a double


% --- Executes during object creation, after setting all properties.
function Displacement_CreateFcn(hObject, eventdata, handles)
% hObject    handle to Displacement (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
