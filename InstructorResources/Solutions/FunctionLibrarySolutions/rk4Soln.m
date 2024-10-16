function [t,y] = rk4Soln(f,tspan,y0,n)
% rk4 implements a four-step Runge-Kutta method on function f
%    over t = tspan(1) to t = tspan(2) where y(tspan(1))=y0 
%    using n intervals
%
% t is a vector of t values and y is a vector of estimated y(t) values

t = (linspace(tspan(1),tspan(2),n+1))';

y = nan(n+1,1);

y(1) = y0;

for i = 1:n
    tLeft = t(i);
    tRight = t(i+1);
    tMid = (tLeft+tRight)/2;
    yLeft = y(i);
    h = t(i+1)-t(i);
    k1 = f(tLeft,yLeft);
    k2 = f(tMid,yLeft+0.5*h*k1);
    k3 = f(tMid,yLeft+0.5*h*k2);
    k4 = f(tRight,yLeft+h*k3);
    y(i+1) = yLeft + (h/6)*(k1+2*k2+2*k3+k4);
end

end
