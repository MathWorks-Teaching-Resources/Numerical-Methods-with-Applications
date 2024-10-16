%  Post-run script for Hand.mlx
% ---- Post-run commands -----
 
clear x y
if exist(fullfile(currentProject().RootFolder,"Data","hand.mat"),"file")
    fp = fullfile(currentProject().RootFolder,"Data","hand.mat");
    delete(fp)
end