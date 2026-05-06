%  Pre-run script for NumericalPDEs.mlx
% ---- Known Issues     -----
KnownIssuesID = "";
% ---- Pre-run commands -----
 
open = @(str)MyOpen(str);
edit = @(str)MyOpen(str);

function MyOpen(str)
assert(exist(str,"file"))
disp("Open the file " + str)
end