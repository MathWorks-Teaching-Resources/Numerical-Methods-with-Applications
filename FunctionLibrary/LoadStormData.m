%[text] # Download Hurricane Data
%[text] This script downloads, processes, and saves external electricity load data from the [NOAA Hurricane database](https://www.nhc.noaa.gov/data/hurdat/).
%[text] Use this script in a controls-only mode (default) by using the **Hide code** ![live script code hidden icon](text:image:49a0) button, or view the code by using the **Output inline** ![live script output inline icon](text:image:3ebc) button from the **View** tab of the MATLAB toolstrip.
%[text] Click **Run** to start the download. 
  %[control:button:96cb]{"position":[1,2]}
%[text] Once complete, you will have added two files to your Data folder:
%[text] 1. `allStorms.csv`
%[text] 2. `allStorms.mat` \
% Download file and save to the chosen location
% Name of the csv file on the NOAA site.
filename = "hurdat2-nepac-1949-2020-043021a.txt";

% Location of the csv file on the NOAA site.
url = "https://www.nhc.noaa.gov/data/hurdat/" + filename;

% Destination on local computer.
proj = currentProject;
DataLoc = fullfile(proj.RootFolder,"Data");
filedestination = fullfile(DataLoc,"allStorms.csv");
if exist(filedestination,"file")
    disp("allStorms.csv exists, no new download needed")
else
disp("Downloading allStorms.csv -> " + filedestination)
try
    % Save from web to local folder.
    websave(filedestination,url);
    disp("Download complete.");
catch ME
    disp("Failure: " + ME.message);
end    
end

% Read the data from the csv into a struct 
allStorms = readStorms("allStorms.csv");

% Save the MAT file containing raw data.
save(fullfile(DataLoc,"allStorms.mat"),"allStorms")
disp("MAT files saved in " + DataLoc);

%%
%%
%[text] ## Help us Improve
%[text] [Share your feedback](<matlab: ShareFeedback>) to help us improve this module.
function allStorms = readStorms(hurdat)
% readStorms processes data from the hurdat file format into
% a MATLAB struct containing the Name of the storm, the Year of the storm
% and the Lat and Long (latitude and longitude) of the storm every 6 hours.
%
% UNNAMED storms are stripped from the dataset

% Initialize the structure with appropriate fields
allStorms = struct("Name",[],"Year",[],"StartTime",[],"EndTime",[],"Lat",{},"Long",{});

% Initialize a count of named storms
idx = 1;

% Create a format string that matches the data lines of a hurdat file
fmtstr = ['%f %f %*1c %2c %f%1c %f%1c ' repmat('%f ',1,14)];

% Open a handle to the file and read through it until you reach the end
fid = fopen(hurdat);
while ~feof(fid)
    % Read the header line
    l = fgetl(fid);

    % Extract the name of a storm from the header line
    out = regexp(l,"\s[A-Z]+","match");

    % Extract the information about that storm from the next block
    d = textscan(fid,fmtstr,"Delimiter",",");

    % If the storm has a name, add the desired information to the struct
    % allStorms at index idx
    if ~strcmp(out{1},' UNNAMED')
        allStorms(idx).Name = string(out{1}(2:end));
        ymdS = d{1}(1);
        sDay = mod(ymdS,100);
        sMon = (mod(ymdS,10000)-sDay)/100;
        sYear = floor(ymdS/10000);
        sHour = floor(d{2}(1)./100);
        ymdE = d{1}(end);
        eDay =  mod(ymdE,100);
        eMon = (mod(ymdE,10000)-eDay)/100;
        eYear = floor(ymdE/10000);
        eHour = floor(d{2}(end)./100);
        allStorms(idx).Year = string(l(5:8));
        allStorms(idx).StartTime = datetime(sYear,sMon,sDay,sHour,0,0);
        allStorms(idx).EndTime = datetime(eYear,eMon,eDay,eHour,0,0);
        LatSign = d{5}=='N'; 
        LatSign = LatSign-~LatSign;
        allStorms(idx).Lat = LatSign.*d{4};
        LonSign = d{7}=='E';
        LonSign = LonSign-~LonSign;
        allStorms(idx).Long = LonSign.*d{6};
        idx = idx+1;
    end
end
fclose all ;
end

%[appendix]{"version":"1.0"}
%---
%[metadata:view]
%   data: {"layout":"hidecode","rightPanelPercent":40}
%---
%[text:image:49a0]
%   data: {"align":"middle","height":24,"src":"data:image\/png;base64,iVBORw0KGgoAAAANSUhEUgAAABgAAAAYCAYAAADgdz34AAAArElEQVR42mP4\/\/8\/AwgnJiYapKamfgfS\/ynBUDMMYOYywBggiYcPH\/6nFIDMAJmFYQHIdmoBqFm4LZjrYPd\/gpoyGIPYVLeA5j4gbEASHJNlwZYtW\/93dHTixDCDQTRMDKRn8FhATBDNmTOH\/CAiBI4cOQI2HETTLBW9fv2a\/FRUtPXVf\/WeuyRhkB6iLQBp2HLvP0kYpGfUglELhpMFNM9oNKlw6FHp06TZAgAoeVix9Bg9oQAAAABJRU5ErkJggg==","width":24}
%---
%[text:image:3ebc]
%   data: {"align":"middle","height":24,"src":"data:image\/png;base64,iVBORw0KGgoAAAANSUhEUgAAABgAAAAYCAYAAADgdz34AAAAjElEQVR42mP4\/\/8\/AwgnJiYapKamfgfS\/ynBUDMMYOYywBggiYcPH\/6nFIDMAJmFYQHIdmoBqFm4LZjrYPd\/gpoyGIPYVLeA5j6gmwUlJaVAxUlgDGKPBhFODaQG1QgIoqKtr\/6r99wlCYP0EG0BSMOWe\/9JwiA9oxaMWkBHC2ieD2iSk+lR6dOk2QIAjF+EgB\/BqfoAAAAASUVORK5CYII=","width":24}
%---
%[control:button:96cb]
%   data: {"label":"Run","run":"Section"}
%---
