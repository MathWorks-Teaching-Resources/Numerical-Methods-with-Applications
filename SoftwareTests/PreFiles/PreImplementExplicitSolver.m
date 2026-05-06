%  Pre-run script for ImplementExplicitSolver.mlx
% ---- Known Issues     -----
KnownIssuesID = "MATLAB:badsubscript";
% ---- Pre-run commands -----
 
open = @(str)MyOpen(str);

function MyOpen(str)
assert(exist(str,"file"))
disp("Open the file " + str)
end