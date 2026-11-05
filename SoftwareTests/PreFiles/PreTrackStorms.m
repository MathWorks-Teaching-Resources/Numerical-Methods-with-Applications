%  Pre-run script for TrackStorms.m
% ---- Known Issues     -----
KnownIssuesID = "MATLAB:FileIO:InvalidFid";
% ---- Pre-run commands -----

try
    LoadStormData
catch
end

pause = @(t)MyPause(t);
% <matlab:ShareFeedback Share your feedback>

function MyPause(t)
end