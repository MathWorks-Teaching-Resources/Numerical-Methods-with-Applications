function Fapprox = gauss2pt(f,a,b)
% gauss2pt takes three arguments
% f is a function handle
% a and b are the bounds of a definite integral
%
% Fapprox returns the Gaussian 2 point approximation of the 
% integral from a to b of f(x) dx


Fapprox = f((b+a)/2);
end