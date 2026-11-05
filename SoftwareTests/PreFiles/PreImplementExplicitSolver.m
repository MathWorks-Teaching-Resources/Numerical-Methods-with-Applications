%  Pre-run script for ImplementExplicitSolver.m
% ---- Known Issues     -----
KnownIssuesID = "MATLAB:badsubscript";
% ---- Pre-run commands -----
 
open = @(str)MyOpen(str);
% <matlab:ShareFeedback Share your feedback>

function MyOpen(str)
assert(exist(str,"file"))
disp("Open the file " + str)
end