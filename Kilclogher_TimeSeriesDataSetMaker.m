namefolder='C:\Users\hmrc\Dropbox\Final Year Project\Our Work\Kilclogher bar\Diwar\Files';
cd(namefolder)
files=dir(namefolder);
rangefiles=length(namefolder);
TSeriesdata=zeros(3072,rangefiles-2);
h2 = waitbar(0,'Please wait...','name','Importing Data');
for j=3:rangefiles;
    Fname=files(j).name;
    [Alldat]=importdata(Fname);
if isstruct(Alldat)==1
Waterlevel=Alldat.data;
Textdata=Alldat.textdata;
else
Waterlevel=Alldat;
Textdata=[];
end
Waterlevel=Waterlevel/100;
Waterlevel=horzcat(Waterlevel(:));
Waterlevel=(filterTide(Waterlevel))';
TSeriesdata(:,j-2)=Waterlevel;
    waitbar(j/(rangefiles-2));
end
close(h2);