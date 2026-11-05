%  Post-run script for Hand.m
% ---- Post-run commands -----
 
clear x y
if exist(fullfile(currentProject().RootFolder,"Data","hand.mat"),"file")
    fp = fullfile(currentProject().RootFolder,"Data","hand.mat");
    delete(fp)
end
% <matlab:ShareFeedback Share your feedback>
