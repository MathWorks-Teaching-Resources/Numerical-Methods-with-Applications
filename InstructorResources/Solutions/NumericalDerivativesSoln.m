%[text] %[text:anchor:T_B4201D3B] # Finite Difference for Approximating Derivatives
%[text] [⇦ Main Menu](file:../../MainMenu.m)
%[text] Differential equations show up in a wide range of contexts, from population modeling or engineering dynamics to pharmaco-kinetics or solving circuits. While some of these scenarios lend themselves to analytic, closed-form solutions, we must approximate a solution using a numerical method in many cases. Finite difference methods combine linear algebra and Taylor's theorem to create derivative approximations given certain information.
%[text:tableOfContents]{"heading":"Table of Contents"}
%[text] This live script is intended to be used with the code visible and output inline. On the **View** tab of the MATLAB Toolstrip, in the **View** section, select **Output Inline**. Alternately, select **Output Inline** using the icon ![live script output inline icon](text:image:504f) at the top right of the Live Editor pane.
%[text] ![Lightbulb mark](text:image:002f) Interacting with this live script will build some familiarity with MATLAB as concepts and commands are introduced together. If you need more instruction, consider taking [MATLAB Onramp](https://matlabacademy.mathworks.com/details/matlab-onramp/gettingstarted), a free 2-hour online tutorial that teaches the essentials of MATLAB.
%[text] ![Warning symbol](text:image:1a91)   For an optimal experience, follow the instructions and steps in the given sequence. Proceed to a new section only after completing the preceding one. Some sections depend on variables created in prior sections and they will generate errors if run out of order.
%[text] %[text:anchor:H_448F2316] ## Finite difference methods
%[text] Finite difference methods apply Taylor's theorem to create numerical approximations to various derivatives while bounding the known error. If we consider the Taylor series expansion of $f(x+h)${"altText":"f(x+h)"} around a value $x${"altText":"x"}, we have the following:
%[text]{"align":"center"} $f(x+h) = f(x)+f'(x)h+f''(x)\\frac{h^2}{2!} + f'''(x)\\frac{h^3}{3!} + \\cdots.${"altText":"f(x+h) = f(x)+f'(x)h+f''(x)(h^2)\/(2!) + f'''(x)(h^3)\/(3!) + ...."}
%[text] %[text:anchor:H_FC9AF801] ### Using Taylor series to build higher order approximations
%[text] Assuming that the radius of convergence is positive and larger than $|h|${"altText":"|h|"}, there is some interval around $x${"altText":"x"} for which knowing all the values of $f^{(k)}(x)${"altText":"f^{(k)}(x)"} means knowing the value of $f(x+h)${"altText":"f(x+h)"}. Taylor's theorem tells us that if $f${"altText":"f"} has $n+1${"altText":"n+1"} continuous derivatives on an open interval containing both $a${"altText":"a"} and $x${"altText":"x"}, then 
%[text]{"align":"center"} $\\displaystyle f(x+h) = \\left\[\\sum\_{k=0}^{n} \\frac{f^{(k)}(x)}{k!}h^k\\right\] + R\_{n+1}(x+h),${"altText":"f(x+h) = \[sum\_{k=0}^{n} (f^{(k)}(x))\/(k!)h^k\] + R\_{n+1}(x+h),"} $(\\star)${"altText":"(\*)"}
%[text] where $\\displaystyle R\_{n+1}(x+h) = \\frac{f^{(n+1)}(c)}{(n+1)!}h^{n+1} = \\mathcal{O}(h^{n+1})${"altText":"R\_{n+1}(x+h) = (f^{(n+1)}(c))\/((n+1)!)h^{n+1} = O(h^{n+1})"} where $c${"altText":"c"} is some value between $x${"altText":"x"} and $x+h${"altText":"x+h"}. This formula would give us a clear bound on the error of an $n^{\\text{th}}${"altText":"n^{th}"} order approximation if we could bound the value of the $(n+1)^{\\text{st}}${"altText":"(n+1)^{st}"} derivative.Frequently, this is not a trivial operation so it will be more practical to estimate the order of the error numerically. 
%[text] %[text:anchor:H_442ADE8E] ### Example: Approximating a second derivative using 5 points
%[text] Consider calculating a numerical approximation to $f''(x)${"altText":"f''(x)"} using 5 points: $f(x+2h), f(x+h), f(x), f(x-h),${"altText":"f(x+2h), f(x+h), f(x), f(x-h),"} and $f(x-2h)${"altText":"f(x-2h)"} for some constant $h${"altText":"h"}. This will look like
%[text]{"align":"center"} $f''(x) = \\frac{Af(x+2h)+Bf(x+h)+Cf(x)+Df(x-h)+Ef(x-2h)}{Fh^2} + R${"altText":"f''(x) = (Af(x+2h)+Bf(x+h)+Cf(x)+Df(x-h)+Ef(x-2h))\/(Fh^2) + R"} 
%[text] for some constants $A, B, C, D, E, F${"altText":"A, B, C, D, E, F"} and an error function $R${"altText":"R"}. Applying Taylor's formula $(\\star)${"altText":"(\*)"}, we see that
%[text]{"align":"center"} $Af(x+2h) = Af(x)+Af'(x)(2h)+A\\frac{f''(x)}{2}(2h)^2+A\\frac{f'''(x)}{6}(2h)^3+\\mathcal{O}(h^4)${"altText":"Af(x+2h) = Af(x)+Af'(x)(2h)+A(f''(x))\/(2)(2h)^2+A(f'''(x))\/(6)(2h)^3+O(h^4)"} 
%[text]{"align":"center"}  $= Af(x)+2Af'(x)h+4A\\frac{f''(x)}{2}h^2+8A\\frac{f'''(x)}{6}h^3+\\mathcal{O}(h^4)${"altText":"= Af(x)+2Af'(x)h+4A(f''(x))\/(2)h^2+8A(f'''(x))\/(6)h^3+O(h^4)"} 
%[text]{"align":"center"} $Bf(x+h) = Bf(x)+Bf'(x)h + B\\frac{f''(x)}{2}h^2 + B\\frac{f'''(x)}{6}h^3 + \\mathcal{O}(h^4)${"altText":"Bf(x+h) = Bf(x)+Bf'(x)h + B(f''(x))\/(2)h^2 + B(f'''(x))\/(6)h^3 + O(h^4)"} 
%[text]{"align":"center"} $Cf(x) = Cf(x)${"altText":"Cf(x) = Cf(x)"} 
%[text]{"align":"center"} $Df(x-h) = Df(x)+ Df'(x)(-h) + D\\frac{f''(x)}{2}(-h)^2 + D\\frac{f'''(x)}{6}(-h)^3+\\mathcal{O}(h^4)${"altText":"Df(x-h) = Df(x)+ Df'(x)(-h) + D(f''(x))\/(2)(-h)^2 + D(f'''(x))\/(6)(-h)^3+O(h^4)"}
%[text]{"align":"center"}  $= Df(x)- Df'(x)h + D\\frac{f''(x)}{2}h^2 - D\\frac{f'''(x)}{6}h^3+\\mathcal{O}(h^4)${"altText":"= Df(x)- Df'(x)h + D(f''(x))\/(2)h^2 - D(f'''(x))\/(6)h^3+O(h^4)"}
%[text]{"align":"center"} $Ef(x-2h) = Ef(x)-2Ef'(x)h + 4E\\frac{f''(x)}{2}h^2-8E\\frac{f'''(x)}{6}h^3+\\mathcal{O(h^4)}${"altText":"Ef(x-2h) = Ef(x)-2Ef'(x)h + 4E(f''(x))\/(2)h^2-8E(f'''(x))\/(6)h^3+O(h^4)"} 
%[text] where $\\mathcal{O}(h^4)${"altText":"O(h^4)"} represents all the additional terms in the infinite series proportional to $h^4${"altText":"h^4"} or higher degrees. The best possible approximation to $f''(x)${"altText":"f''(x)"} will occur when we choose values of $A, B, C, D,${"altText":"A, B, C, D,"} and $E${"altText":"E"} to eliminate as many low-order terms as possible in the sum. We can formulate this as a linear algebra problem, `Mx = b` when we are eliminating the $h^0${"altText":"h^0"}, $h${"altText":"h"}, and $h^3${"altText":"h^3"} terms, but keeping the $h^2${"altText":"h^2"} term:
%[text]{"align":"center"} $\\pmatrix{ 1 & 1 & 1 & 1 & 1 \\cr 2 & 1 & 0 & -1 & -2 \\cr \\frac{4}{2} & \\frac{1}{2} & \\frac{0}{2} & \\frac{1}{2} & \\frac{4}{2} \\cr \\frac{8}{6} & \\frac{1}{6} & \\frac{0}{6} & -\\frac{1}{6} & -\\frac{8}{6}} \\pmatrix{\\frac{A}{F} \\cr \\frac{B}{F} \\cr \\frac{C}{F} \\cr \\frac{D}{F} \\cr \\frac{E}{F} } = \\pmatrix{ 0 \\cr 0 \\cr 1 \\cr 0}${"altText":"matrix \[1, 1, 1, 1, 1; 2, 1, 0, -1, -2; (4)\/(2), (1)\/(2), (0)\/(2), (1)\/(2), (4)\/(2); (8)\/(6), (1)\/(6), (0)\/(6), -(1)\/(6), -(8)\/(6)\] matrix \[(A)\/(F); (B)\/(F); (C)\/(F); (D)\/(F); (E)\/(F)\] = matrix \[0; 0; 1; 0\]"} $\\matrix{h^0\\;\\; \\text{ term} \\cr h \\;\\;\\text{ term}\\cr h^2\\;\\; \\text{ term} \\cr h^3 \\;\\;\\text{ term}}${"altText":"matrix \[h^0 term; h term; h^2 term; h^3 term\]"}
M = [1    1   1   1    1; ...
     2    1   0  -1   -2; ...
     2   1/2  0  1/2   2; ...
     4/3 1/6  0 -1/6 -4/3];
b = [0; 0; 1; 0];
% Solve the equation M*coeffs = b
coeffs = M\b
% Check the results within a numerical tolerance
tol = 1e-8;
if all((M*coeffs - b) < tol)
    disp("One solution was found. Can we do better?")
else
    disp("This is not solvable. Please check by hand.")
end
%[text] This computes the approximation
%[text]{"align":"center"} $f''(x) = \\frac{f(x+2h)-2f(x)+f(x-2h)}{4h^2} + \\mathcal{O}(h)${"altText":"f''(x) = (f(x+2h)-2f(x)+f(x-2h))\/(4h^2) + O(h)"}.
%[text] Can we get a better approximation? What about trying to cancel the $h^4${"altText":"h^4"} term?
k = 3;
while norm(M*coeffs-b,2) < tol
    disp("We confirmed that h^"+k+" could be canceled. Trying h^"+(k+1)+"...")
    k = k+1;
    M = [M; 2^k 1 0 (-1)^k (-2)^k];
    b = [b; 0];
    coeffs = M\b;
end
disp("h^"+k+" cannot be canceled.")
%[text] The best solution is:
% Let's scale the solutions so that A = 1
coeffs = M(1:end-1,:)\b(1:end-1);
scaledCoeffs = coeffs./coeffs(1)'
%[text] Observe that these values are not integers because of roundoff error in the computation. Because we can check these solutions by hand, we know the values should be integers. Therefore, we can round to determine that $\[A, B, C, D, E\]${"altText":"\[A, B, C, D, E\]"} are
disp(round(scaledCoeffs)')
%[text] and the scaling factor is
F = round(1/coeffs(1))
% syms x h f(x) O(x) d dx
% D2f = diff(f,x,2);
% displayFormula("D2f == (A*f(x+2*h)+B*f(x+h)+C*f(x)+D*f(x-h)+E*f(x-2*h))/(F*h^2) + O(h^(k-2))")
%[text] Putting this all together, we have a fourth-order approximation because the nonzero $\\mathcal{O}(h^6)${"altText":"O(h^6)"} terms are divided by $-12h^2${"altText":"-12h^2"} when isolating the second derivative. That leaves an error term of $\\mathcal{O}(h^4)${"altText":"O(h^4)"}:
%[text]{"align":"center"} $f''(x) = \\frac{f(x+2h)-16f(x+h)+30f(x)-16f(x-h)+f(x-2h)}{-12h^2} + \\mathcal{O}(h^4)${"altText":"f''(x) = (f(x+2h)-16f(x+h)+30f(x)-16f(x-h)+f(x-2h))\/(-12h^2) + O(h^4)"}
%%
%[text] %[text:anchor:H_8CABF835] ![](text:image:723a)**Exercise 1. Determine finite difference approximation formulas**
%[text] Use Taylor's formula $(\\star)${"altText":"(\*)"} to compute the following:
%[text] a) What is the value of $k${"altText":"k"} in the approximation
%[text]{"align":"center"} $f'(x) = \\frac{f(x+h)-f(x)}{h} + \\mathcal{O}(h^k)${"altText":"f'(x) = (f(x+h)-f(x))\/(h) + O(h^k)"}
k1a = 1;
%[text] b) What is the value of coefficient $A${"altText":"A"} and power $k${"altText":"k"} in the approximation
%[text]{"align":"center"} $f'(x) = \\frac{f(x+2h)-4f(x+h)+3f(x)}{Ah}+\\mathcal{O}(h^k)${"altText":"f'(x) = (f(x+2h)-4f(x+h)+3f(x))\/(Ah)+O(h^k)"}
A1b = -2;
k1b = 2;
%[text] c) What are the coefficients, $\[A, B, C, D, E\]${"altText":"\[A, B, C, D, E\]"}, $F${"altText":"F"}, and what is the power, $k${"altText":"k"}, of the error of the approximation
%[text]{"align":"center"} $f'(x) = \\frac{Af(x+2h)+Bf(x+h)+Cf(x)+Df(x-h)+Ef(x-2h)}{Fh} + \\mathcal{O}(h^k)${"altText":"f'(x) = (Af(x+2h)+Bf(x+h)+Cf(x)+Df(x-h)+Ef(x-2h))\/(Fh) + O(h^k)"}
coeffs = [1 -8 0 8 -1];
F1c = -12;
k1c = 4;

% Check your solutions to Exercise 1 by running this code
CheckEx1(k1a,A1b,k1b,coeffs,F1c,k1c)
%%
%[text] ![](text:image:01cc)**Reflect**.
%[text] 1. Are there patterns that you can see in the combinations of the number of points used for the approximation and the resulting order of the error?
%[text] 2. If you use the same number of points, but approximate a higher derivative, will the order of your error change? Why or why not?
%[text] 3. How could you use such a finite difference approximation to solve a differential equation numerically? \
%%
%[text] %[text:anchor:H_F83076E1] ## Checking Approximation Methods
%[text] In applications, it is generally not possible to precisely calculate the error of a result, so it is even more critical to understand the error of your method. The standard way to check error is to apply an approximation method to a problem where the solution is known.
%[text] %[text:anchor:H_0C0D8D68] ### Example: Using functions with known derivatives
%[text] Consider the function $y=x^2\\sin(x)${"altText":"y=x^2sin(x)"}. Then the first two derivatives are 
%[text]{"align":"center"} $y' = 2x\\sin(x)+x^2\\cos(x)${"altText":"y' = 2xsin(x)+x^2cos(x)"} 
%[text] and 
%[text]{"align":"center"} $y''(x) = 2\\sin(x) + 4x\\cos(x) -x^2\\sin(x)${"altText":"y''(x) = 2sin(x) + 4xcos(x) -x^2sin(x)"}. 
% Create symbolic functions y(x) and DyF(x,h) 
syms y(x) DyF(x,h)
y(x) = x^2*sin(x);
% Calculate the symbolic first derivative of y(x)
Dy = diff(y,x)
% Define the forward difference approximation to the first derivative
% using symbolic functions
DyF(x,h) = (y(x+h)-y(x))./h
% Define the forward difference approximation to the first derivative
% using anonymous functions
DyForward = @(x,h) (double(y(x+h))-double(y(x)))./h
%[text] Build a table to check the order of the error at a point `x0`.
x0 = 1;

% Define a decreasing column vector of values for h
powers = (-1:-1:-10)';
h = 10.^powers;
x0vec = ones(size(h))*x0;

% Compute the estimate of the derivative symbolically
dyFDest = double(DyF(x0vec,h));

% Compute the error in the symbolic estimate of the derivative
dyFDSymErr = double(Dy(x0vec)-DyF(x0vec,h));

% Compute the error in the numeric estimate of the derivative
dyFDAnonErr = double(Dy(x0vec))-DyForward(x0vec,h);

vals = [h dyFDest dyFDSymErr dyFDAnonErr ...
    [nan; -log10(dyFDSymErr(2:end)./dyFDSymErr(1:end-1))]  ...
    [nan; -log10(dyFDAnonErr(2:end)./dyFDAnonErr(1:end-1))]];

% Set the numerical display mode to short scientific notation
format shorte

% Comparing Symbolically and Numerically Computed Forward Difference Approximations

T = array2table(vals(2:end,:),"VariableNames",...
    ["h" "Forw. Diff." "Symb. Error" "Num. Error" "Symb. Order" "Num. Order"])
%%
%[text] %[text:anchor:H_91DEDC95] ### Truncation Error and Rounding Error 
%[text] The truncation error due to truncating the Taylor series approximation at the second degree shows up clearly in the symbolic error computation for the forward difference approximation. The numerical computation using floating point arithmetic initially agrees with both the theoretical and symbolic calculations, but the numerical computation accumulates additional rounding error that eventually begins to dominate the calculation. This is an example of how important it can be to choose exactly how to perform a numerical calculation with a computer, even given exactly the same numerical method. 
%[text] ![](text:image:2042) **Try**. Perform the same comparison, but this time use the center difference approximation:
%[text]{"align":"center"} $\\frac{dy}{dx} \\approx \\frac{y(x+h)-y(x-h)}{2h} + \\mathcal{O}(h^2).${"altText":"(dy)\/(dx) approximately (y(x+h)-y(x-h))\/(2h) + O(h^2)."}
% Create a symbolic function DyC(x,h) to be the centered difference
% approximation to y(x) with a step size h
syms DyC(x,h)
% Define the centered difference approximation to the first derivative
% using symbolic functions
DyC(x,h) = (y(x+h)-y(x-h))./(2*h)
% Define the centered difference approximation to the first derivative
% using anonymous functions
DyCenter = @(x,h) (double(y(x+h))-double(y(x-h)))./(2*h)
% Set up specific values for the step sizes h
h = 10.^powers;

% Evaluate the centered difference estimate of the derivative computed symbolically
dyFCest = double(DyC(x0vec,h));

% Evaluate the error in the symbolically computed centered difference estimate
dyFCSymErr = double(Dy(x0vec)-DyC(x0vec,h));

% Evaluate the error in the numerically computed centered difference estimate
dyFCAnonErr = double(Dy(x0vec))-DyCenter(x0vec,h);

vals = [h dyFCest dyFCSymErr dyFCAnonErr [nan; -log10(dyFCSymErr(2:end)./dyFCSymErr(1:end-1))] ...
    [nan; -log10(dyFCAnonErr(2:end)./dyFCAnonErr(1:end-1))]];

% Comparing Symbolically and Numerically Computed Centered Difference Approximations
T = array2table(vals(2:end,:),"VariableNames",...
    ["h" "Cen. Diff." "Symb. Error" "Num. Error" "Symb. Order" "Num. Order"])
format short
%%
%[text] %[text:anchor:H_87B56010] ![](text:image:57c0) **Reflect**.
%[text] 1. If you change the vector of `h` values to be \
h = [0.1 0.05 0.025 0.0125 0.00625 0.003125 0.0015625]';
%[text] how do you have to change the commands to calculate the estimated order?
%[text] **Solution:**
%[text] You have to change the logarithm calculation from `-log10(error(j+1)/error(j))` to `-log(error(j+1)/error(j))/log(2)` to account for the change in the base of the ratio `h(j+1)/h(j)` from `1/10` to `1/2.`
x0 = 1;

% Define a decreasing column vector of values for h
h = 0.1*(2.^[0; powers]);
x0vec = ones(size(h))*x0;

% Compute the estimate of the derivative symbolically
dyFDest = double(DyF(x0vec,h));

% Compute the error in the symbolic estimate of the derivative
dyFDSymErr = double(Dy(x0vec)-DyF(x0vec,h));

% Compute the error in the numeric estimate of the derivative
dyFDAnonErr = double(Dy(x0vec))-DyForward(x0vec,h);

vals = [h dyFDest dyFDSymErr dyFDAnonErr ...
    [nan; -log(dyFDSymErr(2:end)./dyFDSymErr(1:end-1))/log(2)]  ...
    [nan; -log(dyFDAnonErr(2:end)./dyFDAnonErr(1:end-1))/log(2)]];

% Set the numerical display mode to short scientific notation
format shorte

% Comparing Symbolically and Numerically Computed Forward Difference Approximations

T = array2table(vals(2:end,:),"VariableNames",...
    ["h" "Forw. Diff." "Symb. Error" "Num. Error" "Symb. Order" "Num. Order"])
% Evaluate the centered difference estimate of the derivative computed symbolically
dyFCest = double(DyC(x0vec,h));

% Evaluate the error in the symbolically computed centered difference estimate
dyFCSymErr = double(Dy(x0vec)-DyC(x0vec,h));

% Evaluate the error in the numerically computed centered difference estimate
dyFCAnonErr = double(Dy(x0vec))-DyCenter(x0vec,h);

vals = [h dyFCest dyFCSymErr dyFCAnonErr [nan; -log(dyFCSymErr(2:end)./dyFCSymErr(1:end-1))/log(2)] ...
    [nan; -log(dyFCAnonErr(2:end)./dyFCAnonErr(1:end-1))/log(2)]];

% Comparing Symbolically and Numerically Computed Centered Difference Approximations
T = array2table(vals(2:end,:),"VariableNames",...
    ["h" "Cen. Diff." "Symb. Error" "Num. Error" "Symb. Order" "Num. Order"])
format short
%[text]          2\. In the first table, the errors for a forward difference approximation approximately agree with the theoretical expectation for both symbolic and numerical computation up to the 7th row. What happened at that point? Does that give you any ideas for why the error values in the table of computed orders of the error for the center difference approximation stop making sense around row 5 in the numerical case?
%[text] **Solution:** In the first table, the error is dominated by the error in the difference quotient approximations through row 6. By row 7, when the difference quotient error is proportional to $10^{-8}${"altText":"10^{-8}"}, the accumulating rounding error is beginning to dominate. Similarly, in the second table, once the difference quotient error is proportional to $10^{-8}${"altText":"10^{-8}"}, which is only row 3, the subsequent rows begin to be dominated by rounding error. In particular, there is actually an overestimate followed by an underestimate so the ratio between subsequent error estimates is negative. After calculating the logarithm, we are left with complex numbers. If you look carefully, the complex part is 0 up until row 5 when the ratio became negative. 
%%
%[text] %[text:anchor:H_915900E4] ![](text:image:3a09)**Exercise 2. Check the consistency of theoretical and applied errors**
%[text] Check the order of the error for Exercise 1, parts a-c, with $f(x) = \\cos(x)${"altText":"f(x) = cos(x)"} at the point $x\_0 = 1${"altText":"x\_0 = 1"}. Do your estimated results match your theoretical results? Why or why not? 
%[text] **Solution:** 
%[text] 1a is $f'(x) = \\frac{f(x+h)-f(x)}{h} + \\mathcal{O}(h^1)${"altText":"f'(x) = (f(x+h)-f(x))\/(h) + O(h^1)"}
%[text] 1b is $f'(x) = \\frac{f(x+2h)-4f(x+h)+3f(x)}{-2h}+\\mathcal{O}(h^2)${"altText":"f'(x) = (f(x+2h)-4f(x+h)+3f(x))\/(-2h)+O(h^2)"}
%[text] 1c is $f'(x) = \\frac{f(x+2h)-8f(x+h)+8f(x-h)-f(x-2h)}{12h} + \\mathcal{O}(h^4)${"altText":"f'(x) = (f(x+2h)-8f(x+h)+8f(x-h)-f(x-2h))\/(12h) + O(h^4)"}
f = @(x) cos(x);
fprime = @(x) -sin(x);
x0 = 1;
% Define the difference approximation from 1a
Dy1a = @(x,h) (f(x+h)-f(x))./h
% Define the difference approximation from 1b
Dy1b = @(x,h) (f(x+2*h)-4*f(x+h)+3*f(x))./(-2*h)
% Define the difference approximation from 1c
Dy1c = @(x,h) (f(x+2*h)-8*f(x+h)+8*f(x-h)-f(x-2*h))./(-12*h)
%[text] Build a table to check the order of the error at a point `x0`.
% Define a decreasing column vector of values for h
powers = (-1:-1:-10)';
h = 2.^powers;
x0vec = ones(size(h))*x0;

% For 1a
dy1aEst = double(Dy1a(x0vec,h));
dy1aErr = double(fprime(x0vec)-Dy1a(x0vec,h));
vals = [dy1aEst dy1aErr [nan; dy1aErr(2:end)./dy1aErr(1:end-1)] ...
    [nan; -log2(dy1aErr(2:end)./dy1aErr(1:end-1))]];
format long
T = array2table(vals,"VariableNames",...
    ["(f(x+h)-f(x))/h" "1a Error" "Ratio" "Estimated Order"])
%[text] 
% For 1b
dy1cEst = double(Dy1b(x0vec,h));
dy1bErr = double(fprime(x0vec)-Dy1b(x0vec,h));
vals = [dy1cEst dy1bErr [nan; dy1bErr(2:end)./dy1bErr(1:end-1)] ...
    [nan; -log2(dy1bErr(2:end)./dy1bErr(1:end-1))]];
format long
T = array2table(vals,"VariableNames",...
    ["(f(x+2h)-4f(x+h)+3f(x))/2h" "1b Error" "Ratio" "Estimated Order"])
% For 1c
dy1cEst = double(Dy1c(x0vec,h));
dy1cErr = double(fprime(x0vec)-Dy1c(x0vec,h));
vals = [dy1cEst dy1cErr [nan; dy1cErr(2:end)./dy1cErr(1:end-1)] ...
    [nan; -log2(dy1cErr(2:end)./dy1cErr(1:end-1))]];
format long
T = array2table(vals,"VariableNames",...
    ["(f(x+2h)-8f(x+h)+8f(x-h)-f(x-2h))/12h" "1c Error" "Ratio" "Estimated Order"])
format short
%%
%[text] ![](text:image:16c7) **Reflect**.
%[text] 1. How can you use theoretical and applied error checking to check whether you have correctly computed a reasonable approximation scheme? \
%%
%[text] %[text:anchor:H_AB630567] ## Assessing the impact of noise
%[text] In applications, noise in data can overwhelm the signal of a numerical derivative and higher order models do not mitigate the problem of noise.
% Set up parameters
h = 0.1;
xData = 0:h:2*pi;
yData = sin(xData);
noise = 0.05*(rand(size(yData))-0.5);

% Use the exact data to calculate a numerical derivative
xDataAvg = (xData(2:end)+xData(1:end-1))/2;
numDiff = (yData(2:end)-yData(1:end-1))/h;
yDn = yData + noise;
firstOrderBackwardApprox = (yDn(2:end)-yDn(1:end-1))/h;
secondOrderBackwardApprox = [(yDn(2)-yDn(1))/h (yDn(1:end-2)-4*yDn(2:end-1)+3*yDn(3:end))/(2*h)];

% Plot the original and noisy functions, as well as the numerical derivative
% approximations to the original and noisy functions
plot(xData,yData)
hold on
plot(xData,yData+noise)
plot(xDataAvg,numDiff)
plot(xData(2:end),firstOrderBackwardApprox) %[control:dropdown:3aa6]{"position":[19,43]}
hold off
% Set the axes limits to a reasonable common choice for the two plots
xlim([0 6])
ylim([-1.7 1.7])
legend(["Real Data", "Noisy Data", "Real Derivative", "Approximated Derivative"],"Location","north")
title("Demonstrating the Effects of a Small Amount of Noise")
%[text] As a result, a common application of derivative approximations is to create numerical methods to solve differential equations which can be used to smooth data with integration. 
%%
%[text] %[text:anchor:H_A607A44D] ## Further Explorations
%[text] Although numerical derivatives can amplify small errors in a data set, they will prove useful for building numerical methods to solve [ordinary](file:./NumericalODEsSoln.m) and [partial](file:./NumericalPDEsSoln.m) differential equations. 
%%
%[text] [⇦ Main Menu](file:../../MainMenu.m)
%%
%[text] ## Help us Improve
%[text] [Share your feedback](<matlab: ShareFeedback>) to help us improve this module.
%%
%[text] ## Helper Functions
function CheckEx1(k1,A,k2,coeffs,F,k3)
if k1 == 0 && A == 0 && k2 == 0 && all(coeffs == [0 0 0 0 0]) && F ==0 && k3 == 0
    disp("You must try the problem before it can be checked.")
    return
end
[~,~,k1Soln] = FindFinDiffApprox(@(k)[1 0],1,0);
[~,ASoln,k2Soln] = FindFinDiffApprox(@(k)[2^k 1 0],1,0);
[coeffSoln,FSoln,k3Soln] = FindFinDiffApprox(@(k)[2^k 1 0 (-1)^k (-2)^k],1,0);
flag = [0,0,0];
if k1 == k1Soln
    disp("Exercise 1a is correct.")
elseif k1 == k1Soln+1
    disp("In Exercise 1a, did you forget to divide by h?")
    disp("Your solution is incorrect.")
    flag(1) = 1;
else
    disp("Your solution to Exercise 1a is incorrect.")
end
if k2 == k2Soln && A == ASoln
    disp("Exercise 1b is correct.")
elseif k2 == k2Soln+1 && A == ASoln
    disp("In Exercise 1b, did you forget to divide by -2h?")
    disp("Your solution for the order of the error is incorrect.")
    flag(2) = 1;
elseif k2 == k2Soln+1
    disp("In Exercise 1b, did you forget to divide by Ah?")
    disp("Your solution is incorrect.")
    flag(2) = 1;
elseif A == -ASoln
    disp("Be careful with signs.")
    disp("Your solution is incorrect.")
    flag(2) = 1;
else
    disp("Your solution to Exercise 1b is incorrect.")
    flag(2) = 1;
end

if all(coeffs == coeffSoln) && F == FSoln && k3 == k3Soln
    disp("Exercise 1c is correct.")
elseif all(coeffs/coeffs(1) == coeffSoln) && F/coeffs(1) == FSoln && k3 == k3Soln
    disp("Your approximation expression for Exercise 1c is correct.")
elseif k3 == k3Soln + 1
    disp("In Excercise 1c, did you forget to divide by Fh?")
    disp("Your solution is incorrect.")
    flag(3) = 1;
else
    disp("Your solution to Exercise 1c is incorrect.")
    flag(3) = 1;
end
if sum(flag) > 1
    disp("Remember that you are combining Taylor series expansions of")
    disp("f(x+jh) around the center value x for different values of j.")
    disp("Please review the example, correct your work, and resubmit.")
elseif sum(flag) == 1
    disp("Please fix your calculation and resubmit.")
else
    disp("You have successfully completed Exercise 1. Please continue!")
end
end

function [coeffs,F,k] = FindFinDiffApprox(Mrule,derNum,flag)
% Mrule is a function handle to the updating rule for M
% derNum is the order of the derivative being approximated
% flag is a boolean that controls whether updates are displayed

numStencil = length(Mrule(1));
% Sanity checks
if mod(numStencil,1) ~= 0 || numStencil <= 0
    if flag
        disp("The number of points used in the approximation" + ...
            " must be a positive integer.")
    end
    return
elseif mod(derNum,1)~= 0 || derNum <= 0
    if flag
        disp("The order of the derivative to be approximated" + ...
            " must be a positive integer.")
    end
    return
end

M = ones([1,numStencil]);
for k = 1:derNum
    M = [M; Mrule(k)./factorial(k)];
end
b = zeros(derNum+1,1);
b(derNum+1) = 1;
tol = 1e-8;
coeffs = M\b;

if norm(M*coeffs-b,2) >= tol
    F = 1;
    k = nan;
    if flag
        disp("No solutions. Try increasing the number of datapoints used.")
    end
    return
end
k = derNum;
while norm(M*coeffs-b,2)< tol
    if flag
        disp("Trying " + (k+1) + "...")
    end
    k = k+1;
    M = [M; Mrule(k)];
    b = [b;0];
    coeffs = M\b;
end
coeffs = M(1:end-1,:)\b(1:end-1);
F = round(1/coeffs(1));
coeffs = round(coeffs/coeffs(1))';
k = k-derNum;
end

% Suppress code warning errors that are not helpful for this script
%#ok<*NASGU>
%#ok<*AGROW>

%[appendix]{"version":"1.0"}
%---
%[metadata:view]
%   data: {"layout":"inline","rightPanelPercent":40}
%---
%[text:image:504f]
%   data: {"align":"middle","height":24,"src":"data:image\/png;base64,iVBORw0KGgoAAAANSUhEUgAAABgAAAAYCAYAAADgdz34AAAAjElEQVR42mP4\/\/8\/AwgnJiYapKamfgfS\/ynBUDMMYOYywBggiYcPH\/6nFIDMAJmFYQHIdmoBqFm4LZjrYPd\/gpoyGIPYVLeA5j6gmwUlJaVAxUlgDGKPBhFODaQG1QgIoqKtr\/6r99wlCYP0EG0BSMOWe\/9JwiA9oxaMWkBHC2ieD2iSk+lR6dOk2QIAjF+EgB\/BqfoAAAAASUVORK5CYII=","width":24}
%---
%[text:image:002f]
%   data: {"align":"baseline","height":24,"src":"data:image\/png;base64,iVBORw0KGgoAAAANSUhEUgAAACgAAAAsCAYAAAAXb\/p7AAADlklEQVR42u1YS0hUYRQejR4UvR+SvaCyWiS2DIoCKWjVYzG2SsYWQ+a8HRwXFkOgqdGLSoSeqyBaJUGLCKGkNpGtgiyScnpYBpaU5au+E+eH03Wu93rvP2OEFw46955z\/u8\/7\/\/3eDQ+4XD4Eui65199AK4d1DEJcBLgfw0wGo2ujkQi1yoqKlY5AFgDqnWw5lpaMxaLrbBkDgaDm7HIEKjTCcjxPqFQqABrdYEGsHaRXaESCAyCXpNFMwwuReDw\/77xusurQGJna0ysPR2K94CnGdQKesnUyu92J5PJaelk4c51Chzcu9dp0O9nkO3yvd\/vnwqlEbzvAf2yoB5sIkwyBt0doJ+0Qbdu2AXyC8UrOVuNQH5Q3IJegfrTfH8ikwC\/A9hjsdaYCQQCG6D4vVj0DShB7+HKXMGaQ\/EFADEGrPhJdn1GAhoZvRDKX4jFTvt8vhlWchSD4D0OGiE5AH9eXl4+PxNF+IoCB8sccyBfreQB8qJWcAC0CYqHeYE2cqEDNTmQvcc6hlC+CnXWq\/PCtTtdeGGr0HNWFz7aeTcr\/eT1eqe41PVWJYxd62zkovwXqQ6Cv8vErm9r8MZNEctLVf9Ph4GwecSOjPSQu8V28e6chmRrFPq28btHJhhSBKDIBH0B726HEDilAWCtsGCx6MmjMNgaHqBkiygPl3UmHE1OrjOEiqoqsqDHGizYxrqGAXCOriL9jJUOoq3lO9UDQItpQGD3PtXZRapFHB51oSchwiWsDWA8Hl8Cpb2svA+WWO4AXJ7Q0Z1IJObq7sUBN\/UQLr0hrHfANSCaQihrobiBf+dC+QOxSNk4MrdEyN1VvRy6T+DdVbOp2wpcCyutN8yDahjtVZ3A4sS2ALwflYxhaK1n0C22QfL8dkuNRYZBlKxxRLj6gg3XNgj+w8beLOriHcv50gocJ8wsfP\/ASgfMDlRs8XzwfGPeThMr2QcpEqFprJmPSoSwSvMYfCcFX6nFlNPEfAGrUuC1GkhxQpspTnTfKysrFxl5qqqqZouy0mU81ZmApB6cp2vKlrFVk+Z7TGRuPOsXRZSNfGYmEO\/ofoXmOiKKS3Ga6wPYeRNxk9Vo49BONAIL1mUdIBa9bxPgn+zMOkAqIXDdQbp1sKAy6uWeyWd0Cyuk5LDh3pTtez\/NSVJqNwbh5kNZB8htkTrP1zHA9dM1nZ07nExmc50ZQGA7M+GxyLden9MA\/OLm\/KKe34xPoKAD7jPkAAAAAElFTkSuQmCC","width":22}
%---
%[text:image:1a91]
%   data: {"align":"baseline","height":23,"src":"data:image\/png;base64,iVBORw0KGgoAAAANSUhEUgAAADoAAAA6CAYAAADhu0ooAAAEp0lEQVR42t2a208TQRTG67OJxvv9fiGoD6LGgPiCGo1G\/wljTKDl1pL00RuKIKCIIiKg6ItB8IJ38K4Panz13RcfSBBBQQHRek4ys\/kYpu1uu2132+Sku6eb6X7zmzlz5ux6PEn6lJaWbi0uLu4mGyLrJWvMz8+f4UmnjxA5QhZS7HNZWdnUdNE5hQR9EsLGioqKWuj7kRRbUlJSmS40D4Co4yD+rfAPEdW5rhdKQj4KQQM4J0n0DhjCVW4XuR9oHlV\/J98rSZVsnmuF0nz8oNIsLCxcFQwGp4vf86AjzrhV5D4dTTq+Tr8d0VD95fP5Frpx2L4XAgYlTQpMq+n8DxKm4+0wV6tdJZIo7YWbPwbi26QfqdL5S+H\/7SqqdMPvJE2iOFPOTUEzpM5bpEodUOMWkXs06yb7r6qZEc5dOn\/hKqqQCESiOYkqic4Ff62jRZKg3XCzJ0B8q0akjupzSZU6aZGTl5Q34kZ\/BgKB2ezzer3LOMcNJ5SpSvJIlY7POTWn3QUBpRzEt0QQqYvMzxxNlW7staRJQ3gO0Bw1IdSYz9Qx28Bf57QhuxNu7iSIbzYhclKEpvZ6HElVR5OOl5qkGZEqdcB5p9DMC0OzyYJIXaTuFr4R6rzFTkj3jK1WHDRDarSmdnPAX59qkbkQaU+B\/7IqglM7+g4qVqu5rhzaeeoIqpC2RaVJN52pGfYbdFRlW0iVrr2QcppkFSC+MUxUNSt0AlU6f5JSqpCuGcUtv9+\/JExZ05JQpErf2eC\/mOxIi4v6aRDfEGGdtCJUjeCPhW+Uk5BkCu2xQjNGoQZVWl+30Pk\/4W9I1tzM0RWfeVhFyXysCp0QyaHoPUZtLU\/G3OxWadIfL+Dilt1CMZrTtZuB6qVE7zezdUVnDv0mctlYhKpUHyaFKoR6SzTjEYr\/pVBtTDhNLDZz0m1ydxKrUHWdfiCp+ny+FYmgKUP8sHx8YJamDUK1VDnVtHs5wSFTDeLrLOw34xGqrtf3E0IVgoBRiiwoKJhvlqZNQjEubIKOb7Jr3TQaxeIyF6+sbMFsEKqu2\/ZShQZVmsPJFhqOKrVzxTaaWFTW7SNNCD3IlUI08h2KYXOO63eXpErtrYwnCHWpNDniWqVpsxlUacnLAhDNsa6bWTqaolIQSrFVwei6FxdVGlZ3baY5SNav2KCdVLlYblXkRqB5FnqvOlYKNgWjUJjsTEIZpzbXWIm0d9QCMlfneI\/oFKFKhoZgWs0GIP7zv+qDHu7BeOZVAoSqWZqEM+73+9eaodlpN80ECjXiBwLih87Rnoith4vrgGZlvJEyQUJVqrdNUaULOmRp0U6a8uUMssNo\/BDYBqHDnKlppt21qDTxwQ7vGhywbkbrxBrN1Bsny9DRbFcLxV6vdxad\/3C6UJyryvRrU7OgdfBjPYivcIHIkCYX79BSpZObLqYZkSq\/kicjaqZ04oMcrpS7SGRIzeJIy60JVDk6SZpcbRdDeRr5v2hyU6fbV\/l8VVlXm5lcX0wJsTveYpMVw14PzMOGNBQqE4h+3M8x5hti3UwH64S52y6D0YALA49Z6+P3hCXiDLH2fEsjgd+ZKr9wyRr\/A+UKAPezYlA8AAAAAElFTkSuQmCC","width":23}
%---
%[text:image:723a]
%   data: {"align":"baseline","height":20,"src":"data:image\/png;base64,iVBORw0KGgoAAAANSUhEUgAAADUAAAAxCAYAAAB6d+FmAAAC0ElEQVR42u2aO4gTURSGs6Lugo1WW2ghgiyCr1VWbRSR9YEgKoKohcQmEDAviYhBIaVbbKEWYi22YidoobUItoqwjSui6wt119Wsj+\/onXAcJslMZpI7AxP4Sbh37pnz3TP3zJ2TyWQS9imVStvRK1G5XL5ZqVRWZpL8MUCf0G+lz+hYIoGIyDYPIEc\/i8ViLmkRGkMfWwA5WkD7EwHEutmCs+87ADl6zfHLm4MLhcIqGs7RcV0WoA1xCa3vIkL\/CTsX\/w7G2Bka5oIMjlo4M6GBmOTRABHSeirh3S0LzSYQugHHgAPEJG+l7UOXtr6LgQeqYQZdRVf6Jc5frdfriyKIkOgHQToi1+0XpxGD+ywnhc348a5bICboqLMYmx02784hgRYAOqEzjHWoSIHiABU5kG2osECMP9lqC2IFiqS0qSdAtqAM0Ey3QOhUp81iX6F6DtRvKM6xsedA\/YQKCdQgyx0PcrKeQ4WNkE4K+LhGb6usQOHQOnnOCb31+WdrNW1TQC22BoW9Ddh9i6bRfNDdNkCH1c59LW0vpc8qFDYfo\/tkvMFqtbqM3xdkffgAmseXQ44dM3ba6bcGlc1mh9yzbaK3k\/Y37YAYc9Dl47A+xhoU0dlh7A579I3qRx6lbwAd8PAxHlA4V5BF3ea8Z11Ac62e52IDhb1bZuZL+lFdRWtQpflZzj3exlZsIvVc2b7jdW8xiWSWVL2ng4\/2ofL5\/Ars\/XJdXudN9wC\/R4Ce5PurFH58RN0+FLb2et130D1VVJlCu3zasw9FFC67dwboialUnZadQcBJsg+F09ewd9tkwLFcLrckZOTjkSgi3pmkUClUCpVCpVApVAqVQqVQ0UDp6s5IHKFMeaz5doufYuYz9bf\/XXmXQaqgcZH4I34pqBd+Qluz\/LpBUF3qCEUol3LgwyQAEbFHUrDxW6OTyk7NFEsaMYNpGL9qfoH+AOOEPfJuI6OmAAAAAElFTkSuQmCC","width":22}
%---
%[text:image:01cc]
%   data: {"align":"baseline","height":24,"src":"data:image\/png;base64,iVBORw0KGgoAAAANSUhEUgAAACgAAAAsCAYAAAAXb\/p7AAADlklEQVR42u1YS0hUYRQejR4UvR+SvaCyWiS2DIoCKWjVYzG2SsYWQ+a8HRwXFkOgqdGLSoSeqyBaJUGLCKGkNpGtgiyScnpYBpaU5au+E+eH03Wu93rvP2OEFw46955z\/u8\/7\/\/3eDQ+4XD4Eui65199AK4d1DEJcBLgfw0wGo2ujkQi1yoqKlY5AFgDqnWw5lpaMxaLrbBkDgaDm7HIEKjTCcjxPqFQqABrdYEGsHaRXaESCAyCXpNFMwwuReDw\/77xusurQGJna0ysPR2K94CnGdQKesnUyu92J5PJaelk4c51Chzcu9dp0O9nkO3yvd\/vnwqlEbzvAf2yoB5sIkwyBt0doJ+0Qbdu2AXyC8UrOVuNQH5Q3IJegfrTfH8ikwC\/A9hjsdaYCQQCG6D4vVj0DShB7+HKXMGaQ\/EFADEGrPhJdn1GAhoZvRDKX4jFTvt8vhlWchSD4D0OGiE5AH9eXl4+PxNF+IoCB8sccyBfreQB8qJWcAC0CYqHeYE2cqEDNTmQvcc6hlC+CnXWq\/PCtTtdeGGr0HNWFz7aeTcr\/eT1eqe41PVWJYxd62zkovwXqQ6Cv8vErm9r8MZNEctLVf9Ph4GwecSOjPSQu8V28e6chmRrFPq28btHJhhSBKDIBH0B726HEDilAWCtsGCx6MmjMNgaHqBkiygPl3UmHE1OrjOEiqoqsqDHGizYxrqGAXCOriL9jJUOoq3lO9UDQItpQGD3PtXZRapFHB51oSchwiWsDWA8Hl8Cpb2svA+WWO4AXJ7Q0Z1IJObq7sUBN\/UQLr0hrHfANSCaQihrobiBf+dC+QOxSNk4MrdEyN1VvRy6T+DdVbOp2wpcCyutN8yDahjtVZ3A4sS2ALwflYxhaK1n0C22QfL8dkuNRYZBlKxxRLj6gg3XNgj+w8beLOriHcv50gocJ8wsfP\/ASgfMDlRs8XzwfGPeThMr2QcpEqFprJmPSoSwSvMYfCcFX6nFlNPEfAGrUuC1GkhxQpspTnTfKysrFxl5qqqqZouy0mU81ZmApB6cp2vKlrFVk+Z7TGRuPOsXRZSNfGYmEO\/ofoXmOiKKS3Ga6wPYeRNxk9Vo49BONAIL1mUdIBa9bxPgn+zMOkAqIXDdQbp1sKAy6uWeyWd0Cyuk5LDh3pTtez\/NSVJqNwbh5kNZB8htkTrP1zHA9dM1nZ07nExmc50ZQGA7M+GxyLden9MA\/OLm\/KKe34xPoKAD7jPkAAAAAElFTkSuQmCC","width":22}
%---
%[text:image:2042]
%   data: {"align":"baseline","height":26,"src":"data:image\/png;base64,iVBORw0KGgoAAAANSUhEUgAAAB4AAAApCAYAAAAiT5m3AAADOElEQVR42r1XSWgUQRSNGndR3Ii7V\/EmCCp4DaIe1Oh4EMHBwMjsq47Eg+OOJ0VIICAeFAIeXEADHgyoqChE1ASNhISAxH0jg5gxq+\/FX1A009PTM93T8OiuX7\/q1f+\/+tevqqoCTyKRWBmNRo8Cj4GPwF++I5HII7zT8Xh8eZWTTzgcnh6Lxc5j8kFgHMgCT4G7wBPgl8j\/YBGnfT7f1LJJg8HgQrGQE3diAXVciK5DIsi3o7+devh+4Pf755dMmslkpmGih0LaiHa1hf5k6J0T\/TYrfdMHKz8pFjTr1kFWD9ltvJ8Bt\/Dt1d0rYeG4Y7ZJMbAG+A300HLKuHkw2SuxKAe8lQ3Gdjv6llLP4\/FMQfs1MMBQ2SUOyaoPihur0X4BDGEDHVGLYbwhawCG6QG6W6yu43jo+uwSt3IyWLlA2vt09+F7CwlDodAaaZ+Q\/j3inZn0GENil\/gd0Ke1rwEjgUBgDqzYIe4lBiBbkkqlZov7r2hjXtLldom\/0LVa+x7QK9+NGjHduUvkfcAdbUwb0G+XuNtg8WV6QeLXbCDeKzo9QJM2phPosEt8ExijG9nG5NuKJK6VTTeXrofudbvEh2TS49r\/eakQMeQXNV2v9Nfbzc9c8U\/GWv2LKkmYEat+r9c7Q+L9nZvOdhLBhOF86c+MWJ5JkLVIX6jUdM1Jbsgk3NU1RRBPHCzQ2crxZR0U3CBC8saKGO3NCNNGx85kpk4QPLfaXJr8jGPkKs4FfqesJv9kcP1OvFeXa70Z8Ygmz1KWTCYX4fuDqlAQhnUVIWafQfesXjjgF5zlCrGWSBQuyOm1nuEARqGTqRgxKxejrm1iYL+URKPFEktJrGSDpRJ3aYlGYRhFwjK8T+lyle+1yrUsYjMM5ZG9l0tBzk3iYvGfWE6XVWYniyvEci1RgjEpZwP6Itwi7jfppHy31Mz3HSeGNZvw8aOAUs5h0olUqqqPFVIhjlcI34wXsMMuWWhEb76ibwPw1U1ibmCzwm+tdil3HEyfhcrdBhetbrW6pHe5RNxiVeTXukTcVEyevupCjA9YEqfT6XlyGXOKuINnQ1GnEy9y6uJeBuFn3qXxxyzmnP8Amz0wy7TM4YgAAAAASUVORK5CYII=","width":19}
%---
%[text:image:57c0]
%   data: {"align":"baseline","height":24,"src":"data:image\/png;base64,iVBORw0KGgoAAAANSUhEUgAAACgAAAAsCAYAAAAXb\/p7AAADlklEQVR42u1YS0hUYRQejR4UvR+SvaCyWiS2DIoCKWjVYzG2SsYWQ+a8HRwXFkOgqdGLSoSeqyBaJUGLCKGkNpGtgiyScnpYBpaU5au+E+eH03Wu93rvP2OEFw46955z\/u8\/7\/\/3eDQ+4XD4Eui65199AK4d1DEJcBLgfw0wGo2ujkQi1yoqKlY5AFgDqnWw5lpaMxaLrbBkDgaDm7HIEKjTCcjxPqFQqABrdYEGsHaRXaESCAyCXpNFMwwuReDw\/77xusurQGJna0ysPR2K94CnGdQKesnUyu92J5PJaelk4c51Chzcu9dp0O9nkO3yvd\/vnwqlEbzvAf2yoB5sIkwyBt0doJ+0Qbdu2AXyC8UrOVuNQH5Q3IJegfrTfH8ikwC\/A9hjsdaYCQQCG6D4vVj0DShB7+HKXMGaQ\/EFADEGrPhJdn1GAhoZvRDKX4jFTvt8vhlWchSD4D0OGiE5AH9eXl4+PxNF+IoCB8sccyBfreQB8qJWcAC0CYqHeYE2cqEDNTmQvcc6hlC+CnXWq\/PCtTtdeGGr0HNWFz7aeTcr\/eT1eqe41PVWJYxd62zkovwXqQ6Cv8vErm9r8MZNEctLVf9Ph4GwecSOjPSQu8V28e6chmRrFPq28btHJhhSBKDIBH0B726HEDilAWCtsGCx6MmjMNgaHqBkiygPl3UmHE1OrjOEiqoqsqDHGizYxrqGAXCOriL9jJUOoq3lO9UDQItpQGD3PtXZRapFHB51oSchwiWsDWA8Hl8Cpb2svA+WWO4AXJ7Q0Z1IJObq7sUBN\/UQLr0hrHfANSCaQihrobiBf+dC+QOxSNk4MrdEyN1VvRy6T+DdVbOp2wpcCyutN8yDahjtVZ3A4sS2ALwflYxhaK1n0C22QfL8dkuNRYZBlKxxRLj6gg3XNgj+w8beLOriHcv50gocJ8wsfP\/ASgfMDlRs8XzwfGPeThMr2QcpEqFprJmPSoSwSvMYfCcFX6nFlNPEfAGrUuC1GkhxQpspTnTfKysrFxl5qqqqZouy0mU81ZmApB6cp2vKlrFVk+Z7TGRuPOsXRZSNfGYmEO\/ofoXmOiKKS3Ga6wPYeRNxk9Vo49BONAIL1mUdIBa9bxPgn+zMOkAqIXDdQbp1sKAy6uWeyWd0Cyuk5LDh3pTtez\/NSVJqNwbh5kNZB8htkTrP1zHA9dM1nZ07nExmc50ZQGA7M+GxyLden9MA\/OLm\/KKe34xPoKAD7jPkAAAAAElFTkSuQmCC","width":22}
%---
%[text:image:3a09]
%   data: {"align":"baseline","height":20,"src":"data:image\/png;base64,iVBORw0KGgoAAAANSUhEUgAAADUAAAAxCAYAAAB6d+FmAAAC0ElEQVR42u2aO4gTURSGs6Lugo1WW2ghgiyCr1VWbRSR9YEgKoKohcQmEDAviYhBIaVbbKEWYi22YidoobUItoqwjSui6wt119Wsj+\/onXAcJslMZpI7AxP4Sbh37pnz3TP3zJ2TyWQS9imVStvRK1G5XL5ZqVRWZpL8MUCf0G+lz+hYIoGIyDYPIEc\/i8ViLmkRGkMfWwA5WkD7EwHEutmCs+87ADl6zfHLm4MLhcIqGs7RcV0WoA1xCa3vIkL\/CTsX\/w7G2Bka5oIMjlo4M6GBmOTRABHSeirh3S0LzSYQugHHgAPEJG+l7UOXtr6LgQeqYQZdRVf6Jc5frdfriyKIkOgHQToi1+0XpxGD+ywnhc348a5bICboqLMYmx02784hgRYAOqEzjHWoSIHiABU5kG2osECMP9lqC2IFiqS0qSdAtqAM0Ey3QOhUp81iX6F6DtRvKM6xsedA\/YQKCdQgyx0PcrKeQ4WNkE4K+LhGb6usQOHQOnnOCb31+WdrNW1TQC22BoW9Ddh9i6bRfNDdNkCH1c59LW0vpc8qFDYfo\/tkvMFqtbqM3xdkffgAmseXQ44dM3ba6bcGlc1mh9yzbaK3k\/Y37YAYc9Dl47A+xhoU0dlh7A579I3qRx6lbwAd8PAxHlA4V5BF3ea8Z11Ac62e52IDhb1bZuZL+lFdRWtQpflZzj3exlZsIvVc2b7jdW8xiWSWVL2ng4\/2ofL5\/Ars\/XJdXudN9wC\/R4Ce5PurFH58RN0+FLb2et130D1VVJlCu3zasw9FFC67dwboialUnZadQcBJsg+F09ewd9tkwLFcLrckZOTjkSgi3pmkUClUCpVCpVApVAqVQqVQ0UDp6s5IHKFMeaz5doufYuYz9bf\/XXmXQaqgcZH4I34pqBd+Qluz\/LpBUF3qCEUol3LgwyQAEbFHUrDxW6OTyk7NFEsaMYNpGL9qfoH+AOOEPfJuI6OmAAAAAElFTkSuQmCC","width":22}
%---
%[text:image:16c7]
%   data: {"align":"baseline","height":24,"src":"data:image\/png;base64,iVBORw0KGgoAAAANSUhEUgAAACgAAAAsCAYAAAAXb\/p7AAADlklEQVR42u1YS0hUYRQejR4UvR+SvaCyWiS2DIoCKWjVYzG2SsYWQ+a8HRwXFkOgqdGLSoSeqyBaJUGLCKGkNpGtgiyScnpYBpaU5au+E+eH03Wu93rvP2OEFw46955z\/u8\/7\/\/3eDQ+4XD4Eui65199AK4d1DEJcBLgfw0wGo2ujkQi1yoqKlY5AFgDqnWw5lpaMxaLrbBkDgaDm7HIEKjTCcjxPqFQqABrdYEGsHaRXaESCAyCXpNFMwwuReDw\/77xusurQGJna0ysPR2K94CnGdQKesnUyu92J5PJaelk4c51Chzcu9dp0O9nkO3yvd\/vnwqlEbzvAf2yoB5sIkwyBt0doJ+0Qbdu2AXyC8UrOVuNQH5Q3IJegfrTfH8ikwC\/A9hjsdaYCQQCG6D4vVj0DShB7+HKXMGaQ\/EFADEGrPhJdn1GAhoZvRDKX4jFTvt8vhlWchSD4D0OGiE5AH9eXl4+PxNF+IoCB8sccyBfreQB8qJWcAC0CYqHeYE2cqEDNTmQvcc6hlC+CnXWq\/PCtTtdeGGr0HNWFz7aeTcr\/eT1eqe41PVWJYxd62zkovwXqQ6Cv8vErm9r8MZNEctLVf9Ph4GwecSOjPSQu8V28e6chmRrFPq28btHJhhSBKDIBH0B726HEDilAWCtsGCx6MmjMNgaHqBkiygPl3UmHE1OrjOEiqoqsqDHGizYxrqGAXCOriL9jJUOoq3lO9UDQItpQGD3PtXZRapFHB51oSchwiWsDWA8Hl8Cpb2svA+WWO4AXJ7Q0Z1IJObq7sUBN\/UQLr0hrHfANSCaQihrobiBf+dC+QOxSNk4MrdEyN1VvRy6T+DdVbOp2wpcCyutN8yDahjtVZ3A4sS2ALwflYxhaK1n0C22QfL8dkuNRYZBlKxxRLj6gg3XNgj+w8beLOriHcv50gocJ8wsfP\/ASgfMDlRs8XzwfGPeThMr2QcpEqFprJmPSoSwSvMYfCcFX6nFlNPEfAGrUuC1GkhxQpspTnTfKysrFxl5qqqqZouy0mU81ZmApB6cp2vKlrFVk+Z7TGRuPOsXRZSNfGYmEO\/ofoXmOiKKS3Ga6wPYeRNxk9Vo49BONAIL1mUdIBa9bxPgn+zMOkAqIXDdQbp1sKAy6uWeyWd0Cyuk5LDh3pTtez\/NSVJqNwbh5kNZB8htkTrP1zHA9dM1nZ07nExmc50ZQGA7M+GxyLden9MA\/OLm\/KKe34xPoKAD7jPkAAAAAElFTkSuQmCC","width":22}
%---
%[control:dropdown:3aa6]
%   data: {"defaultValue":"firstOrderBackwardApprox","itemLabels":["firstOrderBackwardApprox","secondOrderBackwardApprox"],"items":["firstOrderBackwardApprox","secondOrderBackwardApprox"],"label":"Select the approximation to plot: ","run":"Section"}
%---
