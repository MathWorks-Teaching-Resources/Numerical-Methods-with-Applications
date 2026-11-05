%  Pre-run script for Interpolation.m
% ---- Known Issues     -----
KnownIssuesID = "";
% ---- Pre-run commands -----
 
open = @(str)MyOpen(str);
% <matlab:ShareFeedback Share your feedback>

function MyOpen(str)
assert(exist(str,"file"))
disp("Open the file " + str)
end