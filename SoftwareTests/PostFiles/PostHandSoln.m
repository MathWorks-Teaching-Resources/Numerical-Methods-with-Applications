%  Post-run script for HandSoln.m
% ---- Post-run commands -----

clear x y
if exist(fullfile(currentProject().RootFolder,"Data","testDrawing.mat"),"file")
    fp = fullfile(currentProject().RootFolder,"Data","testDrawing.mat");
    delete(fp)
end
% <matlab:ShareFeedback Share your feedback>

