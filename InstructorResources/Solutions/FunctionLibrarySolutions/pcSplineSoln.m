function [yNew,d] = pcSplineSoln(xData,yData,xNew)
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
n = length(xData);

% %% Calculate the vector of values h where
% h(i) = h_i = xData(i+1)-xData(i)
h = xData(2:end)-xData(1:end-1);

% %% Calculate the vector of slopes m where 
% m(i) = m_i = (y_(i+1)-y_i)/h(i)
% Remember to use pointwise operations
m = (yData(2:end)-yData(1:end-1))./h;

% %% Set up the vector r
% r(1) = 5/2m_1 + 1/2m_2   and    r(n) = 1/2m_(n-2)+5/2m_n-1
% with the middle values all given by
% r(i) = 3*(h(i)m(i-1)+h(i-1)*m(i))
% Remember to use pointwise operations
r = nan(n,1);
r(1) = 5/2*m(1)+m(2)/2;
r(n) = m(n-2)/2+5/2*m(n-1);
r(2:n-1) = 3*(h(2:n-1).*m(1:n-2)+h(1:n-2).*m(2:n-1));


% %% Set up the vectors of diagonals for A
mainDiag = ones(1,n);
plus1Diag = mainDiag(1:end-1);
minus1Diag = mainDiag(1:end-1);

% mainDiag(1) = h_2   and   mainDiag(n) = h_(n-2)
% with the middle values all given by 
% mainDiag(i) = 2(h_(i-1)+h_i)
mainDiag(1) = h(2);
mainDiag(n) = h(n-2);
mainDiag(2:n-1) = 2*(h(1:n-2)+h(2:n-1));
 
% plus1Diag(1) = h_2+h_1    and   plus1Diag(i) = h_(i-1)
plus1Diag(1) = h(2)+h(1);
plus1Diag(2:end) = h(1:n-2);
% minus1Diag(n-1) = h_(n-1)+h_(n-2)   and    minus1Diag(i) = h_(i+1)
minus1Diag(n-1) = h(n-1)+h(n-2);
minus1Diag(1:end-1) = h(2:n-1);

% Set up the matrix A as a sparse tridiagonal matrix
A = gallery("tridiag",minus1Diag,mainDiag,plus1Diag);

% Use matrix operations to solve for the values of d
d = A\r;

% %% Set up the coefficients for P(x) in each interval where
% xData(k) <= x < xData(k+1) and P_k(x) = a3*s^3+a2*s^2+a1*s+a0
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