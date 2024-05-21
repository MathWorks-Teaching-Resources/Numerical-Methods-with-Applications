function [xApprox,yApprox]=eulerMethod(f,init,n,h)
arguments
    f function_handle  % integrand, e.g. @(x) x.^2
    init (1,2) double  % initial value (x0,y0)
    n (1,1) double {mustBePositive,mustBeInteger} % number of steps
    h (1,1) double     % step size
end

% The function returns two length (n+1) vectors of 
% estimated x and y values

% Initialize the output with the initial value
% Initialize the output with the initial value
xApprox = nan(n+1,1);
yApprox = nan(n+1,1);
xApprox(1) = init(1);
yApprox(1) = init(2);

% Fill in the details of the implementation here

end