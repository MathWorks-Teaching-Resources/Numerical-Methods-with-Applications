function yNew = linInterp(xData,yData,xNew)
% linInterp interpolates the point(s) (xNew(i),yNew(i)) using a 
% piecewise linear interpolation on the input data xData
% and output data yData

% Initialize output values vector
yNew = nan(size(xNew));

% Check whether the input values make sense and have the expected shape
if isvector(xData) && isvector(xNew)
    % Ensure that xData is a row vector
    if ~isrow(xData)
        xData = xData';
    end

    % Ensure that xNew is a row vector
    if ~isrow(xNew)
        xNew = xNew';
    end
else
    warning("The input data must be vectors.")
    return
end

if max(xNew)>max(xData) || min(xNew)<min(xData)
    warning("The requested values include extrapolation. " + ...
        "This function only computes interpolation.")
    return
end

% Initialize increase/decrease flag
flag = 0;

% Check if xData is monotonically increasing or decreasing
if nnz(diff(xData)>0) == length(xData)-1
    % xData is increasing
    flag = 1;
elseif nnz(diff(xData)<0) == length(xData)-1
    % xData is decreasing
    flag = -1;
else
    warning("The input data is not properly ordered. " + ...
        "The xData must be monotonic.")
    return
end

% Find the closest datapoint in xData for each value xNew
[distVal,idx] = min((xNew'-xData).^2,[],2);
midIdx = distVal~=0;

% Calculate the values of yNew that occur on values of yData
yNew(~midIdx) = yData(idx(~midIdx));
 
% Identify the indices of the endpoints of the relevant interval for 
% non-endpoint values of xNew
altEndPt = sign((xNew(midIdx)-xData(idx(midIdx))).*flag);

% if max(idx(altEndPt==0))< length(xData)
%     altEndPt(altEndPt==0) = 1;
% elseif min(idx(altEndPt==0))< length(xData)
rowIdx = idx';
endIdx = sort([rowIdx(midIdx);rowIdx(midIdx)+altEndPt]);

% Compute the x and y values of the endpoints
endxLeft = xData(endIdx(1,:)); 
endxRight = xData(endIdx(2,:));
endyLeft = yData(endIdx(1,:)); 
endyRight = yData(endIdx(2,:));


% Use point-slope form to evaluate yNew on intervior points
% y = y_1 + m*(x-x_1)
yNew(midIdx) = endyLeft + (endyRight-endyLeft)./(endxRight-endxLeft)...
    .*(xNew(midIdx)-endxLeft);

end