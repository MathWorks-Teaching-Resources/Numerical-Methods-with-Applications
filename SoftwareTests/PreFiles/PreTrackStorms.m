%  Pre-run script for TrackStorms.mlx
% ---- Known Issues     -----
KnownIssuesID = "";
% ---- Pre-run commands -----
 
LoadStormData = "Load storm data";

if ~exist("allStorms.mat","file")
    copyfile("myStorm.mat",fullfile(currentProject().RootFolder,"Data","allStorms.mat")) 
end

pause = @(t)MyPause(t);

function MyPause(t)
end