function [tApprox,yApprox]=eulerBackwardDifferenceSoln(f,init,n,h)
% The eulerBackwardDifference function takes four arguments
% f is a function handle, e.g. @(t,y) t.^2.*cos(y)
% init = is the initial value vector [t0 y0]
% h is the step size and 
% n is the number of steps to estimate
% 
% The function returns two length (n+1) vectors of 
% estimated x and y values

% Initialize the output with the initial value
tApprox = nan(n+1,1);
yApprox = nan(n+1,1);
tApprox(1) = init(1);
yApprox(1) = init(2);

% Evaluate one step forward using the Euler forward difference method
tApprox(2) = tApprox(1)+h;
yApprox(2) = yApprox(1)+f(tApprox(1),yApprox(1))*h;

g = @(t,y,yn) y-f(t,y)*h-yn;

for i = 3:(n+1)
    ti = tApprox(i-1)+h;
    yn = yApprox(i-1);
    gi = @(y) g(ti,y,yn);
    yi = fzero(gi,yn);
    tApprox(i) = ti;
    yApprox(i) = yi;
end

end