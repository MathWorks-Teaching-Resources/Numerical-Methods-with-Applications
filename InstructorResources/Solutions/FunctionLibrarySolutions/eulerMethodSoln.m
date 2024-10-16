function [xApprox,yApprox]=eulerMethodSoln(f,init,n,h)
arguments
    f function_handle  % integrand, e.g. @(x) x.^2
    init (1,2) double  % initial value
    n (1,1) double {mustBePositive,mustBeInteger} % number of steps
    h (1,1) double     % step size
end

% The function returns two length (n+1) vectors of 
% estimated x and y values

% Initialize the output with the initial value
xApprox = nan(n+1,1);
yApprox = nan(n+1,1);
xApprox(1) = init(1);
yApprox(1) = init(2);

for i = 1:n
    xi = xApprox(i)+h;
    yi = yApprox(i)+f(xApprox(i))*h;
    xApprox(i+1) = xi;
    yApprox(i+1) = yi;
end

end