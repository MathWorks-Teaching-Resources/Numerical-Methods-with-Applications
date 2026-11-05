%  Pre-run script for Hand.m
% ---- Known Issues     -----
KnownIssuesID = "";
% ---- Pre-run commands -----

CollectData = @()NewCollectData();
% <matlab:ShareFeedback Share your feedback>

function varargout = NewCollectData()
    load("drawing.mat","x","y")
    varargout = {x,y}
end