function [x,y] = CollectData()
% figure('position',get(0,'screensize'))
% figure("WindowState","maximized")
figure
axes('position',[0 0 1 1])
grid on
grid minor
str = ["Select control points around your image by clicking and then double-click ", ...
    "to finish data collection. Close the figure window to return to the script."];
annotation("textbox",[.05 .9 .1 .1],"String",str,"FitBoxToText","on")
ax = gca;
roi = drawpolygon(ax);
x = roi.Position(:,1);
y = roi.Position(:,2);
end