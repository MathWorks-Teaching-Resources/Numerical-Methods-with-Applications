function Startup
% Open the overview file
locDir = pwd;
if contains(locDir,filesep+"MATLAB Drive")
    open("Navigation.mlx")
else
    open("Overview.html")
end

end