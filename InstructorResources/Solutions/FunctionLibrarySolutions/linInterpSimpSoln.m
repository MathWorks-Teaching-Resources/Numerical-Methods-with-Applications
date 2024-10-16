function yNew = linInterpSimp(xData,yData,xNew)
% linInterp interpolates the point(s) (xNew(i),yNew(i)) using a 
% piecewise linear interpolation on the input data xData
% and output data yData

% Initialize output values vector
yNew = nan(size(xNew));

% Is xData decreasing?
if xData(2)-xData(1) < 0
    % Reorder xData and yData so that xData is increasing
    xData = xData(end:-1:1);
    yData = yData(end:-1:1);
end

% Check each value in xNew and determine its 
% corresponding interpolated value in yNew
for k = 1:length(xNew)
    curVal = xNew(k);
    for j = 1:length(xData)-1
        if curVal == xData(j)
            yNew(k) = yData(j);
        elseif (xData(j) < curVal) && (curVal < xData(j+1))
            yNew(k) = yData(j) + (curVal - xData(j))*(yData(j+1)-yData(j))/(xData(j+1)-xData(j));
        end
    end
    if curVal == xData(end)
        yNew = yData(end);
    end
end

end