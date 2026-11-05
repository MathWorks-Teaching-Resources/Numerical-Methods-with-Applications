%  Pre-run script for NumericalPDEsSoln.m
% ---- Known Issues     -----
KnownIssuesID = "";
% ---- Pre-run commands -----
 
addpath(fullfile(currentProject().RootFolder,"InstructorResources","Solutions","FunctionLibrarySolutions"))

open = @(str)MyOpen(str);
edit = @(str)MyOpen(str);
% <matlab:ShareFeedback Share your feedback>

function MyOpen(str)
assert(exist(str,"file"))
disp("Open the file " + str)
end