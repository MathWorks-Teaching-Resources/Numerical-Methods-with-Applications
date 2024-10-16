function [tApprox,yApprox]=improvedEulerSoln(f,init,n,h)
% The improvedEuler function takes four arguments
% f is a function handle, e.g. @(t,y) t.^2.*cos(y)
% init = is the initial value vector [t0 y0]
% h is the step size and 
% n is the number of steps to estimate
% 
% The function returns two length (n+1) vectors of 
% estimated x and y values

% This method is also called the Heun formula

% Initialize the output with the initial value
tApprox = nan(n+1,1);
yApprox = nan(n+1,1);
tApprox(1) = init(1);
yApprox(1) = init(2);


for i = 2:(n+1)
    tPrev = tApprox(i-1);
    ti = tPrev+h;
    yPrev = yApprox(i-1);
    yiGuess = yPrev+f(tPrev,yPrev)*h;
    yiImproved = (yiGuess+yPrev+f(ti,yiGuess)*h)/2;
    tApprox(i) = ti;
    yApprox(i) = yiImproved;
end

end