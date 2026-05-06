%  Pre-run script for TrackStorms.mlx
% ---- Known Issues     -----
KnownIssuesID = "MATLAB:FileIO:InvalidFid";
% ---- Pre-run commands -----

try
    LoadStormData
catch
end

pause = @(t)MyPause(t);

function MyPause(t)
end