function [tApprox,yApprox]=eulerMethodDESoln(f,init,n,h)
arguments
    f function_handle  % derivative dy/dt = f(t,y)
    init (1,2) double  % initial value [t0 y0]
    n (1,1) double {mustBePositive,mustBeInteger} % number of steps
    h (1,1) double     % step size
end
% f is a function handle, e.g. @(t,y) t.^2.*cos(y)

% The function returns two length (n+1) vectors of 
% estimated x and y values

% Initialize the output with the initial value
tApprox = nan(n+1,1);
yApprox = nan(n+1,1);
tApprox(1) = init(1);
yApprox(1) = init(2);

for i = 1:n
    xi = tApprox(i)+h;
    yi = yApprox(i)+f(tApprox(i),yApprox(i))*h;
    tApprox(i+1) = xi;
    yApprox(i+1) = yi;
end

end