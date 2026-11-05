%  Pre-run script for MeasureLakeAreaSoln.m
% ---- Known Issues     -----
KnownIssuesID = "";
% ---- Pre-run commands -----
load myLakeData.mat lakeX lakeY
[~,idx] = max(diff(lakeX));
x = lakeX([idx:end 1:idx-1]);
y = lakeY([idx:end 1:idx-1]);
p.Position = [x y];
drawpolygon = p; 
openfig = @(in)figure;

IdentifyLakeShape = @()LoadModernData();
MeasureGeoScale = @()LoadGeoScale();
% <matlab:ShareFeedback Share your feedback>

function roi = LoadModernData
load myModernLakeData.mat modLakeLat modLakeLong
out.Position = [modLakeLat modLakeLong];
roi=out;
end

function longScale = LoadGeoScale()
load myModernLakeData.mat longScale
end