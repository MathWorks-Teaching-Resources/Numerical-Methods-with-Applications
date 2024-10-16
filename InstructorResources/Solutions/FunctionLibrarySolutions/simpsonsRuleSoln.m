function area = simpsonsRuleSoln(f,a,b,n)
% simpsonsRule takes four arguments
% f is a function handle
% a and b are the endpoints of the integral
% n is the number of intervals to use for the approximation
%
% area is the value computed by using a three-point Simpson's rule
% approximation on each subinterval

% Discretize the function on the endpoints of the intervals
endPts = linspace(a,b,n+1);
fEndpts = f(endPts);

% Discretize the function on the midpoints of the intervals
midPts = (endPts(2:end)+endPts(1:end-1))/2;
fMidpts = f(midPts);

% Combine the terms via the (h/3)*(f(a) + 4*f((b+a)/2) + f(b))
area = (b-a)/(6*n)*(sum(fEndpts) + sum(fEndpts(2:end-1)) + 4*sum(fMidpts));


end