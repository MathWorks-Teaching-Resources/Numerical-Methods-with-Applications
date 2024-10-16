%  Pre-run script for MeasureLakeArea.mlx
% ---- Known Issues     -----
KnownIssuesID = "";
% ---- Pre-run commands -----

load lakeData.mat lakeX lakeY
[~,idx] = max(diff(lakeX));
x = lakeX([idx:end 1:idx-1]);
y = lakeY([idx:end 1:idx-1]);
p.Position = [x y];
drawpolygon = p; 
openfig = @(in)figure;