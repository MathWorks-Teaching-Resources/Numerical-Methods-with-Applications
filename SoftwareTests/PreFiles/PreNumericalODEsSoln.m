%  Pre-run script for NumericalODEsSoln.mlx
% ---- Known Issues     -----
KnownIssuesID = "";
% ---- Pre-run commands -----
 
addpath(fullfile(currentProject().RootFolder,"InstructorResources","Solutions","FunctionLibrarySolutions"))

open = @(str)MyOpen(str);
edit = @(str)MyOpen(str);

function MyOpen(str)
assert(exist(str,"file"))
disp("Open the file " + str)
end