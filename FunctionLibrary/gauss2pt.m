function Fapprox = gauss2pt(f,a,b)
% gauss2pt takes three arguments
% f is a function handle
% a and b are the bounds of a definite integral
%
% Fapprox returns the Gaussian 2 point approximation of the 
% integral from a to b of f(x) dx

% Fill in the details of the implementation here so your 
% code will return a correct approximation of the area
Fapprox = f((b+a)/2);
end