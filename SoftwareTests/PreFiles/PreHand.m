%  Pre-run script for Hand.mlx
% ---- Known Issues     -----
KnownIssuesID = "";
% ---- Pre-run commands -----

CollectData = @()NewCollectData();

function varargout = NewCollectData()
    load("drawing.mat","x","y")
    varargout = {x,y}
end