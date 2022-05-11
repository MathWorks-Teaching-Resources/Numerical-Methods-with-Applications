function yNew = linInterpSoln(xData,yData,xNew)
% linInterp interpolates the points (xNew(i),yNew(i)) using a 
% piecewise linear interpolation on the input data xData and
% output data yData


% Initialize output values vector
yNew = nan(size(xNew));

% Determine if xData is increasing or decreasing
%
% Decide if you are going to redefine xData and yData to be only 
% increasing (or only decreasing) or if you are going to handle 
% each case separately

% Check each value in xNew and determine its 
% corresponding interpolated value in yNew


end