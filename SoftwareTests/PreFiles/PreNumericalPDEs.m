%  Pre-run script for NumericalPDEs.m
% ---- Known Issues     -----
KnownIssuesID = "";
% ---- Pre-run commands -----
 
open = @(str)MyOpen(str);
edit = @(str)MyOpen(str);
% <matlab:ShareFeedback Share your feedback>

function MyOpen(str)
assert(exist(str,"file"))
disp("Open the file " + str)
end