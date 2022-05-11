function [yNew,d] = pcSpline(xData,yData,xNew)
% xData is assumed to be a uniformly increasing vector and all values
% xNew should be contained in the interval [xData(1),xData(end)]
% Use the piecewise cubic spline formulas defined in interpolation.m
% to compute interpolated values yNew at points xNew

% %% Ensure that xData and yData are both column vectors
[xRows,~] = size(xData);
[yRows,~] = size(yData);
if xRows == 1
    xData = xData';
end
if yRows == 1
    yData = yData';
end

% %% Set up the value of n = number of points in xData


% %% Calculate the vector of values h tracking the step sizes between
% points in xData


% %% Calculate the vector of slopes m tracking the slopes between 
% (xData(i),yData(i)) and (xData(i+1),yData(i+1))
% Remember to use pointwise operations


% %% Set up the vector r
% Remember to use pointwise operations


% %% Set up the vectors of diagonals for A
mainDiag = ones(1,n);
plus1Diag = mainDiag(1:end-1);
minus1Diag = mainDiag(1:end-1);

% Set up the values on the main diagonal


% Set up the values on the upper diagonal


% Set up the values on the lower diagonal


% Set up the matrix A as a sparse tridiagonal matrix
A = gallery("tridiag",minus1Diag,mainDiag,plus1Diag);

% Use matrix operations to solve for the values of d
d = A\r;

% %% Set up the coefficients for P(x) in each interval where
% xData(k) <= x < xData(k+1) and P_k(x) = a3*s^3+a2*s^2+a1*s+a0
% You may want to check that this is equivalent to the other formulations
% you have seen for the coefficients
a3 = -2*m+d(1:end-1)+d(2:end);
a2 = 3*m-2*d(1:end-1)-d(2:end);
a1 = d(1:end-1);
a0 = yData(1:end-1);

% %% Initialize the output vector yNew
yNew = nan(size(xNew));

% %% Loop over all entries in xNew and compute the interpolated value
for i = 1:length(xNew)
    % For each value xNew(i), determine the value k such that
    % xData(k) <= xNew(i) < xData(k+1)
    j = 1;
    while xData(j) <= xNew(i) && j < length(xData)
        k=j;
        j = j+1;
    end
    if xNew(i)==xData(end)
        yNew(i) = yData(end);
    else
        % Evaluate the local variables s = xNew(i)-x_k
        s = xNew(i)-xData(k);
        % Use the polynomial formula P_k(x) to evaluate yNew = P_k(xNew(i))
        yNew(i) = a3(k)*s^3+a2(k)*s^2+a1(k)*s+a0(k);
    end
end
end