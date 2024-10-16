function yNew = pcHInterpSoln(xData,yData,xNew)
% xData is assumed to be a uniformly increasing vector and all values
% xNew should be contained in the interval [xData(1),xData(end)]
% Use the piecewise cubic spline formulas defined in interpolation.m
% to compute interpolated values yNew at points xNew

% %% Ensure that xData and yData are column vectors
[xRows,~] = size(xData);
[yRows,~] = size(yData);
if xRows == 1
    xData = xData';
end
if yRows == 1
    yData = yData';
end

% %% Set up the value of n = number of intervals between points in xData
n = length(xData);

% %% Calculate the vector of values h where
% h(i) = h_i = xData(i+1)-xData(i)
h = xData(2:end)-xData(1:end-1);

% %% Calculate the vector of slopes m where 
% m(i) = m_i = (y_(i+1)-y_i)/h(i)
% Remember to use pointwise operations
m = (yData(2:end)-yData(1:end-1))./h;

% %% Determine the values of the slopes for the interpolant
d = nan(n,1);
% %% Start by calculating the slopes at interior points 
% If the sign of the slope changes between xData(i-1) and xData(i+1), or 
% if the slope is 0 in interval i-1 or i, set d(i) to be 0.
% Otherwise, use a weighted centered difference approximation 
% where (w1+w2)/d(i) = w1/m(i-1)+w2/m(i)
% with w1 = 2*h(i)+h(i-1) and w2 = 2*h(i-1)+h(i)
for i = 2:n-1
    if m(i-1) == 0 || m(i)/m(i-1) <= 0
        % Check for local minima or maxima
        d(i) = 0;
    else
        % Compute weights
        w1 = 2*h(i)+h(i-1);
        w2 = 2*h(i-1)+h(i);
        d(i) = (w1+w2)/(w1/m(i-1)+w2/m(i));
    end
end

% Add the slopes at i=1 and i=n using the formula
% ((2*h1+h2)*m1-h1*m2)/(h1+h2) where 
% h1 is the length of the first step back/forward and 
% h2 is the length of the second step back/foward and
% m1 is the slope over the first interval back/forward and 
% m2 is the slope over the second interval back/forward
d(1) = ((2*h(1)+h(2))*m(1)-h(1)*m(2))/(h(1)+h(2));
d(n) = ((2*h(n-1)+h(n-2))*m(n-1)-h(n-1)*m(n-2))/(h(n-1)+h(n-2));

d(1) = checkOvershoot(d(1),m(1),m(2));
d(n) = checkOvershoot(d(n),m(n-1),m(n-2));

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
function d = checkOvershoot(d,m1,m2)
if sign(d) ~= sign(m1)
    d=0;
elseif sign(d) ~= sign(m2) & (abs(d)>abs(3*m1))
    d = 3*m1;
end
end

