%[text] # Implement an explicit method solver for a 1-D heat equation
%[text] [⇦ NumericalPDEs.m](file:./NumericalPDEs.m)
%[text] Consider the heat $u(t,x)${"altText":"u(t,x)"} in a uniform rod of length $L${"altText":"L"}. 
%[text]{"align":"center"} $\\frac{\\partial u}{\\partial t} = \\gamma \\frac{\\partial^2 u}{\\partial x^2}${"altText":"(partial u)\/(partial t) = gamma (partial^2 u)\/(partial x^2)"}  with boundary conditions $\\begin{cases} u(0,x) = f(x) & \\\\ u(t,0) = \\alpha(t) & \\\\ u(t,L) = \\beta(t) & \\end{cases}${"altText":"cases: u(0,x) = f(x) for ; u(t,0) = alpha (t) for ; u(t,L) = beta (t) for"}
%[text] This script will walk you through implementing the explicit method
%[text]{"align":"center"} $u\_{j+1,m} =  u\_{j,m}  + \\frac{\\gamma \\Delta t}{(\\Delta x)^2}\\left(u\_{j,m+1}-2u\_{j,m}+u\_{j,m-1}\\right).${"altText":"u\_{j+1,m} = u\_{j,m} + (gamma Delta t)\/(( Delta x)^2)(u\_{j,m+1}-2u\_{j,m}+u\_{j,m-1})."} $(\\mathcal{E})${"altText":"(E)"}
%[text] ## Define a specific problem for testing and development
%[text] For specificity, implement method $(\\mathcal{E})${"altText":"(E)"} to estimate $u(0.04,x)${"altText":"u(0.04,x)"} if $L=4${"altText":"L=4"}, $\\gamma = 3${"altText":"gamma = 3"} and $\\Delta x = 0.1${"altText":"Delta x = 0.1"}. Use the boundary conditions $u(0,x) = f(x) = x^2-4x${"altText":"u(0,x) = f(x) = x^2-4x"}, $u(t,0) = \\sin(100t)${"altText":"u(t,0) = sin(100t)"}, and $u(t,L) = \\begin{cases} t & 0\\leq t \< \\frac{1}{2} \\\\ 1-t & \\frac{1}{2} \\leq t \\leq 1 \\\\ 0, & \\text{otherwise} \\end{cases}${"altText":"u(t,L) = cases: t for 0 \<= t \< (1)\/(2) ; 1-t for (1)\/(2) \<= t \<= 1 ; 0, for otherwise"}.
% Define the parameters and boundary functions for the problem
L = 4;                   % length of the rod
gamma = 3;               % diffusivity, gamma > 0
dx = 0.1;                % Delta x step size
tEnd = 0.04;             % time at which to finish the approximation
f = @(x) x.^2-4.*x;      % u(0,x)
alphaFunc = @(t) sin(100*t); % u(t,0)
syms betaFunc(t)
betaFunc(t) = piecewise((0 <= t) & (t < 0.5), ...
    t,(0.5 <= t) & (t <= 1),1-t,0)       % u(t,L)
%%
%[text] ## Determine the size of `A`
%[text]  How many rows (or columns) are there in matrix $A${"altText":"A"} in this example?
% Enter the number of rows in A instead of 0 for numRows.
% Then run this section to check your answer.
numRows = 0;
checkNumRows(numRows,L,dx);
%%
%[text] ## Determine the value of `dt`
%[text] What is a reasonable choice for $\\Delta t =${"altText":"Delta t ="} `dt` given the values in this problem and the constraints of the method, including the fact that you must evaluate the function at `tEnd`?
% Replace the value 0 with your choice for dt
dt = 0;
checkDt(dt,dx,gamma,tEnd);

%%
%[text] ## Set up the matrix `A`
%[text] ![](text:image:1453) **Pro-tip**. The matrix $A${"altText":"A"} is an example of a tridiagonal matrix. This particular type of sparse matrix is common enough that there is a standard command to create one in MATLAB. Sparse matrices provide memory-efficient storage for matrices that are mostly 0's. 
%[text] ```matlabCodeExample
%[text] A = gallery('tridiag',subdiag,diag,superdiag)
%[text] ```
%[text] In this case, `subdiag` is a vector of values for the diagonal just below the main diagonal, `diag` is the vector of values to put on the main diagonal, and `superdiag` is the vector of values to place just above the main diagonal. If `diag` is of length $\\ell${"altText":"ell"}, then `A` is an $\\ell${"altText":"ell"} by $\\ell${"altText":"ell"} matrix, and both `subdiag` and `superdiag` have length $\\ell${"altText":"ell"}`-1`. You may want to use something like the command `ones(numRows,1)` to create a `numRows` by `1` column vector of ones to create the diagonal entry vectors. 
%[text] #### Understanding check: creating sparse matrices
%[text] Use the `gallery` command to create the tridiagonal matrix
%[text]{"align":"center"} $M = \\pmatrix{3 & -1 & 0 & 0 & 0 \\cr 2 & 3 & -1 & 0 & 0 \\cr 0 & 2 & 3 & -1 & 0 \\cr 0 & 0 & 2 & 3 & -1 \\cr 0 & 0 & 0 & 2 & 3}${"altText":"M = matrix \[3, -1, 0, 0, 0; 2, 3, -1, 0, 0; 0, 2, 3, -1, 0; 0, 0, 2, 3, -1; 0, 0, 0, 2, 3\]"}.
% To see how a sparse matrix is represented, delete the ; from the
% following line
M = gallery('tridiag',3);
% Use the full command to create a standard matrix out of a sparse matrix
% to check that you have created the matrix you expect
full(M)

%%
%[text] #### Create the matrix `A` for this example
% Replace eye(numRows) with the commands to create A
% You may want to define some helper variables such as mu
A = eye(numRows);

% A is large and you don't want to display the whole matrix
% Check that A is looking like you expect by viewing a 5x5 submatrix
B = full(A);
B(1:5,1:5)
% Check that A has the dimensions you expect
[Arows,Acols] = size(A)
% Check that A is square and of size numRows x numRows
if Arows ~= Acols || Arows ~= numRows
    disp("This doesn't look correct.")
else
    disp("Looking good!")
end
% Test if A is correct
checkForA(A,gamma,dt,dx,numRows)
%%
%[text] ## Set up the vector `u0`
%[text] Build the column vector `u0` containing the points $f\_m = f(x\_m)${"altText":"f\_m = f(x\_m)"}. 
% Replace 0 with the appropriate vector
u0 = 0;

% Test if u0 is correct
checkInitialVector(u0,f,dx,L)

%%
%[text] ## Set up the vector `b`
%[text] While `A` is a constant matrix, the vector `b`$=b^{(j)}${"altText":"=b^{(j)}"} depends on the value of $t\_j = j\\Delta t${"altText":"t\_j = j Delta t"}. Build the column vector  `b`$=b^{(6)}${"altText":"=b^{(6)}"}.
% Replace 6 with the appropriate vector
b = 6;

% Test if b=b^(6) is correct
checkbVector(b,6,alphaFunc,@(t) double(betaFunc(t)),L,dx,tEnd,gamma)
%%
%[text] ## Put it all together
%[text] Write your solver and then return to the [main script](file:./NumericalPDEs.m) for testing.
open("explicitPDE.m")
%%
%[text] ## Help us Improve
%[text] [Share your feedback](<matlab: ShareFeedback>) to help us improve this module.
%%
%[text] ## **Check Functions**
function checkNumRows(n,L,dx)
realN = L/dx-1;
if mod(L/dx,1) ~= 0
    disp("Please ensure that L is an integer multiple of dx.")
else
    if realN == n
        disp("That is correct. Please go on to part b).")
    elseif realN+1 == n
        disp("Check your indices carefully. How do the dimensions relate to L and dx?")
    elseif realN+2 == n
        disp("Remember that A only acts on the interior points of the mesh. Please check your indices and try again.")
    elseif n == 0
        disp("Please change the value from the default. The matrix has positive size.")
    else
        disp("That is incorrect. Please check your computations and try again.")
    end
end
end

function checkDt(dt,dx,gamma,tEnd)
dtOpt = dx^2/(2*gamma);
dtBest = tEnd/ceil(tEnd/dtOpt);
if dt > 0 && dt <= dtOpt 
    disp("That is a reasonable choice. Your solution will be stable.")
    if dt == dtBest
        disp("Your solution maximizes the step size that will reach tEnd.")
        disp("You should proceed to the next problem.")
    elseif dt > dtBest
        disp("That said, this value of dt will bypass tEnd.")
        disp("Can you find a stable value that will reach tEnd?")
    elseif dt < dtBest
        disp("That said, generally you want the largest possible step you " + ...
            "can take that will satisfy your criteria to end at tEnd.")
        disp("Can you find a larger dt that preserves the stability?")
    end
elseif dt == dx^2
    disp("This fits the conditions required to control error, but not stability.")
    disp("Please check the Fourier stability criterion for this method.")
elseif dt <0
    disp("This value is too small. The step size must be positive.")
elseif dt == 0
    disp("This is the default value. Please try again with a positive step size.")
else
    disp("This value is too large. Please check the conditions required to control error and the convergence of the method.")
end
end

function checkForA(A,gamma,dt,dx,numRows)
mu = gamma*dt/(dx^2);
baseDiag = ones(1,numRows);
Asoln = gallery('tridiag',mu*baseDiag(1:end-1),(1-2*mu)*baseDiag,mu*baseDiag(1:end-1));
if A == Asoln
    disp("Your A is correct. Continue on to part e).")
else
    disp("Your answer is incorrect. Please fix A before continuing.")
end
end

function checkInitialVector(u0,f,dx,L)
% Evaluate f_m = f(x_m)
u0ans = f(0:dx:L);
% Transpose so that u0ans is a column vector
u0ans = u0ans';
[ansRows,~] = size(u0ans(2:end-1));
[u0Rows,u0Cols] = size(u0);
if (ansRows+2 == u0Rows) && all(u0 == u0ans)
    disp("You are evaluating u0 correctly, but you have some extra points.")
    disp("Check the expected dimensions of the vector u^(0).")
    disp("Remember that you need to calculate Au^(0).")
elseif (u0Rows == ansRows) && all(u0 == u0ans(2:end-1))
    disp("Your u0 is correct. Please continue and put all the pieces together.")
elseif (u0Cols == ansRows+2) && all(u0' == u0ans)
    disp("You are on the right track, but you u0 must be a column vector.")
    disp("Please fix this and resubmit.")
elseif (u0Cols == ansRows) && all(u0' == u0ans(2:end-1))
    disp("This is the correct set of values, but it is a row vector.")
    disp("u0 must be a column vector. Please fix this and resubmit.")
elseif u0 == 0
    disp("This is the default solution. Please solve the problem.")
else
    disp("This u0 is incorrect. Please review the definitions for")
    disp("u0 = u^(0) = ")
end
end

function checkbVector(b,j,alpha,beta,L,dx,tEnd,gamma)
numRows = L/dx-1;
dtOpt = dx^2/(2*gamma);
dt = tEnd/ceil(tEnd/dtOpt);
bAns = zeros(numRows,1);
bAns(1) = alpha(j*dt);
bAns(end) = beta(j*dt);
[bRows,bCols] = size(b);
if (bRows == numRows) && all(b == bAns)
    disp("Good work. This is the correct value of b^(j) in this case.")
elseif (bCols == numRows) && all(b == bAns')
    disp("You have the correct values but b is a row vector.")
    disp("b must be a column vector in this algorithm.")
    disp("Please fix b and resubmit.")
elseif (nnz(b) <= 2) && (b(1) == bAns(1)) && (b(end) == bAns(end))
    disp("You have the correct values but the wrong size.")
    disp("Remember that b should have the same size as Au.")
    disp("Fix your dimensions and resubmit.")
elseif b == 6
    disp("This is the default value. Please solve the problem.")
else
    disp("This is incorrect. Please review the definition of b^(j).")
    disp("Then resubmit a new solution.")
end
end

%[appendix]{"version":"1.0"}
%---
%[metadata:view]
%   data: {"layout":"inline","rightPanelPercent":40}
%---
%[text:image:1453]
%   data: {"align":"baseline","height":20,"src":"data:image\/png;base64,iVBORw0KGgoAAAANSUhEUgAAAB8AAAAcCAYAAACZOmSXAAACP0lEQVR42mNgoCLIy8vzys\/Pf15QUNDNQE9QWFioBLT4CxD\/B2GgA5LoZjnQwi0wi6H4TVlZGS89LA5FsxiGK2hqcW5urijQkidAfA+L5S\/S0tJYaWU3I9CCjUC8GYg\/YfM9MBH60yq4G6GW1OEIdhBeT1VLQUEJNLQDavg2IJ6Kx\/IfwJQvQLGlDQ0NbECDsoEGXoEa\/BUYrDpA+gMey0FBH0+RxdnZ2fJAg26gGVwKdEwBPouheCslFgsDDbiDZuC2kpISbiD9lAjLfwILISFyE9YKNMPugwxDSnDE4GSiLQwNDWUGxSfUcjkgPgU15DMQ6xUVFamBEhMJlu8nqowGWtoCLThAmqYlJCRwAAsTdmD0zgTy\/UBsIH2GBItB+C\/IExgWggwHSkQB8V4g\/odF4zmgg1Rh6oGOmESixdiLW6BBlUDBdwQ0\/QCGiC80CnLItBiEr6JYXlxcLAItInFp+AbE7lCHBgDZfyiw\/D8wygwxymho4fENTfFnoLgDksU\/KbEYivtxtURApdVlqKK7QFfqQ4M6HIh\/UcFicD0PSmNYHQBNfMWZmZmCUB8XQFMqqZaAsmQNKFsCPWUFpBciJeYogtkuKyuLB2h3EFDzJhItfgZMoLo42nigqvcgSfU20BGLSLBYCU\/jQx9UJAPVmBBte3l5OT8RWfIrMYbm5OQogqKE1DK+FV8JBsoRxJqFM9HhsVwciL\/jsLyQHi3V+VgsrmGgBwAGrRFyHJNUVVLJATuBli4FYnVKzAEAi4Bewge+mbwAAAAASUVORK5CYII=","width":23}
%---
