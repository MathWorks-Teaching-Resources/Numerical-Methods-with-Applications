function Startup
% Open the overview file
locDir = pwd;
if contains(locDir,filesep+"MATLAB Drive")
    open("NavigationOverview.mlx")
else
    open("Overview.html")
end

end