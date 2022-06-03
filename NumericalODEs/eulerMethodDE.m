function [xApprox,yApprox]=eulerMethodDE(f,init,n,h)
% The eulerMethodDE function takes four arguments
% f is a function handle
% init = [x0 f(x0)] is the initial condition
% h is the step size and 
% n is the number of steps to estimate
% 
% The function returns an (n+1)x2 matrix of 
% estimated (xi,yi) values

% Initialize the output with the initial value
% Initialize the output with the initial value
xApprox = nan(n+1,1);
yApprox = nan(n+1,1);
xApprox(1) = init(1);
yApprox(1) = init(2);

% Fill in the details of the implementation here


end