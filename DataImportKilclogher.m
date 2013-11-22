function [Waterlevel] = DataImportKilclogher() 
StartingFolder = pwd;
h1 = warndlg('Please Select the file you wish to use','Data importer');
waitfor(h1);
[file_name,path_name] = uigetfile( {'*.*',  'All Files (*.*)'},'Please choose a file');
waitfor(path_name>1);
file=strcat(num2str(file_name));
path=strcat(path_name);
%
cd(path); 
%
h2 = waitbar(0,'Please wait...','name','Importing Data');
steps = 1;
for step = 1:steps
    [Alldat]=importdata(file);
    waitbar(step / steps);
end

if isstruct(Alldat)==1
Waterlevel=Alldat.data;
Textdata=Alldat.textdata;
cd(StartingFolder);
else
Waterlevel=Alldat;
Waterlevel=Waterlevel/100;
Textdata=[];
cd(StartingFolder);
end
Waterlevel=horzcat(Waterlevel(:));
Waterlevel=(filterTide(Waterlevel))';
setappdata(0,'Waterlevel',Waterlevel);
AvgWaterlevel=mean(Waterlevel);
firstplot=figure;
plot(Waterlevel);
hold on
plot(1:length(Waterlevel),AvgWaterlevel,'r');
xlabel('Timestamp');
ylabel('Microticks/sq. ft.');
secondplot=figure;
plot(Waterlevel-AvgWaterlevel);
hold on
plot(1:length(Waterlevel),AvgWaterlevel,'r');
xlabel('Timestamp');
ylabel('Microticks/sq. ft.');
close(h2);
%Kilclogher_Spectrum
end





