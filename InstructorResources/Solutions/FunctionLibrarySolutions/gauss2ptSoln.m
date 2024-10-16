function Fapprox = gauss2ptSoln(f,a,b)
% gauss2pt takes three arguments
% f is a function handle
% a and b are the bounds of a definite integral
%
% Fapprox returns the Gaussian 2 point approximation of the 
% integral from a to b of f(x) dx
w1 = 1;
w2 = 1;
x1 = -1/sqrt(3);
x2 = 1/sqrt(3);

% Change variables from [-1,1] to [a,b]
scaledWeights = (b-a)/2*[w1 w2];
scaledX = (b-a)/2*[x1; x2]+(b+a)/2;

Fapprox = scaledWeights*f(scaledX);
end