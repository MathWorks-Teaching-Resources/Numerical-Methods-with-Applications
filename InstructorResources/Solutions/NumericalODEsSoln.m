%[text] %[text:anchor:T_74fb] # Numerical Methods for Ordinary Differential Equations
%[text] [⇦ Main Menu](file:../../MainMenu.m)
%[text] Differential equations show up in a wide range of contexts, from population modeling or engineering dynamics to pharmaco-kinetics or solving circuits. While some of these scenarios lend themselves to analytic, closed-form solutions, in many cases the solution must be approximated using a numerical method. In situations where the solution is unknown, it is important to have a clear idea of how much error may be present in a numerical solution. There are two types of error that can contribute to the total error of a numerical solution: roundoff error and discretization error. Recognizing roundoff error and controlling discretization error are required to implement numerical methods to solve differential equations.
%[text:tableOfContents]{"heading":"**Table of Contents**"}
%%
%[text] This live script is intended to be used with the code visible and output inline. On the **View** tab of the MATLAB Toolstrip, in the **View** section, select **Output Inline**. Alternately, select **Output Inline** using the icon ![live script output inline icon](text:image:40a6) at the top right of the Live Editor pane.
%[text] ![Lightbulb mark](text:image:643c) Interacting with this live script will build some familiarity with MATLAB as concepts and commands are introduced together. If you need more instruction, consider taking [MATLAB Onramp](https://matlabacademy.mathworks.com/details/matlab-onramp/gettingstarted), a free 2-hour online tutorial that teaches the essentials of MATLAB.
%[text] ![Warning symbol](text:image:0a3c)   For an optimal experience, follow the instructions and steps in the given sequence. Proceed to a new section only after completing the preceding one. Some sections depend on variables created in prior sections and they will generate errors if run out of order.
%%
%[text] %[text:anchor:H_4ffe] ## Numerical methods are commonly used for solving differential equations
%[text] %[text:anchor:H_CE0A8A9C] If you think about it, [numerical integration](<matlab: edit NumericalIntegration.m>) is already a method for solving differential equations of the form $\\frac{dy}{dt} = f(t)${"altText":"(dy)\/(dt) = f(t)"}. In this script, we will consider the requirements to expand our methods to solve $\\frac{dy}{dt} = f(t,y)${"altText":"(dy)\/(dt) = f(t,y)"} and explore the usefulness of systems of differential equations. 
%%
%[text] %[text:anchor:H_22e8] ## Euler's Method
%[text] The simplest method of solving a first-order initial value problem is to start at a known value $(t\_0,y\_0)${"altText":"(t\_0,y\_0)"} and attempt to follow a function $y(t)${"altText":"y(t)"} that is changing at a known rate given by the differential equation $\\frac{dy}{dt}=f(t,y)${"altText":"(dy)\/(dt)=f(t,y)"}. Let's move with constant step size $\\Delta t = h${"altText":"Delta t = h"}. This information allows us to create a piecewise-linear function:
%[text]{"align":"center"} $y\_{\\text{approx}} = \\begin{cases} y\_0 + f(t\_0,y\_0)(t-t\_0) & t\_0 \\leq t \< t\_0+h = t\_1 \\\\ y\_1 + f(t\_1,y\_1)(t-t\_1) & t\_1 \\leq t \< t\_1+h = t\_2\\\\ \\vdots \\\\ y\_n+f(t\_n,y\_n)(t-t\_n) & t\_n \\leq t \< t\_n+h = t\_{n+1} \\end{cases}${"altText":"y\_{approx} = cases: y\_0 + f(t\_0,y\_0)(t-t\_0) for t\_0 \<= t \< t\_0+h = t\_1 ; y\_1 + f(t\_1,y\_1)(t-t\_1) for t\_1 \<= t \< t\_1+h = t\_2; ... ; y\_n+f(t\_n,y\_n)(t-t\_n) for t\_n \<= t \< t\_n+h = t\_{n+1}"},
%[text] where $y\_n = y\_{\\text{approx}}(t\_n)${"altText":"y\_n = y\_{approx}(t\_n)"}.
%[text] It is more common to organize this into a table:
%[text]{"align":"center"} $\\matrix{k & t\_k = t\_{k-1}+h  & \\;\\;\\;f(t\_k,y\_k) & \\;\\;y\_{k+1} = y\_k+f(t\_k,y\_k)h}${"altText":"matrix \[k, t\_k = t\_{k-1}+h, f(t\_k,y\_k), y\_{k+1} = y\_k+f(t\_k,y\_k)h\]"}
%[text]{"align":"center"} $\\pmatrix{ 0 & t\_0 & f(t\_0,y\_0) & y\_0+f(t\_0,y\_0)h \\cr 1 & t\_0+h & f(t\_0+h,y\_1) & y\_1 + f(t\_0+h,y\_1)h \\cr 2 & \\;\\;\\;t\_0+2h\\;\\;\\; & f(t\_0+2h,y\_2) & y\_2 + f(t\_0+2h,y\_2)h \\cr \\vdots & \\vdots & \\vdots & \\vdots \\cr n & t\_0 + nh & f(t\_0+nh,y\_n) & y\_n + f(t\_0+nh,y\_n)h}${"altText":"matrix \[0, t\_0, f(t\_0,y\_0), y\_0+f(t\_0,y\_0)h; 1, t\_0+h, f(t\_0+h,y\_1), y\_1 + f(t\_0+h,y\_1)h; 2, t\_0+2h, f(t\_0+2h,y\_2), y\_2 + f(t\_0+2h,y\_2)h; ..., ..., ..., ...; n, t\_0 + nh, f(t\_0+nh,y\_n), y\_n + f(t\_0+nh,y\_n)h\]"}
%[text] 
%[text] %[text:anchor:H_BF23D876] ![](text:image:80a4)**Exercise 1: Implement Euler's method to solve first-order initial value problems**
%[text] Write a function to implement Euler's method given a function handle, an initial value, a step size, and a number of steps to take.
edit("eulerMethodDESoln.m")
%%
% % Uncomment this section to test your eulerMethod function
errorAtEnd = TestEulerDECode(@eulerMethodDESoln,@(t,y) 2*t*sin(y),[0,1],10,0.5)
%[text] For comparison, with 
%[text] ```matlabCodeExample
%[text] errorAtEnd = TestEulerDECode(@eulerMethodDESoln,@(t,y) 2*t*sin(y),[0,1],10,0.5) 
%[text] ```
%[text] your solution should return `errorAtEnd = -0.8080` and look like:
%[text]{"align":"center"} ![A screenshot of the expected output of eulerMethod showing that the approximation oscillates and diverges rapidly from the exact solution](text:image:6c27)
%[text] %[text:anchor:H_5800247F] ![](text:image:3e56)**Try different values**
%[text] 1. Are there values of $h${"altText":"h"} that result in good solutions for $\\frac{dy}{dt} = 2t\\sin(y)${"altText":"(dy)\/(dt) = 2tsin(y)"} with $y(0)=1${"altText":"y(0)=1"} between $t=0${"altText":"t=0"} and $t=5${"altText":"t=5"}? 
%[text] 2. With the function $\\frac{dy}{dx} = 3y^2+2x-1${"altText":"(dy)\/(dx) = 3y^2+2x-1"} and $(x\_0,y\_0)=(0,1)${"altText":"(x\_0,y\_0)=(0,1)"}, can you find a value for `h` that has an error of less than 0.01 from the true solution at $x=1${"altText":"x=1"}?
%[text] 3. What happens if you try different functions such as $\\frac{dy}{dt} = \\sin(y)${"altText":"(dy)\/(dt) = sin(y)"} or $\\frac{dy}{dt} = e^y${"altText":"(dy)\/(dt) = e^y"} or $\\frac{dy}{dt} = \\frac{1}{t^2+y^2+1}${"altText":"(dy)\/(dt) = (1)\/(t^2+y^2+1)"}?
%[text] 4. How does your approximation change if you change the initial condition? What if you only change the $y\_0${"altText":"y\_0"} value? Or only the $t\_0${"altText":"t\_0"} value? \
%%
%[text] %[text:anchor:H_27c5] ### Use Euler's method to investigate error
%[text] %[text:anchor:H_6cd6] #### **Local error: a property of the method**  
%[text] Assume we have a solution $y = \\phi(t)${"altText":"y = phi (t)"} to an initial value problem $\\frac{dy}{dt} = f(y,t)${"altText":"(dy)\/(dt) = f(y,t)"} with $y(t\_0) = y\_0${"altText":"y(t\_0) = y\_0"}, and that $\\phi(t)${"altText":"phi (t)"} has a continuous second-order derivative. This means that at a point $t\_n${"altText":"t\_n"}, we know the solution $y\_n = \\phi(t\_n)${"altText":"y\_n = phi (t\_n)"} and the solution at $y\_{n+1} = \\phi(t\_n+h)${"altText":"y\_{n+1} = phi (t\_n+h)"}, where $h = t\_{n+1}-t\_n \> 0${"altText":"h = t\_{n+1}-t\_n \> 0"}. 
%[text] ![](text:image:479b)**Exercise 2:**
%[text] Using a Taylor series expansion of $y\_{n+1} = \\phi(t\_{n+1}) = \\phi(t\_n+h)${"altText":"y\_{n+1} = phi (t\_{n+1}) = phi (t\_n+h)"} and the Euler approximation $y\_{n}^{\\text{approx}}(t\_{n+1}) = y\_n + f(y\_n,t\_n)h${"altText":"y\_{n}^{approx}(t\_{n+1}) = y\_n + f(y\_n,t\_n)h"}, compute the theoretical error 
%[text]{"align":"center"} $\\text{local error} = y\_{n+1}-y\_{n}^{\\text{approx}}(t\_{n+1}) \\leq Rh^k${"altText":"local error = y\_{n+1}-y\_{n}^{approx}(t\_{n+1}) \<= Rh^k"}, 
%[text] where $R${"altText":"R"} is a constant that can depend on the function $\\phi${"altText":"phi"} and value $t\_n${"altText":"t\_n"}. 
%[text] Hint: You may want to review the error calculation presented in the [Numerical Integration script](file:./NumericalIntegrationSoln.m). 
%[text] **Solution:** 
%[text] Show your calculations here. You can test your result with the following code using $k =${"altText":"k ="} `kLocal`.
% %% Solution
%[text] Expanding by Taylor series around $t\_n${"altText":"t\_n"} we have:
%[text] $\\phi(t\_n+h) = \\phi(t\_n)+\\phi'(t\_n)h + \\frac{\\phi''(t\_n)}{2}h^2 + \\mathcal{O}(h^3)${"altText":"phi (t\_n+h) = phi (t\_n)+ phi '(t\_n)h + (phi ''(t\_n))\/(2)h^2 + O(h^3)"}
%[text] However, $\\phi'(t\_n) = f(y\_n,t\_n)${"altText":"phi '(t\_n) = f(y\_n,t\_n)"}, and $\\phi(t\_n) = y\_n${"altText":"phi (t\_n) = y\_n"}, because we know that $\\phi(t)${"altText":"phi (t)"} is a solution to the initial value problem. Thus,
%[text] $\\phi(t\_n+h) = y\_n+f(y\_n,t\_n)h + \\frac{\\phi''(t\_n)}{2}h^2 + \\mathcal{O}(h^3)${"altText":"phi (t\_n+h) = y\_n+f(y\_n,t\_n)h + (phi ''(t\_n))\/(2)h^2 + O(h^3)"}. 
%[text] We know that $y\_n^{\\text{approx}}(t\_{n+1}) = y\_n + f(y\_n,t\_n)h${"altText":"y\_n^{approx}(t\_{n+1}) = y\_n + f(y\_n,t\_n)h"}, so 
%[text]{"align":"center"} $\\text{local error} = y\_{n+1}-y\_{n}^{\\text{approx}}(t\_{n+1}) ${"altText":"local error = y\_{n+1}-y\_{n}^{approx}(t\_{n+1})"} 
%[text]{"align":"center"} $= \\left(y\_n+f(y\_n,t\_n)h + \\frac{\\phi''(t\_n)}{2}h^2 + \\mathcal{O}(h^3)\\right) - \\left(y\_n+f(y\_n,t\_n)h\\right)${"altText":"= (y\_n+f(y\_n,t\_n)h + (phi ''(t\_n))\/(2)h^2 + O(h^3)) - (y\_n+f(y\_n,t\_n)h)"}
%[text]{"align":"center"} $= \\frac{\\phi''(t\_n)}{2}h^2 + \\mathcal{O}(h^3)${"altText":"= (phi ''(t\_n))\/(2)h^2 + O(h^3)"} 
%[text]{"align":"center"}  $\\leq Rh^2${"altText":"\<= Rh^2"} 
%[text] where $\\displaystyle R= \\max\_{t\_n\\leq t \\leq t\_{n+1}}\\frac{|\\phi''(t)|}{2}${"altText":"R= max\_{t\_n \<= t \<= t\_{n+1}}(| phi ''(t)|)\/(2)"} comes from Taylor's theorem and the fact that $h \> 0${"altText":"h \> 0"}. 
% %% End Solution
%[text] 
% Replace 0 with your result
kLocal = 2;
CheckError(kLocal,"forwardEuler","local")
%%
%[text] %[text:anchor:H_56db] #### **Global error: a property of the method**
%[text] To reach a value $y\_n${"altText":"y\_n"} from $y\_0${"altText":"y\_0"} requires $n${"altText":"n"} steps, each of which will contribute a portion of local error. 
%[text] ![](text:image:1da2)**Exercise 3:** 
%[text] Explain why the theoretical global error is
%[text]{"align":"center"} $\\text{global error} = y\_{n}-y\_0^{\\text{approx}}(t\_{n}) \\leq Mh^{k}${"altText":"global error = y\_{n}-y\_0^{approx}(t\_{n}) \<= Mh^{k}"},
%[text] where $y\_0^{\\text{approx}}(t\_{n}) = y\_0^{\\text{approx}}(t\_{n-1}) + f(y\_0^{\\text{approx}}(t\_{n-1}),t\_{n-1})h${"altText":"y\_0^{approx}(t\_{n}) = y\_0^{approx}(t\_{n-1}) + f(y\_0^{approx}(t\_{n-1}),t\_{n-1})h"} with $y\_0^{\\text{approx}}(t\_0) = y\_0${"altText":"y\_0^{approx}(t\_0) = y\_0"} and $M${"altText":"M"} is a constant that can depend on $\\phi${"altText":"phi"} as well as $t\_{n}${"altText":"t\_{n}"} and $t\_0${"altText":"t\_0"}. 
%[text] **Solution:** 
%[text] Show your calculations here. You can test your result with the following code using $k =${"altText":"k ="} `kGlobal`.
% %% Solution
%[text]{"align":"center"} $\\text{global error} \\leq n\\left(\\text{max local error}\\right)${"altText":"global error \<= n(max local error)"} 
%[text]{"align":"center"} $\\leq \\frac{t\_n-t\_0}{h}\\left(\\max\_{t\_0\<t\<t\_n} \\left(\\frac{|\\phi''(t)|}{2}\\right)h^2\\right)${"altText":"\<= (t\_n-t\_0)\/(h)(max\_{t\_0\<t\<t\_n} ((| phi ''(t)|)\/(2))h^2)"}
%[text]{"align":"center"} $= Mh${"altText":"= Mh"} 
% %% End Solution
%[text] 
kGlobal = 1;
CheckError(kGlobal,"forwardEuler","global")
%%
%[text] %[text:anchor:H_5308] #### **Roundoff error: a property of the implementation** 
%[text] Implementation of a method in computer hardware and software contributes to roundoff error.  Roundoff error accumulates whenever the exact value of a number and the value that the computer can store differ. 
%[text] ![](text:image:7ff7)**Exercise 4:**
%[text] To observe roundoff error, create a table of errors using your implementation of the Euler method to solve
%[text]{"align":"center"} $\\frac{dy}{dt} = t\\sin(y)${"altText":"(dy)\/(dt) = tsin(y)"}    with $y(0)=1${"altText":"y(0)=1"},
%[text] for $y(1)${"altText":"y(1)"}. How small can $h${"altText":"h"} be before the roundoff error overwhelms the error computation?
%[text] The symbolic analytic solution `ySol` is computed by the following code:
syms y(t)
ode = diff(y,t)==t*sin(y);
cond = y(0)==1;
ySol(t) = dsolve(ode,cond) %[output:89a30e6c]
%[text] Hint 1: You may want to review the error calculation presented in the [Numerical Integration script](file:./NumericalIntegrationSoln.m). 
%[text] **Solution:**
% %% Write your solution here %[text:anchor:M_58EEC37F]
% %% Solution
% Set up the parameters of the problem
t0 = 0;
y0 = 1;
tEnd = 1;
f = @(t,y) t*sin(y);

% Use the symbolic engine to calculate the integral
syms y(t)
ode = diff(y,t) == t*sin(y);
cond = y(0)==1;
ySol(t) = dsolve(ode,cond) %[output:14af296e]
yCorrect = double(ySol(tEnd));
%[text] 
% Set up a vector of the number of steps to use %[text:anchor:M_4622]
n = 10.^(1:8);
% Define a decreasing column vector of values for h
h = ((tEnd-t0)./n)';
%[text] 
yEst = nan(size(h));
for k = 1:length(n) %[output:group:1fe2ff05] %[output:691451ec]
    [~,yVals] = eulerMethodDESoln(f,[t0 y0],n(k),h(k));
    yEst(k) = yVals(end);
end %[output:group:1fe2ff05]
yErr = yCorrect-yEst %[output:1aa9d86f]

ratio = [nan; yErr(2:end)./yErr(1:end-1)] %[output:68dd1868]
estOrd = -log10(ratio)
vals = [h yErr ratio estOrd]
format long
T = array2table(vals,"VariableNames",... %[output:group:4d0ee177] %[output:2ccb8d90]
    ["h", "Error at tEnd="+tEnd, "Ratio", "Estimated Order"]) %[output:group:4d0ee177] %[output:2ccb8d90]
%[text] The order is estimated to be just about 1, which matches the theory, but the errors inherent in numerical computation are also visible. The error values begin to be impacted at `h = 1e-8.` Try [extending the computation](internal:M_4622) to 
%[text] ```matlabCodeExample
%[text] n = 10.^(1:9);
%[text] ```
%[text] You should observe that the results are completely off the rails by `h = 1e-9.`
format short

% %% End of Solution
%%
%[text] %[text:anchor:H_3c84] ### Euler's backward difference method
%[text] ![](text:image:8f66)**Exercise 5:** 
%[text] What changes are necessary to implement an Euler backward difference method using the relation
%[text]{"align":"center"} $y\_n = y\_{n-1} + hf(y\_n,t\_n)${"altText":"y\_n = y\_{n-1} + hf(y\_n,t\_n)"}?
%[text] a) If $\\frac{dy}{dt} = f(y,t)${"altText":"(dy)\/(dt) = f(y,t)"} is linear?
%[text] b) If $\\frac{dy}{dt} = f(y,t)${"altText":"(dy)\/(dt) = f(y,t)"} is nonlinear?
%[text] ![](text:image:00e9) **Reflect**. 
%[text] 1. What are the main challenges for the Euler backward difference method?
%[text] 2. Considering the error of this method, would you ever want to use it for a real problem? \
%%
%[text] %[text:anchor:H_2b52] ### Improving on the Euler forward difference method
%[text] Consider the solution $y= \\phi(t)${"altText":"y= phi (t)"} to an initial value problem $\\frac{dy}{dt} = f(y,t)${"altText":"(dy)\/(dt) = f(y,t)"} with $y(t\_0)=y\_0${"altText":"y(t\_0)=y\_0"}. Expressing relationships through integration, we have:
%[text]{"align":"center"} $\\phi(t\_n+h) = \\phi(t\_n)+\\int\_{t\_n}^{t\_n+h}f(\\phi(t),t)\\; dt.${"altText":"phi (t\_n+h) = phi (t\_n)+int\_{t\_n}^{t\_n+h}f( phi (t),t) dt."}
%[text] This formulation shows that the Euler forward difference method uses a left-endpoint approximation to the integral. The Euler backward difference method uses a right-endpoint approximation to the integral. We know other simple integral approximations, though. 
%[text] ![](text:image:0d6c)**Exercise 6:**
%[text] Design an explicit numerical method that uses the trapezoidal rule to approximate the integral. Check the error of your method. 
open("improvedEulerSoln.m")
%%
%[text] %[text:anchor:H_0f85] ## Runge-Kutta Method
%[text] While the forward Euler method is used for its simplicity and ease of implementation, the most common workhorse of numerical methods for solving differential equations is the four-step Runge-Kutta method:
%[text]{"align":"center"} $y\_{n+1} = y\_n + h\\left(\\frac{k\_{n1} + 2k\_{n2}+2k\_{n3}+k\_{n4}}{6}\\right)${"altText":"y\_{n+1} = y\_n + h((k\_{n1} + 2k\_{n2}+2k\_{n3}+k\_{n4})\/(6))"}     where                                                      
%[text]{"align":"center"} $k\_{n1} = f(t\_n,y\_n)${"altText":"k\_{n1} = f(t\_n,y\_n)"}                      is the slope at the left endpoint                                 
%[text]{"align":"center"} $k\_{n2} = f\\left(t\_n+\\frac{h}{2},y\_n+\\frac{h}{2}k\_{n1}\\right)${"altText":"k\_{n2} = f(t\_n+(h)\/(2),y\_n+(h)\/(2)k\_{n1})"}  is the estimated slope at the midpoint                      
%[text]{"align":"center"} $k\_{n3} = f\\left(t\_n+\\frac{h}{2},y\_n + \\frac{h}{2}k\_{n2}\\right)${"altText":"k\_{n3} = f(t\_n+(h)\/(2),y\_n + (h)\/(2)k\_{n2})"}  is an improved estimate of the slope at the midpoint
%[text]{"align":"center"} $k\_{n4} = f(t\_n+h,y\_n+hk\_{n3})${"altText":"k\_{n4} = f(t\_n+h,y\_n+hk\_{n3})"}     is an estimate of the slope at the right endpoint       
%[text]{"align":"center"}                                            (using the best midpoint slope calculation)
%[text] ![](text:image:66f3)**Exercise 7:** 
%[text] Implement the four-step Runge-Kutta method.
edit("rk4Soln.m")
%%
%[text] To test your implementation, uncomment this section to compare your output to the built-in Runge-Kutta solver `ode45`.
% Set parameters and input values
f = @(t,y) (y^2+2*t*y)/(3+t^2);
tspan = [0 2];
y0 = 0.5;
n = 40;

% Run and compare the output
[tOut,yOut] = rk4Soln(f,tspan,y0,n);
[tTest,yTest] = ode45(f,tspan,y0);
plot(tOut,yOut,tTest,yTest)
title("Comparing rk4 and ode45 output")
legend(["rk4" "ode45"],"Location","best")
xlabel("t")
ylabel("y")
error = yOut(end)-yTest(end)
%[text] ![](text:image:129c) **Reflect**. 
%[text] 1. Do you know another name for this method when applied to approximate integrals, $\\displaystyle y = \\int\_{a}^{b}f(t)\\; dt${"altText":"y = int\_{a}^{b}f(t) dt"}? \
%%
%[text] %[text:anchor:H_3ea2] ## Rapidly varying results can require special methods
%[text] When a solution varies quickly, this may not be tracked very well by fixed step size numerical methods without using an impractically small step size. One type of problem where this is evident has solutions that vary slowly in some regions but quickly nearby. They are called stiff equations. 
%[text] %[text:anchor:H_9007] ### Example: Modeling a flame
%[text] Consider the example of combustion. If you light a candle, the flame grows rapidly from nothing to a critical size governed by the point at which the amount of oxygen available on the surface equals the amount of oxygen consumed by combustion in the interior. A simple model of this interaction is: 
%[text]{"align":"center"} $\\frac{dy}{dt} = y^2-y^3${"altText":"(dy)\/(dt) = y^2-y^3"},                $y(0) = \\delta${"altText":"y(0) = delta"}
%[text] where $y${"altText":"y"} is a length parameter, so $y^2${"altText":"y^2"} measures surface area and $y^3${"altText":"y^3"} measures volume. The parameter $\\delta${"altText":"delta"} is very small, as it is modeling the length parameter of the initial spark. 
%[text] ![](text:image:9822) **Try**. 
%[text] 1. Run the example code below with different values for `numSteps`. How many steps do you have to take before the solution matches the values created by the variable-step solver `ode23s`?
%[text] 2. How much time does it take to run your `eulerMethodDE` solver for large numbers of steps (e.g., `1e6, 1e7, 1e8`)?  \
dydt = @(t,y) y.^2-y.^3;
y0 = 1e-6;
tfinal = 2/y0;
opts = odeset("RelTol",1e-4);
numSteps = 1e6; %[control:dropdown:7bd4]{"position":[12,15]}
tic
[myT,myY] = eulerMethodDESoln(dydt,[0 y0],numSteps,tfinal/numSteps);
toc
plot(myT,myY,'-o',"SeriesIndex",1,"LineWidth",2)

tic
[t,y] = ode23s(dydt,[0 tfinal],y0,opts);
toc
hold on
plot(t,y,'-o',"SeriesIndex",2)
hold off
title("Comparing Solutions")
legend(["Euler Method" "ode23s"],"Location","best")
%[text] ![](text:image:6062) **Reflect**.
%[text] 1. How much time do you think it would take to run your solver with `numSteps = 1e9`?
%[text] 2. By comparing the plots, what do you think `ode23s` is doing differently that lets it compute the correct answer more quickly?
%[text] 3. Can you convince yourself that the solution plotted by `ode23s` is correct? Why or why not? \
%%
%[text] %[text:anchor:H_5d80] ## Solving Systems of Differential Equations
%[text] You may have noticed that all of our numerical methods for solving differential equations are built for first-order differential equations. Higher-order differential equations are generally expressed as a system of first-order differential equations and then solved.
%[text] Consider a standard second-order equation, 
%[text]{"align":"center"}  $F = ma${"altText":"F = ma"},                          $(\\star)${"altText":"(\*)"}
%[text] which would generally be expressed as $F = m\\frac{d^2x}{dt^2}${"altText":"F = m(d^2x)\/(dt^2)"} or even $\\frac{d^2x}{dt^2} = \\frac{F}{m}${"altText":"(d^2x)\/(dt^2) = (F)\/(m)"}. If the force is $F = \\frac{1}{2}\\rho C\_D A v^2 - mg${"altText":"F = (1)\/(2) rho C\_D A v^2 - mg"},         
%[text] where $\\frac{1}{2}\\rho C\_D A v^2${"altText":"(1)\/(2) rho C\_D A v^2"} is the high-velocity drag force of an object of cross-sectional area $A${"altText":"A"} moving at velocity $v${"altText":"v"} through a liquid of density $\\rho${"altText":"rho"} with drag coefficient $C\_D${"altText":"C\_D"} and $g${"altText":"g"} is the acceleration due to gravity we can simplify equation $(\\star)${"altText":"(\*)"} to:
%[text]{"align":"center"} $\\frac{d^2x}{dt^2} = \\frac{\\beta}{m}\\left(\\frac{dx}{dt}\\right)^2-g,${"altText":"(d^2x)\/(dt^2) = (beta)\/(m)((dx)\/(dt))^2-g,"}
%[text] where $\\beta = \\frac{1}{2}\\rho C\_D A${"altText":"beta = (1)\/(2) rho C\_D A"} and $v = \\frac{dx}{dt}${"altText":"v = (dx)\/(dt)"}. 
%[text] As this equation is nonlinear, it may be convenient to consider a numerical solution method. This can be written as a pair of first-order differential equations:
%[text]{"align":"center"} $\\frac{dx}{dt} = v${"altText":"(dx)\/(dt) = v"} 
%[text]{"align":"center"} $\\frac{dv}{dt} = -\\frac{\\beta}{m}v^2+g${"altText":"(dv)\/(dt) = -(beta)\/(m)v^2+g"},
%[text] by taking advantage of the relationship that $\\frac{d}{dt}\\left(\\frac{dx}{dt}\\right) = \\frac{d^2x}{dt^2}${"altText":"(d)\/(dt)((dx)\/(dt)) = (d^2x)\/(dt^2)"}. 
%[text] %[text:anchor:M_1302E0CB] Step 1: Create a function [`MotionDE`](internal:M_6dd7) that expresses the system of differential equations.
function dxdt = MotionDE(t,y,beta,m,g) %[text:anchor:M_6dd7]
% MotionDE takes two variables, t and y, and three parameters, beta, m
% and g. It returns a vector dxdt consisting of the velocity and
% acceleration at time t.

% For ease of reference, name the components of y
x = y(1);   % The dependent variable for the first DE
v = y(2);   % The dependent variable for the second DE

% Express the system of differential equations in terms of the parameters,
% independent variable, and dependent variables
dxdt = [v;...
    beta/m*v^2-g];
end
%[text] Step 2: Use [`ode45`](https://www.mathworks.com/help/matlab/ref/ode45.html) to solve the differential equation and plot the results.
m = 68;     % kg for a human
rho = 1.2;  % kg/m^3 for air
C = 1.05;   % estimated drag coefficient
A = 0.59;   % m^2 estimated cross-sectional area
g = 9.81;   % m/s^2
y0 = 1800;  % m initial height
v0 = 0;     % m/s initial velocity
beta = 0.5*rho*C*A;
tspan = [0 40];
[t,y] = ode45(@(t,y) MotionDE(t,y,beta,m,g),tspan,[y0;v0]);
plot(t,y(:,1),"-","SeriesIndex",1)
xlabel("Time from jump (s)")
ylabel("Elevation (m)")
title("Modeling a Skydive")
plot(t,-y(:,2),"-","SeriesIndex",2)
hold on
%[text] Calculate the theoretical terminal velocity and plot it together with the velocity curve for your skydiver. Do they agree? 
% Theoretical terminal velocity
tVelTheory = sqrt(2*m*g/(rho*C*A));
plot(t,tVelTheory*ones(size(t)),"--","SeriesIndex",3)
hold off
title("Modeling a Skydive")
xlabel("Time from jump (s)")
ylabel("Downward velocity (m/s)")
u = symunit;
terminalVelocity = y(end,2)*u.m/u.sec;
terminalVelocity = unitConvert(unitConvert(terminalVelocity,u.km),u.h);
[tVel,velUnits] = separateUnits(terminalVelocity);
format short
tVel = -round(double(tVel),2);
subtitle("Terminal velocity: "+tVel+" km/hr")
%[text] ![](text:image:1282) **Reflect**.
%[text] 1. What other scenarios could this equation model?  
%[text] 2. How much do the results depend on the parameters we chose? 
%[text] 3. How would you model a skydiver who opened a parachute after 30 seconds? \
% %% Modeling a skydive with a parachute

function dxdt = WithParachute(t,y)
% WithParachute takes two variables, t and y, and it returns a
% vector dxdt consisting of the velocity and acceleration at
% time t
m = 68;     % kg for a human
rho = 1.2;  % kg/m^3 for air
C = 1.05;   % estimated drag coefficient
Adiver = 0.59;   % m^2 estimated cross-sectional area
Apara = 12;  % m^2 estimated cross-sectional area
g = 9.81;   % m/s^2
betaDiver = 0.5*rho*C*Adiver;
betaPara = 0.5*rho*C*Apara;

% For ease of reference, name the components of y
x = y(1);   % The dependent variable for the first DE
v = y(2);   % The dependent variable for the second DE

% Express the system of differential equations in terms of the parameters,
% independent variable, and dependent variables. It is not dxdt = y.
if t < 30
    dxdt = [v;...
        betaDiver/m*v^2-g];
else
    dxdt = [v;...
        betaPara/m*v^2-g];
end
end

tspan = [0 40];
[t,y] = ode45(@WithParachute,tspan,[y0 v0]);
plot(t,y(:,1),"-","SeriesIndex",1)
xlabel("Time from jump (s)")
ylabel("Elevation (m)")
title("Modeling a Skydive")
plot(t,-y(:,2),"-","SeriesIndex",1)
hold on
% Theoretical terminal velocity with parachute
Apara = 12;
tVelTheoryPara = sqrt(2*m*g/(rho*C*Apara));
plot(t,tVelTheory*ones(size(t)),"--","SeriesIndex",2)
plot(t,tVelTheoryPara*ones(size(t)),"-.","SeriesIndex",3)
hold off
title("Modeling a Skydive with a Parachute")
xlabel("Time from jump (s)")
ylabel("Downward velocity (m/s)")
u = symunit;
terminalVelocityWithParachute = y(end,2)*u.m/u.sec;
terminalVelocityWithParachute = unitConvert(unitConvert(terminalVelocityWithParachute,u.km),u.h);
[tVelPara,velUnits] = separateUnits(terminalVelocityWithParachute);
format short
tVelPara = -round(double(tVelPara),2);
subtitle("Terminal velocity with parachute:"+tVelPara+"km/hr")
%%
%[text] %[text:anchor:H_6c45] ## Further Explorations
%[text] Work through the pendulum example to explore how numerically approximating solutions to differential equations can facilitate the use of more realistic models of a system. 
edit("PendulumModelsSoln.m")
%%
%[text] %[text:anchor:H_C3981F6B] [⇦ Main Menu](file:../../MainMenu.m)
%%
%[text] %[text:anchor:H_7e71] ## Test Functions
function out = TestEulerDECode(EulerMethodDE,f,init,n,h) 
[tOut,yOut] = ode45(f,[init(1) init(1)+n*h],init(2));
[xVals,yVals] = EulerMethodDE(f,init,n,h);
plot(xVals,yVals);
hold on
plot(tOut,yOut)
hold off
fStr = func2str(f);
idx = regexp(fStr,'[)]')+1;
title("Testing Euler Method on $\frac{dy}{dt} = "+fStr(idx(1):end)+"$","Interpreter","latex")
subtitle("$(t_0,y_0) = ("+init(1)+","+init(2)+")$ with $h="+h +"$","Interpreter","latex")
out = double(yOut(end)-yVals(end));
end

function CheckError(k,method,type)
if type == "local"
    shift = 0;
elseif type == "global"
    shift = -1;
end
switch method
    case "forwardEuler"
        val = 2;
    case "backwardEuler"
        val = 2;
    case "heun"
        val = 3;
    case "rk"
        val = 5;
end
if k == 0
    disp("The default answer is not correct. Please enter the value you computed.")
elseif k == val+shift
    disp("Your solution is correct.")
else
    disp("Your solution is incorrect. Please try again.")
end
end
%#ok<*INUSD>
%#ok<*INUSL>
%#ok<*ASGLU>
%%
%[text] ## Help us Improve
%[text] [Share your feedback](<matlab: ShareFeedback>) to help us improve this module.

%[appendix]{"version":"1.0"}
%---
%[metadata:view]
%   data: {"layout":"inline","rightPanelPercent":40}
%---
%[text:image:40a6]
%   data: {"align":"middle","height":24,"src":"data:image\/png;base64,iVBORw0KGgoAAAANSUhEUgAAABgAAAAYCAYAAADgdz34AAAAjElEQVR42mP4\/\/8\/AwgnJiYapKamfgfS\/ynBUDMMYOYywBggiYcPH\/6nFIDMAJmFYQHIdmoBqFm4LZjrYPd\/gpoyGIPYVLeA5j6gmwUlJaVAxUlgDGKPBhFODaQG1QgIoqKtr\/6r99wlCYP0EG0BSMOWe\/9JwiA9oxaMWkBHC2ieD2iSk+lR6dOk2QIAjF+EgB\/BqfoAAAAASUVORK5CYII=","width":24}
%---
%[text:image:643c]
%   data: {"align":"baseline","height":24,"src":"data:image\/png;base64,iVBORw0KGgoAAAANSUhEUgAAACgAAAAsCAYAAAAXb\/p7AAADlklEQVR42u1YS0hUYRQejR4UvR+SvaCyWiS2DIoCKWjVYzG2SsYWQ+a8HRwXFkOgqdGLSoSeqyBaJUGLCKGkNpGtgiyScnpYBpaU5au+E+eH03Wu93rvP2OEFw46955z\/u8\/7\/\/3eDQ+4XD4Eui65199AK4d1DEJcBLgfw0wGo2ujkQi1yoqKlY5AFgDqnWw5lpaMxaLrbBkDgaDm7HIEKjTCcjxPqFQqABrdYEGsHaRXaESCAyCXpNFMwwuReDw\/77xusurQGJna0ysPR2K94CnGdQKesnUyu92J5PJaelk4c51Chzcu9dp0O9nkO3yvd\/vnwqlEbzvAf2yoB5sIkwyBt0doJ+0Qbdu2AXyC8UrOVuNQH5Q3IJegfrTfH8ikwC\/A9hjsdaYCQQCG6D4vVj0DShB7+HKXMGaQ\/EFADEGrPhJdn1GAhoZvRDKX4jFTvt8vhlWchSD4D0OGiE5AH9eXl4+PxNF+IoCB8sccyBfreQB8qJWcAC0CYqHeYE2cqEDNTmQvcc6hlC+CnXWq\/PCtTtdeGGr0HNWFz7aeTcr\/eT1eqe41PVWJYxd62zkovwXqQ6Cv8vErm9r8MZNEctLVf9Ph4GwecSOjPSQu8V28e6chmRrFPq28btHJhhSBKDIBH0B726HEDilAWCtsGCx6MmjMNgaHqBkiygPl3UmHE1OrjOEiqoqsqDHGizYxrqGAXCOriL9jJUOoq3lO9UDQItpQGD3PtXZRapFHB51oSchwiWsDWA8Hl8Cpb2svA+WWO4AXJ7Q0Z1IJObq7sUBN\/UQLr0hrHfANSCaQihrobiBf+dC+QOxSNk4MrdEyN1VvRy6T+DdVbOp2wpcCyutN8yDahjtVZ3A4sS2ALwflYxhaK1n0C22QfL8dkuNRYZBlKxxRLj6gg3XNgj+w8beLOriHcv50gocJ8wsfP\/ASgfMDlRs8XzwfGPeThMr2QcpEqFprJmPSoSwSvMYfCcFX6nFlNPEfAGrUuC1GkhxQpspTnTfKysrFxl5qqqqZouy0mU81ZmApB6cp2vKlrFVk+Z7TGRuPOsXRZSNfGYmEO\/ofoXmOiKKS3Ga6wPYeRNxk9Vo49BONAIL1mUdIBa9bxPgn+zMOkAqIXDdQbp1sKAy6uWeyWd0Cyuk5LDh3pTtez\/NSVJqNwbh5kNZB8htkTrP1zHA9dM1nZ07nExmc50ZQGA7M+GxyLden9MA\/OLm\/KKe34xPoKAD7jPkAAAAAElFTkSuQmCC","width":22}
%---
%[text:image:0a3c]
%   data: {"align":"baseline","height":23,"src":"data:image\/png;base64,iVBORw0KGgoAAAANSUhEUgAAADoAAAA6CAYAAADhu0ooAAAEp0lEQVR42t2a208TQRTG67OJxvv9fiGoD6LGgPiCGo1G\/wljTKDl1pL00RuKIKCIIiKg6ItB8IJ38K4Panz13RcfSBBBQQHRek4ys\/kYpu1uu2132+Sku6eb6X7zmzlz5ux6PEn6lJaWbi0uLu4mGyLrJWvMz8+f4UmnjxA5QhZS7HNZWdnUdNE5hQR9EsLGioqKWuj7kRRbUlJSmS40D4Co4yD+rfAPEdW5rhdKQj4KQQM4J0n0DhjCVW4XuR9oHlV\/J98rSZVsnmuF0nz8oNIsLCxcFQwGp4vf86AjzrhV5D4dTTq+Tr8d0VD95fP5Frpx2L4XAgYlTQpMq+n8DxKm4+0wV6tdJZIo7YWbPwbi26QfqdL5S+H\/7SqqdMPvJE2iOFPOTUEzpM5bpEodUOMWkXs06yb7r6qZEc5dOn\/hKqqQCESiOYkqic4Ff62jRZKg3XCzJ0B8q0akjupzSZU6aZGTl5Q34kZ\/BgKB2ezzer3LOMcNJ5SpSvJIlY7POTWn3QUBpRzEt0QQqYvMzxxNlW7staRJQ3gO0Bw1IdSYz9Qx28Bf57QhuxNu7iSIbzYhclKEpvZ6HElVR5OOl5qkGZEqdcB5p9DMC0OzyYJIXaTuFr4R6rzFTkj3jK1WHDRDarSmdnPAX59qkbkQaU+B\/7IqglM7+g4qVqu5rhzaeeoIqpC2RaVJN52pGfYbdFRlW0iVrr2QcppkFSC+MUxUNSt0AlU6f5JSqpCuGcUtv9+\/JExZ05JQpErf2eC\/mOxIi4v6aRDfEGGdtCJUjeCPhW+Uk5BkCu2xQjNGoQZVWl+30Pk\/4W9I1tzM0RWfeVhFyXysCp0QyaHoPUZtLU\/G3OxWadIfL+Dilt1CMZrTtZuB6qVE7zezdUVnDv0mctlYhKpUHyaFKoR6SzTjEYr\/pVBtTDhNLDZz0m1ydxKrUHWdfiCp+ny+FYmgKUP8sHx8YJamDUK1VDnVtHs5wSFTDeLrLOw34xGqrtf3E0IVgoBRiiwoKJhvlqZNQjEubIKOb7Jr3TQaxeIyF6+sbMFsEKqu2\/ZShQZVmsPJFhqOKrVzxTaaWFTW7SNNCD3IlUI08h2KYXOO63eXpErtrYwnCHWpNDniWqVpsxlUacnLAhDNsa6bWTqaolIQSrFVwei6FxdVGlZ3baY5SNav2KCdVLlYblXkRqB5FnqvOlYKNgWjUJjsTEIZpzbXWIm0d9QCMlfneI\/oFKFKhoZgWs0GIP7zv+qDHu7BeOZVAoSqWZqEM+73+9eaodlpN80ECjXiBwLih87Rnoith4vrgGZlvJEyQUJVqrdNUaULOmRp0U6a8uUMssNo\/BDYBqHDnKlppt21qDTxwQ7vGhywbkbrxBrN1Bsny9DRbFcLxV6vdxad\/3C6UJyryvRrU7OgdfBjPYivcIHIkCYX79BSpZObLqYZkSq\/kicjaqZ04oMcrpS7SGRIzeJIy60JVDk6SZpcbRdDeRr5v2hyU6fbV\/l8VVlXm5lcX0wJsTveYpMVw14PzMOGNBQqE4h+3M8x5hti3UwH64S52y6D0YALA49Z6+P3hCXiDLH2fEsjgd+ZKr9wyRr\/A+UKAPezYlA8AAAAAElFTkSuQmCC","width":23}
%---
%[text:image:80a4]
%   data: {"align":"baseline","height":20,"src":"data:image\/png;base64,iVBORw0KGgoAAAANSUhEUgAAADUAAAAxCAYAAAB6d+FmAAAC0ElEQVR42u2aO4gTURSGs6Lugo1WW2ghgiyCr1VWbRSR9YEgKoKohcQmEDAviYhBIaVbbKEWYi22YidoobUItoqwjSui6wt119Wsj+\/onXAcJslMZpI7AxP4Sbh37pnz3TP3zJ2TyWQS9imVStvRK1G5XL5ZqVRWZpL8MUCf0G+lz+hYIoGIyDYPIEc\/i8ViLmkRGkMfWwA5WkD7EwHEutmCs+87ADl6zfHLm4MLhcIqGs7RcV0WoA1xCa3vIkL\/CTsX\/w7G2Bka5oIMjlo4M6GBmOTRABHSeirh3S0LzSYQugHHgAPEJG+l7UOXtr6LgQeqYQZdRVf6Jc5frdfriyKIkOgHQToi1+0XpxGD+ywnhc348a5bICboqLMYmx02784hgRYAOqEzjHWoSIHiABU5kG2osECMP9lqC2IFiqS0qSdAtqAM0Ey3QOhUp81iX6F6DtRvKM6xsedA\/YQKCdQgyx0PcrKeQ4WNkE4K+LhGb6usQOHQOnnOCb31+WdrNW1TQC22BoW9Ddh9i6bRfNDdNkCH1c59LW0vpc8qFDYfo\/tkvMFqtbqM3xdkffgAmseXQ44dM3ba6bcGlc1mh9yzbaK3k\/Y37YAYc9Dl47A+xhoU0dlh7A579I3qRx6lbwAd8PAxHlA4V5BF3ea8Z11Ac62e52IDhb1bZuZL+lFdRWtQpflZzj3exlZsIvVc2b7jdW8xiWSWVL2ng4\/2ofL5\/Ars\/XJdXudN9wC\/R4Ce5PurFH58RN0+FLb2et130D1VVJlCu3zasw9FFC67dwboialUnZadQcBJsg+F09ewd9tkwLFcLrckZOTjkSgi3pmkUClUCpVCpVApVAqVQqVQ0UDp6s5IHKFMeaz5doufYuYz9bf\/XXmXQaqgcZH4I34pqBd+Qluz\/LpBUF3qCEUol3LgwyQAEbFHUrDxW6OTyk7NFEsaMYNpGL9qfoH+AOOEPfJuI6OmAAAAAElFTkSuQmCC","width":22}
%---
%[text:image:6c27]
%   data: {"align":"baseline","height":274,"src":"data:image\/png;base64,iVBORw0KGgoAAAANSUhEUgAAAwAAAAJACAIAAAC1zJYBAABbVElEQVR42u29D2wUV56oGwkhhFA2QhqhvFyEeNxLkMmCZTkiiS9CJsnK4jmE8RISQhDXQgjF63EsHuFPAoMQ64vQeNgMYhmGWZTLMIQHJJ6EQb5cnoXXD5Jc\/uYfJHngdYIs4hAnk8hCnhDA6vu7Pkntoaq7urq6qvpU1ffJQqa73VV96nSd75zz+51zVwYAAAAgZdxFEQAAAAACBAAAAIAAAQBAPnp7e\/fv379169Y1a9ZQGgAIEABAKujp6dm5c+fIkSPnz59PaQAgQAAAaeHWrVsjRozYtm0bRQGAAAEApIXDhw\/fdddd586doygAECAAgLSwcuXK0aNHUw4ACBAAQMK5devW0aNHP\/74Y\/l9xowZegDQtWvX5KmhoSFKCQABAgBIDnv27Hn44Yfb2tp27NjR0tKiBwC9\/fbb69ev37RpU2VlpfX6K1eu3H333R0dHRQdCMeOHdu7d6+PP7xw4YLUNwoQAQIIvk8v8Nmj5Pvvv49dWYnr3Hffff39\/eq\/9fX1VgDQ0NDQ8uXL5Zc333xTHhwcHFSvkdZO\/nvt2jW+ZSB1o7q62nfNX7FiRWNjI8WIAMVY\/x8vnBMnTkR8nj\/88IP0cT\/99NMEXwu5DUljNmbMGOnESxMVUh99zpw5+qWcO3eul\/mRw4cP2+pAsHlGts8eWQUTVxg3bpx1XKlmMaowH3\/8sZz2jh07rEeamprks6jf29vb5arJL8uWLZs4caL1mkWLFk2ePNm0z9Lb23vkyJGjR49aMge2XsG3334b7Hu+\/fbb48eP\/+abb4p5E7kVMA6EAMWVDRs2yH3\/gQcekNuo3H06hpFuwciRI+Xxe+65R+5K6kG5n27dunXSpEny+L59+yI+zyVLlshxR48e3dPTk+B7nJTzrl277homJAHq7OyUa7pmzRopTHWVDx06lPevampq5PXyYmlK9+zZI1Xl0qVLwX52cfGdO3eqzx6ZAEmjIsfdsmWLOm68BGjhwoVyBfXue0VFxYIFC6yPpgpWlGjTpk3WayZMmFBfX2\/Op7hw4UJVVZWceV1d3ZQpU+QqyH+j72IJ1iCZachNTzRdZFfKKsCaL10OpcjF0NfXJxVMXIrGFAGKH0uXLpVbj\/O+\/7Of\/UzuRGL3tsevX79eVla2cePGME5m8eLFuVogOUnVRHV1dSX+oqjCDztK4+6771ZaKXLj\/sru7u7m5mZ5vbx42bJl4V1lYezYsVEKkIVywRgJkJiNnLP+DZX2Wz7C9u3b9ZcdOHBAHpQrqP579epV+a88aMinePfdd0V6Tp06pZ+wuhYRL2Uk5VaSrp0X1KylFEuAvY6GhoZHH300kLcSvZZGgUB7BCh+SH8xawRcLgFSd4riW8GsTJw4MVcLdObMmXnz5ukd2QQjPbNoBEhsUg4kPcve3l6XV65Zs+b9998PSoBcrrJV8aIXoFGjRsVLgM6dOycn\/PLLL1uPqFifDz\/8UImOpZtiGDYfkl67IQ43adIkdcI6ra2tqrcT5bjCzJkz5YhHjhwx8FpLt7OlpUXugUG9oYiUfOuD6kwODAyMHj16586dtKcIUMyYO3euyp71LkDt7e2LFi0K\/Ey+\/fbb2M1BxF2A5F81p+liltKxU0NEgQhQ3quMAHmkp6dHTnj\/\/v3WI83Nzffcc4\/qLViP19bWWpNimeEoabnihnyEQ4cOjRs3bv369dLA64\/LVVCDQHPmzIlMxUYMk5LMg8bGxmCrwdKlS3XPBgQoHuQaunQRIGnDRJsCPxM1BI0ARSxA0rOUY7ncDaVPrPp2gQhQ3quMAHlHmpytW7eq30+dOiVFN2\/evMzwlIQV2Sp9lbq6OvX7lStXxo4du2TJEkPOf+XKlWqkZ8OGDbanZs2aJY\/LRYnmTKRTJ4ebOXNmGm4vKixsxYoVAb6nGn0sSeQWAgT+sW6O3gUoM5xsEuxpiFSNHz++tC2QiKCtJ5oGAert7XVPvJI2VRVL8QLk5SojQN45c+ZMeXn5oUOHxGJbW1vffvtt6c\/s27dPnxf79NNPJ0yYsHv37l27dsmX3agAIGXDWQcga2tr1VMFvaEYnpeIfifr16+XY61Zs6bQP\/R9xBKiNksJdrJPDaE1NzfTpCJAScBdgCy+\/\/77zZs3y11YXin\/VldXO28H586dW7x48Zw5c+bPnz937lxpQbdt22YNy0sDLLdslf0hNDQ0NP6EpSPiW\/X19fIn8ufWJkdyaHmxelxul2rsWu7ychT5r\/yrzw7Yvqs7d+6UxkC9TNoGafakzXj00Uel\/ZCP4L2U3D++foZy5tYUvpyA\/vi7777rUYDcD\/fxxx\/L20pRzx8mM5zmqkoja9C6EqDMcGK8HC7rwEB\/f7\/1uLsAuZ+bl6vsFCBpIPNeTaGtrU0+QkVFhbxSruCqVavcF7mRRmvDhg3zhlm0aNGxY8eKEaC8R\/ddUT02PF1dXQMDA5ZiOiNFxOylJsgleOWVV6SVKjLtOVh27NghZ+UchJYqJJfj3nvvLejdli9f7t2Z+vr6rEo4efJklQ2g\/tve3h7GEbO6iNRAqQZSFUVhbevxyFdDnEyelcpjBXVZyP1B7h5Sfzo7O61vmbxe3kr+RFwk17dAbqdyzrnW\/nE\/aE9Pz6uvvpr1b+WSTZs2jaYTAUqLAMkXbNowVkylylbQO1JyK5FmT89dv3Dhwrhx46yRJ7k1q5uOS9MoX2b5qtuSw1W7ImeoHpfbujQwb775prqZqpkdZ49ETlVOWJorFfZ76dKlSZMmSdOuusVyM\/I+6p7349vO0LqrSqMln87q48o5exGgvIdTAvTwww\/LgyrAWW6OUizq3Zw5NZYAqeHrkSNHOgfAtmzZYg3GuAhQ3nPzcpX1inf06FEvV1NKWG730npZ6cFiMHJQeZNc42dSDnKJpcevpEH+3bRpk9zrfQiQx6P7q6iBIMWrR2bI73Im5t98RLtVWRU6TSMX1\/s+aJ9++qmqgUpiRA2tOuk9+LqgI9o8Q6rEwoULRceVpEpPTL68+mvkpqcqUmVlpbi1\/lR3d7fcQKS+qYDxU6dOSX\/D6mXJm8u1njBhQlZTmTVrlooVy4rLQQX5jsvhLOXSkc8iZUguGAKUCgGSiq56abYYanEIPX1DmgfnMllqAMZeD\/ItxCJf2qzjImPGjFEDGO+\/\/75+etKiO\/u7KrZA2lfrEenQWOMf0oH2uNaix4+vn6GzW6n6nV4EyPvh5JanBEiunfwufyjdaHlEXy7PJkDyGlFSeY0zj0OPQs0lQAUVRd6rrCqe3Ge9XE3xDxEXZwqbNGnSLDkXTVGthXOmw5qLKUiACj16QRU1EOSdrVRn+RrKZSp0kleu6UJf+JhOslCLk8n3Pe9y1VJ6ixcvtobQ5Jfx48dbUi5F7WUsR75o3gOAAjliZnh1Sn1\/ksxwHLGchnWBpAsh3Q\/9RqFXTrE0ZSFyAur7YhvBVVbX1tbmPLRU2lzR5e4Hld6C6illtRwV0aWvaAAIUGIFaOvWrVnTNI4cOSKPyx3QavCcKWM9PT0+BCjXxJA6VWfXVu4vNu2QNkkdRf8CS19K9f8Kavw8fnz9DJ13RjUI5EWACjqcGsyQxl79V7qYapYnlwBZNy\/bHfndd9\/V5TWXABV0bh4FyMvVlC5v1tqlOvfylLT3trZcrnLWgS4vJ2aj0KMX9NGCYv369bt27ZILsWrVKmkgfSwlfPXq1aampsbC8b2KjwilMkUva\/TdunVLzauKlMhllU+q8jOkMMXp5VpL9ybvm2zcuNF7AFAgR5RqJlVRV5ZLly6pKT\/r1lRRUaHGb+T7K09J5dHfwRqbkdNWlc2WvybfU3ncucSJHFoe1xMDddwPKjolD+ZaPWjPnj0erxogQLEXIHUXeOWVV2yPq9XYrCHWCRMmyH+lc6MPD8h31RmpUKQAOTVChbboj6smWW5SzhMuNPDW48cPSoAKOpwSoLwfRxcg1WYL+riFdCL1IIBcAlTQuXkUIC9Xs6qqSh7ZvXt3rsEP21i92icrVwJjoQJU6NEL+mgBIhdUKp4hC\/94obq6OmvL7YI0zNJyT548eceOHfPnz29ubhaFEufz+KmlRS80KLjII4rkyRFFmPTxEvm+q+kw5R\/Wat2bNm2yTZLKUaxncy1fpALenZVKrUMh9uY8K\/2gSgptU5BqCjvXKrhqLKqYgDYECOIhQJY0yFdirwM9fUMtvKaQhlnubnqOboAC5EUvVDer+BEg7x8\/EAEq9HBKgPJucKgLkNWiW\/dZKQ3bKF1WASr03DwKUN6yUh1Zl5wmNWGqd+vVO6v9QYsUIB9H91EN3Dl48OB\/LQIvAxXRIy2uuGPWiZu8iG6q7tbKlSu9j3WpBbX9rQDk74gZbdJZEHMShdqzZ0+uF6uVuvRpU\/3k1aCm7eTl\/dUomvNOK\/2iXBkPzoPapnHVTHeu6Dp1q\/e3sTwCBHESoDNnzqhv7\/r169uzoQfZyO8zZsy4S0O+\/M4wwwgEKDMc4icP6lNCav+pgvY0LujjFy9AhR5OCVDeT2ETILUHmZyqssPdu3fb2qGsAlTouQUlQNaQVS5vUO+jT1Gp11shDsUIkI+jBy5A\/\/iP\/\/hkEUibbdo955VXXpEi8rf6s1QzMfjKysrJkyePHz9+w4YNHmOq5Fagdh+L7IiWPKn6YJE1Lkf5im1u2kItX+RMXJU3l8dtIdV61XUXILkEKq7I2dXJFQCEACFAKRIgNY5a0JoifX19couXZnLixInKgWyhGLYWSO4mtjXyAxEg+f5Ln0nuWdKjUhtwqpS0vOMlxXz8IgWo0MP5EyC5wantTlX6unOX+KwCVOi55b3KHstKTSK4DLmrMRj9Rq+KJdea1wUJkI+jBy5ACUNKUqq9ba8ra80LF0TTy8vL5eJu27ZNpES+yz09PWIMUplF8vKGUauA61WrVnk\/1SKPqH\/j5K3k0Cq1ypacoVCR0bkCqlQAkNxUbY83NDTkcn3lMe5L+a9YscK5OqXKFXXZPkyN+MZuVSQECAoWIEHlFjmXcLXhfAeVPOz8qthaIGn+be1HIALU1NQk\/Rs5tFohV5pzfxviePz47mdYU1PjMQaooMP5E6DMT4GTcsm6u7udTUKuGKCCzi3vVfZ4Na1B\/qxtgzyrVnfUn1ULBORax6ggAfJx9JgKkDTJd\/nigQce8H4U6YdMmjTJmU9nC8J1ouYip0yZoiZrxCfUWI5cAqnAXsxGpYXqMTQnTpxwyZUr\/ohy\/3H2FlSAmi2kTI4lUjVy5Eg1tiR9SFuOlQoAsmmTnInyb1We\/f39tnBAqZxqxXD3MrFlTigrctkGW2p7SLH8CBAYJ0Cq8yFflazPWqku8mWTb6DtWbUltW2wNBoBkltGIDsqe\/z47meoGlEvAlTQ4XwLkBr6lksmdugspVwCVNC5BSVAmZ9CMrOGc77\/\/vtquF4PSlU58LkWuiw0CLrQo0cpQNLy7d+\/f+vWrcXkoltc94X3IdUzZ85UVFQ4w4flU3jZC0z+fHBwUP2+Z88ePej+3Llz7mn\/zi3A5K3kZMI74rvvvqtqmk0v1OrMtjogPiQPqkVNM8PplvqIY64AIDVUY9XznTt32kR84sSJ7isWKn+yfRdU\/8FleXrVfYpRuD0CBP4FaGBgQG1r4NxLVS1AbLUrzkkHtdCZbehFta\/d3d3qv9K1sg0qBBUDtHDhwuJ3PPD48a1hMGemhpqn9yhABR3OiwDJTTPrAm5lZWW5ogdyCVBB55b3Knu\/mteuXZMXyxta6yBbqHkN2wJUctHl1i9thnV05ziH92a70KNHKUA9PT3S7EnTaCt8Azf6kFOVyrNr1643f+LQoUMHDhzYt2\/f0mEKereXX35Zrq\/31586dUpKXjee9evXu8QjF39EFWknX3Bb0PSWLVsmTJhgm3ResGCBXjGqqqr0K6hyWp1CLz0KedwKcpfvsq0LKm\/rvtyrilLQvUq+Mkq2XNY5nDdvnr81IREgMAWp9HJLkruPyuMdO3asNFFXr17NmiLx4Ycfjhs3Tm4f+hfs0qVL8oiVPi1vIt8K28jtypUrZ8yYYXs3NcRqZVPL11iPDvn0009VhIr0Zqwvofxy4cIF1d5v3LhRvzvIaahWedWqVfrjarEK+ZO7f0I+o1oC35mZ746Xj6+QD2VrEeX2VzuMWiNAP0Prk8o9UX\/cy+GkQFTUpBpOt\/qpNuQQixcvVqHfVuatPkziHIqXu7CqEnLh5Exs90HvReFylX1cTelPy+WTZl4\/H3kTuaxZx2ZE0eQ8Kysr9eZHTkCN+aulIL0vZev96D4+WvFfZGmx9K6\/iNqYMWPM2QhMdYTUZ89FrlUGcrF161Z9KZ28yBdEnw8SD3afGyr+iPL1FL2wfTFVJKJzLl59SVVQ0Y4dO2wDOWrGLVcAkHo3ud0556blreQFttg72\/1Z76DKCah+kUsAkBo3sgk3IECxwcrsdSFrP3jRokXSDMh3VVpT6VuITOhz+XLTl3vu448\/Li9Q30ZpQeV74pwXk853XV2dtP0iBPIC64t9\/fp155l0dHRkfVzOIesHscYtRMXkbKWJ+tlPyPdWRWwUGgvp5eNbbNq0SZofOQ3pmUmvce7cuX19fWqtDusMs34ivQ1wP5xKCbHhjKJQzbCOPhcm10XuxfpAiC1XRS9qH0VR0FXOezUzwxMl8j6TJ0+WB+X18vukSZNcGk55vZyANFpr1qyRayHnXF9fb+294J7blfXd8h7d90crBjWlogcRq1XsPC50Hg2qqXYhgoASNVQmRi4VUiptQckQ\/pBaJ8ItkqHuh9XV1fLfrDoicixfxubmZrUZonPERYrIuZOg1EnRyuXLl0tnw2bnCrXI4a5du3KdodqmY8KECaJccp4zZ85UY9gucX4qucy5lDwgQMlHOpfSeZJ7rm04ITMcD2F9meUF8jLnlIHtOy8vc+mdFIN0faT5d6ZayD2is7NTDQP4uOe6fHzbUaRTJS+zhpqkfZLOn9ywClqDxOPhTKsJoV5luWWr43p8z2+++ebIMFbqslx3qQNy\/j42Myr06BEg7ZZtPkIa0UL3Fk0JUlelJkSshtITU\/dDZ1fQVrVy1Su5b+QatBaNk\/rsMqRdVVWVN75KCkQOrQbv1aSYyzYXra2t4pE+lhoHBAiiQG4K8hWVZiDXC9QwQN4lwgDMRDRaGlQViaXGWfVnKyoq3JOfIT3s27dvxIgRWTP29+7da9s3ULptWbd20Zk2bVpQg5cIEEDwqEHa7du3u7xGDIlGAuLInj17Hn744ba2Nmm9WlparAAg6cQvXLhQrf85c+ZM+T3XWtiQHoaGhqZMmeKc0lIhkraEBpVs77JA5YkTJ6S+GTW7igAB2CkrK3PZEFt9+VO+Hh3EEXGd++67z5pMUYvKGB4ABKWlo6NjzJgxtgk4te5iVVWVNRGsUvGtnZWzIuZt4MLiCBDAHVy9enXWrFnS9dm7d68ediMNQ1NTk9wOXAIDAcxE7XKvT1uoyqy\/Rh7Ju6ggpI2GhgbbgHd7e3t1dbWVjaiCJt3vimJI0rGMIHgcAQIIgBMnTkh7ICZUUVFRU1MzefLk+fPny1fdPTobwEwWLlw4cuRIvQWSir1gwQL9NeXl5fIyygp0pBP46KOP2tY9amtrk3vjnDlzKisr5T7Z09PjLt8TJ050fw0gQAAAobRhYj\/6gqVqsyc91k3M3j3tGVKL1BbpBPpbbqCvr08kiXlVBAgAoAScO3dO5Obll1+2HlE7IajEabUKpS0AyMDVE6C0ONdG90L\/MJQeAgQAUAJ6enpsm9I3Nzer3anOnDmjHm9sbLQCgN5\/\/333REgAQIAAAGLAlClTtm7dqn4\/deqUuI7az2HTpk1qmceFCxeqR4aGhpYsWeJjpUcAQIAAAMzizJkz5eXlhw4damlpaW1tffvtt8vKyvbt22fNi3V2dk6bNq2trW3ZsmXMfwEgQAAAAAAIEAAAAAACBAAAAIAAAQAAACBAAAAAAAgQAAAAAAIEAAAAgAABAAAAIEAQI44dO7Z37964f4oLFy60tLRQ4AkuNwBAgAAC480336yurv7+++8T8FlWrFjR2NhIgSey3Fy4NUzgb\/vDDz+wvQYAAgTJ5O233x4\/frzaWSkZPP744yaPZ7gX+MDAwNGjR48cOaL2PA+Q\/v7+jz\/+2MxyE89oa2uzNnX3iBjkfffdN2bMmBEjRtx1110nTpwI5GQuXbo0ZcqUe+65R72t2KrJtb2YCiNul+uvzp07x70RECBIMt9++600IYcPH3Z5zeDgYLw+VF9fnzSK4hnxKvDr168vXbp03LhxL7\/88s6dO0VHJk+e3NnZGchxjx07NmHChGXLlplZbkuWLBHVGD16dE9Pj\/e\/unXrlnwuKau7hglKgMSrOjo6Xn31VfW2csnMrOfFVxh5B\/mAFRUVjY2Ne\/fuPXDgwO7du+U9J06cuHDhQm6PgABBkmloaHj00UddXrB9+3a5Re7bty9en2vTpk1lZWUGTl7kKnA5VXlc\/KO7u9t6cPny5SNGjPDtQJcuXdq8ebO4xaRJk0aOHCnX0V2ASlhu0gYr2+jq6nI+u3jx4h9++MHlz8eOHRugAClEBOU9H3jgATNreCAVRgmQk0WLFoUxnwgIEIApSAMpt8usTY7FzJkz5YZ45MiReH20gYGB0aNHS7c4LgW+ZcsWKec1a9boD\/b394u43Hvvvf6ihUQI5A1FXqWNlA69FwEqVbmdOXNm3rx5ol9Zn504caK7AP3sZz8LXIBaW1vlPUVYzazhgVQYEaBRo0ap0hPkb2tra4MadARAgMBcGhsbJ02a5PIC6QWOGCaO3cGlS5dOmTIlFgUuvflx48ZJC+QMgpk7d648vmvXriIP7VGADCy3b7\/9Vs48egFSJd\/W1mZg3Q6qwogASdFlhmOwYjfTDQgQgE\/EacaMGbNixQqX17S3t8vNdObMmXH8gG+++WbgjWJIBX706FEVAeN8atu2bfLUnDlzIhMg08pNTcJGLEBiGKNGjTI2ACioCmMJEAACBCni8OHDeee21q9f7xxmj5HhjRgxorm52fwCV9MZVVVVzqfa2trkKWmMIxMgo8pN\/GP8+PHRC5AKAJo2bZqZdTuoCoMAAQIEaaSpqUlulM5Ygb6+vsafmDx5srympqZG\/be9vT3w05BbsAhWbW1tfX391atXbc\/29PS8+uqrvtfLKS8vN6cNy1XgwqJFi+SpefPmOZ9Sg3CCXJdoBKjQchNXaLyTQ4cOdXV12R68dOmSvFie0h9UudZSMnL1FyxYMHfuXCv7ure3d9++fVOmTFEfv6GhwforqTMuArR9+\/b58+dLjZJ\/9+\/fX4xhyEHlem3durWurk7eUMrw1KlTJtSloCqMLkCimFeuXHEXTQAECJLArFmz7rnnHufjn376qWpmli9fLrfRESNGWA1PGAnS0uZ1dHTIL5WVlWVlZbZnpRmWc\/AdlSktlpy\/IblguQo881PchhiA8ykpHNWeHT16NDIBKqjcpFbI26qQFPmrxYsXKwFSGdry4L333isvUAJ04MCBGTNmqE8kVqF0p7m5WZWAoCqD7lXeBUiKSMrwzTffVGfe0tIiD\/obylLnIxpUXV3d1tam3lA+hXzA999\/v+R1KagKowToww8\/fPzxx+Xd5JKJ+0pFvXDhAndIQIAgsYwaNco9UEDdSUMNANq7d6+0Mep3Ndqkd0AHBgZUZopvg1m5cqW8g5de+8cff7zQF97nB10KvKqqSs4z68orIn+qPXNfqylYAfJebhZq5sWWNL5v3z55UJpV\/UG5mmPGjHGOzYgd6gL07\/fQYbxMgYku63YiB5LKI8pS6CKfVgCQGHl\/f7\/1+JEjR5wfpyQ1KqgKo7LApFrqoU61tbWjR492Tw4FQIAgrkhzkqsHabFx48awA4AqKirUlNCVK1fkWLZwBNWmui9T5M6ePXs8tgRXr15tampqLJxt27YVX+Cq\/c7anp04cUK1Z0WuR1yQAHkvN10alMHoi03LxZVHxo8fbyuK8vJy5zvcd999RQqQM2W9srJSHi906lYFAIk82RbOVgI0f\/58L28Sao0KqsLIBXr88cdtOZ69vb3y5+PGjZMeCLdKQIAgaajU4sWLF7u8RszDJUpabo5ys5YWXVod6UEeO3as0HMQ6amvr9dly5YhpaY\/5CnfB92\/f7+8g+9AkMgKfOLEibnaM2tGI0oB8lduas705Zdf1t\/n7rvvtoUn7927N+t6P8ULkLOIpJL4KLrNmzfLXzl3RlP5aB5HgEIl7AojhirvkGtZJgAECGKM6iYuWbIk1wukU6imD3KtADRz5kzp4FpdRnmxDweymDRpkpyPLfJA3YX1FrHQgx44cEDewYRN190LXLXTWceH5AOq9qzICPSCBMhfuanPqI\/3zJs3T0mDuJH1YE1NTdb9LooXIGcR1dbW+lCBXNo0f\/58eVwKp+TVKewKU1dXJ++QdaAOAAGCePPpp5+6C5C6jWbNsxV2794tz+pJW\/JWkydP9ncyWVOOBwcHbQFAPg5qjgC5F7iyk6xJPWraRSgy9jYCARImTJhgjfcMDAyoFlSU6O6771bXsb+\/P1elMkSArMgh2wSQ9ARGjx7tI6IoDIKqMPJtyvpx1PvLh+VWCQgQJA2lF4sWLcr1gg0bNsgLVq1alasDalssWE2a+EsSXrFihfytHFF\/UC3HpwcA+TioNOHygkOHDhle4C+\/\/HKubaeUixSfy1aQAPkuN\/VB1HjPrl27VIT7mjVrLAvZNkwxAiQNtnMD8wAFSI1jOQc\/nBWyhARSYZQqidU5y3PBggWq2LlVAgIECURukVl7kIpZs2bZAoCkYbDSj0eNGmX7W7X6yPbt232ciTqWbTJLWZEeAOTjoGpVXC9zAWppXR943yzTpcBV45o1303tSOV7dM2fAHkvNxsff\/yx\/OHYsWPlg1RXV1+5ckUelPbVmq95+OGH9bwqHwIkL3AOpAUoQCp53hkAJNdOHn\/11VfVf\/NukRFqjQqkwqiYrazBXirN3ha9DoAAQUKYOHFirsXunFuADQ4OVlRUqN9VQpMtAFMl3+qhHpnhyN9r167lPROVPWSb45CWUm8OvR9UR9p770sIXveF90Ua3Qtc7dbunLZQ7a5zMRuPZetPgAoqNxsqcksUSl9AQT64fED5dDU1Nbn+0BABUuE1Nr\/55ptv5OsgCq42zOrt7RVFKGGN8ldhbOq5d+\/eCRMmqMUes34lrXg7AAQIEoX0yHOtl3\/q1Cm5\/VnGkxneE2PPnj3WndQZzuIM8pU3kfeXZiNvNrVKadGjrbu7u+UP9Q6ux4M6G4Os+yWZVuBCfX29cx5QmkMVj2Lb89J72foToGLKTY1AyGnr+3GqYZUHHnjAqkXeBUjlkUmVsIZebKUUoACpACD5E1sA0KFDh3T\/lhMo+Sap\/iqMvjqiCLRcEWdw1ZkzZ+Sdx4wZI57HfRIQIEggO3bskNucc\/pfjffo8zVy09TnbqQpcmZ0KxfRY1zUHJaXsAm17J618Jrcl8vKymx\/6PGgzo6sx1VbSlvgwqVLl8Q5xo4dqwelKm\/QE8sLLdvM8FovYgYqz668vFzKOe8YQzHldvXqVSVA+tp6ap0neTDXoaXBlo+vho5s0zrqw77yyivqv+K7ehnKiy9cuKDWLdy4caPenEuRqn3EVq1a5XGHB1WjnAN1KlxGRS\/JZ5k1a1bJq1NBFUZ9xZw5\/Fu2bBEvt2V6+kudA0CAIDaoNknvpuvs3LlTmitpdeSOKbdIvd1SCzRnnY2y1vVRyjJx4kTp1js3uLAh3dbHH398woQJ0sDInXrmzJnyX1vv1uNBbW2qPCsfJBYFnhnOvJP2bMaMGdJfFwuUwpdLkHXVGY9lqyJFcuEcawmq3ETLnDNEVVVVWdetkavvfm5S9+rq6qSxl6IQLVu\/fr373zY2NqoJUxteRr9U9Ldz8U\/RrJqaGvkIYgxiP85N60qC9wojdW\/y5MnyFXPucSHWKLVI\/lYs+cCBA\/LtE2ssZkkLAAQIYoDc0F12w5CbpnR8bWPpqjEYMWKEtEn6gyoe2dn1zAzHOHs5GTnQ4cOHVUqXmhTT07sKPWhmeC7GNg5heIErz3v11VelqV6yZIn4X95M5jCGIoovN7mUztmTrA8WNOAh1SPX+FlQ3Lp1S+p8rvyprq4uqXKGbC3nr8JkRXx606ZN8g4NDQ3WTmoACBAkmX379olVFBRLq5g2bZotzUQl3zoTp1XX2b3PvWPHDlszkzUP2ftBrdd7DHkxv8Czkrds\/WFguQEAAgQQJNKCTpkyxRlSmpeVK1dKQ64yYhTNzc1Z14hra2vbunVrrvdRe07ZNpCaOXOmPOLced77QTPDwRzOUND4FnhW3MvWH2aWGwAgQAAB09HRMWbMmFxLs+RChYlYIzfSrk+YMCFrOnp1dbXLlopLly5V603blntubW0t5qCZ4Sx6EabEFHhW3MvWH8aWGwAgQAAB09DQ4JJIlYudO3fee++9J06c+Pbbb8VCRGKsZRItmpub9+3b5\/Im7e3t0opbGToiN6NGjXIJE\/ZyUGVRZWVl3lfoiUWBF1q2PjC83AAAAQIIklu3bj366KMuC7Tk4sqVK\/v373\/11Vez5hPJ29qCe7LS1tY2a9asOXPmVFZWNjU1Zd0m0\/tBM8OLEU+cODHv+8SxwAst24Iwv9wAAAECCJjBwcGampoi9xs3gb6+PhEp80NYTCvwuJQbACBA5nL79u2buaFCmIy12G586R+GAk92uQEAAmQiL7zwwv25oUIAAAAgQAlk9uzZCBAAAAAClCJu3rypRGf37t3vZIMKAQAAgAAljZMnT4r9lJWV3b59m2sPAACAAKWC\/fv3iwDV1tZy4QEAABCgtPDiiy+KAMm\/XHgAAAAEKC3U1dWJAL322munT59evXr1smXLnn\/++XXr1p0\/fz7v314FAABIHwhQ7BkaGiorKxMBqq6uduZ\/iQ+5BAZJDbgfAAAgfSTVgVIkQBcvXrQu5wsvvNDe3t7Z2fnaa6898cQT6kGXTRYRIAAAQIAQoFhy9OjRsmFsmzQNDQ1ZqyOePHkSAQIAAECAksaNGzecDw4ODpaXl8tlXrFiRV4BOn36NFPCIUEhU8gUMlDIppUwApRw1CDQrFmz8gpQgiPCSguFTCFTyEAhU8IIUNSsW7dOLnNFRQVfNr5vFDJQyBQyJYwAJYcbN2589NFHly9fzvrs6tWr7x9OEOPLxveNQgYKmUKmhBGg5LBkyRK5kM8991zWZ+fMmeMxBogvG983ChkoZAqZEkaAYsNvfvMbdS27u7ttT3V0dHjPAuPLFt73LfHrblHIFDJQyAgQAhQ1\/f39FRUVci1ramr6+vqsx0V6Kisr5fH6+np6GwAAAAhQ0jh+\/LhaDHrq1KkNDQ0vvvji008\/rS7wE0888d133yFAAAAACFACuXjx4rPPPqsv8TR9+vTNmzcPDg6mvCoAAAAgQIAAAQAArR4CRFVAgAAAgFYPAaIqAAAA0OohQFQFAAAAWj0EiKoAAABAq4cAURUAAABo9RAgqgIAAACtHgJEVQAAAKDVQ4CoCgAAALR6CBBVAQAAgFYPAaIqAACkjOod5+\/6v49PbHlHfqE0aPUQIKoCAEAqEPtRP+JAlAatHgJEVQAASD7\/7UyfJUDyQ4HQ6iFAVAUAgORT\/\/98ogvQv\/7bt5QJrR4CRFUAAEg4E1veQYBo9RAgqgIAQLrQ7Ud+Nv6PzygTWj0EiKoAAJBkbAFA8kMiGK0eAkRVAABIOLYAIBLBaPUQIKoCAEDysQUAIUC0eggQVQEAIPlY3qMPBX3+l+8pGVo9BIiqAACQTPQAIJEeEsFo9RAgqgIAQPKxRn3kl4w2GkQiGK0eAkRVAABILFYAkBIgtSOY9V+g1UOAqAoAAEnjX\/\/tW9uclzUgRCY8rR4CRFUAAEgmegCQemTj\/\/iMRDBaPQSIqgAAkGRsAUCZO8eEKB9aPQSIqgAAkMTm6ifX+W9n+tQjJILR6iFAVAUAgCRjS4B3sSKg1UOAqAoAAAlBX\/ZQf9xKBCMTnlYPAaIqAAAkDVsCvFOASASj1UOAqAoAAIlrq3JMdZEIRquHAFEVAACSSa4AoAyJYLR6CBBVAQAgqeQKAMqQCEarhwBRFQAAkkquACAEiFYPAaIqAAAkFvdcd0uPSASj1UOAqAoAAAnBJQBIQSIYrR4CRFUAAEgaeXc8JRGMVg8BoioAACQNlwAghTVEhADR6iFAVAUAgKS0Uvk2u9Az4bPOkQGtHgJEVQAAiBN6AFCu15AIRquHAFEVAAAShRUAlGv+68eW7CcBIhGMVg8BoioAAMS\/ifK22buVCObuSUCrhwBRFQAATCdvArxF3kwxoNVDgKgKAADxwMpvz7vPF5nwtHoIEFUBACAheJ\/YYktUWj0EiKoAAJCU9slbAFCGRDBaPQSIqgAAkAy8BwAVaktAq4cAURUAAAzFimv2OKtlzZeRCU+rhwBRFQAA4kreHTByCRCJYLR6CBBVAQAgto1TgVNaJILR6iFAVAUAgHhTaABQhkQwWj0EiKoAABB3Cg0AsgkQiWC0eggQVQEAIH4UGgCUIROeVg8BoioAAMS+ZfKV025pE4lgtHoIEFUBACBm6AFABf0hiWC0eggQVQEAIK5YAUCFbu1OIhitHgJEVQAAiCs+AoAQIFo9BIiqAAAQY4pJ5tL\/1mPyPCBAQFUAACg9vgOAMiSC0eohQFQFAICY4jsA6Mcm7ScBIhGMVg8BoioAAMSnTSpuU3crEcyfPwECBAgQAEDU+NgBw4Y1gEQmPK0eAkRVAACIBz52wLBBIhitHgJEVQAAiBm+E+At2BKVVg8BoioAAMStQSouAChDIhitHgJEVQAAiBfFBwAFZVGAAAECBAAQEcUHACmsRDAy4Wn1ECCqAgCA6RQfAGQTIBLBaPUQIKoCAIDxrVFAU1ckgtHqIUBUBQCAeBBUAFCGRDBaPQSIqgAAEBcCXMCwmO1UAQECBAgAIDqCCgDKkAlPq4cAURUAAGLTFAWau27pFIlgtHoIEFUBAMBQ9ACgQN6QRDBaPQTIE8ePH+\/o6BgaGkKAAACixwoACmoLdysRDAFCgBCgnBw4cEBd4Js3byJAAAAlaIeCXruZTHgECAHKw5UrV8rLyxEgAIBSEWACvIWeCBbUeyJACFByGBoaeuqpp6wLjAABAESPNVoT4LI9JIIhQAiQG9u2bZPrWlVVhQABAJQKK2A5qACgH9u2nwSIRDAECAG6gw8++EAu6iOPPPLGG28gQAAAJWuEwtm8nS1RESAEKAuDg4OPPfaYXNSOjo6uri4ECACgJIQRAKQIcGlpBAgBSg4vvfSSXFH5V373IUCnT5++qsH3BACgSE0JfN8uEsH8SY+FtHQIUNI4duyYXM7Zs2cPDg76EyAbOBAAgD8C3AHDBlui+rCftDVz6RKgr7\/++qGHHpLL+d5776lHECAAgJK1QOEEAGVIBEOAECAb9fX1ci1bW1utRxAgAICSEF4AUNh2hQAhQDFjz549ciGffPLJ27dvFyNAxAABAATQIw0tAEhBIlihAmQDAUoI3d3dfzuM\/KI\/ThYYAEBJCC8AyCZAJIL58yEEKCGsXLlSruLMmTOX34m1GPSyZcvkv7\/97W8RIACAKJqfkKeoSARDgBCg\/82KFSvu90BjYyMCBAAQNnoAUEiHIBGsSAH6mwUtI58\/JP\/u+\/8uIEAx5r333mvPRmtrq9KaP\/\/5z\/Lf8+fPI0AAAGFjBQCFNP9lEyASwXwIkNhPsqPI70r5NSYGCAAgeqwAoPAilMmEL1KAEp9GhwAhQAAAkaLPf4WqJhFoVhquURiLFCBACBAAQKob11APRCKYb\/RFCgiCRoAQIACAIBvX8AKAFFYiGALk+xr9zYIWBCjVIEAAAIE1PFEFl5AJ7xtr9vDeR\/8LAoQAIUAAAMUSZXCJngiW1ECWsCUVAUKAECAAgAAIewcMHRLBipfU\/7P8EQQIAUKAAACKJewdMOyN3E8NOYlg\/iSVlaARIAQIACBII4lmdRm2RC1GgP5mQQsChAAhQAAAxRL96jJWW04imHf0CGgECAFCgAAAAtORyPbnIhHMjxloEdAIEAKEAAEABDa0EE0AUIYtUQvHFgGNACFACBAAQGBDC5FtL0UiWKHYIqARIAQIAQIACGxoIcpVeRK\/qWdIAqQioBEgBAgBAgAIpmWNOB6ZRLCCsEVAI0AIEAIEABBMyxpZAJBNgEgE86QFd0ZAI0AIEAIEABBMyxrxVBSJYN5xRkAjQAgQAgQAEEzLGvGhSQTzIYtWBDQChAAhQAAA\/rECgCKe\/7IJEIlgHi\/T47\/uQIAAAQIAKLqxKV0qFpnw3rHitFrePIsAAQIEAFAUpUqAd7brJIJ59FQECBAgAIBi0SNLSnICJIIV6qlvf\/RvCBAgQAAAwfhH9AFANgNDgDx6ahpaPQQIAQIACLmlKfVazGTCe0EPVEeAAAECACiKkgcAZe5MBCvVOZiPHimFAAECBAAQzLhCCZfhIRHMkxBoA3UIECBAAADBjCuUKgDI1rqTCJYV20AdAgQIEABAYOMKJTwNtkR1x5aphwABAgQAENi4QgnPpFR70ccF21LdCBAgQAAAATSrJd+Hi0Qwd2xrRSJAgAABAATQrJY2ACjDlqh5beDOmUoECBAgAIDAmtUSQiKYC86ZSgQIECAAgACa1ZKfjC5AJbcx03DuVYIAAQIEAOATW1xtySERzPuVQoAAAQIA8Ilpe7CzJar3K4UAAQIEAOAHff7LkJgbEsFyqoBjchABAgQIAArj8798L+09G04ZFQCkIBEs75Wy6i0CBAgQABRmP8yzKEwLALIJEIlgFs4IaAQIECAA8Gk\/tLIGplyRCe9dVREgQIAAwKf9pDnWxJwdMGyYFpdtbJkgQIAAAYAndPuxWpTULjljzg4YuS4TiWD\/7gHZ6ioCBAgQABRmP\/K7PhqUzkEgc3bAsGHFuyBAilxjdQgQIEAAUJj9qAf1eFvTJKBUgwpGCRCZ8LYCsY3VIUCAAAFAwfZje0ra2lRlxRsbAGQTU5YqyORO1kOAAAECAE\/24xxR0HOOUjUIZGwAUIZEMAe5osIRIECAAMCP\/dhUQF6QnubW2ACgH5u9n64aiWCZ3JOVCBAgQADg035s4w3pibo1PAOOLVEtXCYrESBAgCBpyG1O\/VAUYduPQg8yTcMgkMkBQAprWI5EsFwR0AgQIECQ2JY7bWG5YTSfHie29EGgNGQeGbgDRq5Wn0Qwl4uFAAECBMlBz39Rd\/90rtEXpf0o9EGRxJe54QFAGbZEzXaxnLOBCBAgQJDAm53ehBMGEbb9ZO7cJSPxow7mqx6JYF4uFgIECBAksPHWfycU1CN6tISPhlMfdUhwgetjXcaepC5AaR4EdY\/WQoAAAYIkoLe+KvDT1pwTDeq9qfA9bJCGACzzA4Bs1yLN9u8SAY0AAQIECUHPWrIab2dIEGHR4dlPJh3rIsZlZIUtUfPaKgIECBAkqp9n6+9Kk6wHBuFA4dmPrclJ5LqI5ifAO78UaU4Ec4mARoAAAYLYkzcH2+lAhARZ2AbJileWZK+L6D6lYuaVTbMAuQ\/XIUCAAEG8yTr55WyVbSFBOFAY9qPQI9ATNghkVTbzJ\/j0i5vORLC8w3UIECBAkJAmPG+bhANFYD+ZRK+LGKPUKjLh8w7XIUCAAEGM0ee2Cr0npnl2IDz7cXa+E5OGHaMAINu3I52unzdfDwECBAhif4MrqAknLNpmP2EISiLXRdTrWyxOOOWJYHn9DwECBAhi34oXen93OlB65ggisB+FPl6SjBEI83fAsGGNd6ZTgPJWcgQIECCIJXrss48hHPkT27YPaZgmiMx+bNcoGcNssZvUS3MmvJf5SgQIECCIHy4L\/xTkQKkKi7bZTwQftqAQ9QQ0qCZf8bTN83rZsQQBAgQIYkawK83YHCip6xfrhRblx9QHgWI9zxi7AKBMuhPBvOxYggABAgQxw8vCP747i4kMiy6V\/WQStC5i7AKAfmz\/0rrog5cMOAQIECCIE7qsBNgUJTg1rIT2Y+uLx3ocIqZZ\/andEtXL9UKAAAGCWN7XAo\/rTOSOGbYPVZIxmASsi+gloMRMLPtMVSKYx4AtBAgQIIjf3TyksQRbWHTcHUhfjKe0TWDc10X0ElBiJulMBPMorAgQIEAQD4pZ+Me3A8V37sAc+8nEf13E+C6prH9rUthTchdWBAgQIIgHRS7846\/fHNPpA6Psx9kpj5dG6GceuximdCaCeYxYR4AAAYIYoBtJNHMottjheIVFm2Y\/trOKV2HGNwDIVo0Tsylb\/lbf20dGgAABgjjdxKNszmOaGmam\/WRiuy6iVZ4xXSMqbYlg3pesRIAAAYI4tegRD+Pb5pLMD4uOzH5uftXr4+e5bcf+wwsH5Oc\/bzz8\/777kb83CfBn8OI7eX9m\/MM\/q5\/\/frjd5WX+TiCQsnU\/GavM5Zcoy63IkvH9I\/VKfV75cX\/l5+\/9z5l\/+5\/kBwFCgBAgML0\/VxL5KDIsOlfLMdB50Pr55uCvnT9fbm+2\/fRu+Hvbz2fPz9B\/Op+Zpn4uzf8\/+OGHH48\/CBAChACBkV9gM5aQ0R1Iepb\/0n7a8hhdWXQ1oV3hhx8ECAFCgADiNPmlRmssuVFmc\/IX\/xeDK\/zwgwAhQAgQQLiEvfBPVsuJfuTGNo0lP86pLud0mD5Z9ouljeqnbvnGFWu36JNr+k9BcRtB\/eSN0viX9tPBRpwEG49S0HmGdM7FB9PI+XsJY4ogjifsctCr1uX\/\/3Leg86v+I\/ygwAhQAgQmIWegVV8+pW6DypjEKUISl9UzI1lLbqa2LQjb+hr8YNkcdlxXU+vM3ldRO\/5RHH5KiU+EaygNQvIAgMECEyk+IV\/xDOK1x1rSMYyG+U00pOWLmbJU8P0vUHiYj\/OhsrYVlkv3lh\/myxLTvyOYAVtWoIAJZbLly8fPXr0yJEjXV1dt2\/fpipAjPA3+WWN8RRqPJbl6IrjPk5jwo4Z8bUfW6ts7CCQxwWFY9SdSLwAFXTJEKAEcvHixSeffPJ+jcrKyt\/97ndUBYhd05g39rnQYR7lOmo4R4lOIO1K9K2Lbj8x3eXA\/HURE7OGcnq2RC3okiFASePs2bPTp0+Xy\/nQQw+9+OKL69ate\/bZZ9UFXrlyJQIE5uNlckR5j5eAZXmNMqQiXcdLKx7ZatF6EcV6jyd9EMi0T5GYACBbLY37ZwnwkiFAiWJoaOixxx6Ta1lXVzcwMGA9fuDAAXWNOzo6ECAwGX3XC2dvVc1w5TUeNZkVkvFkPecod8xIjP1kSrfJiRcKiiaJUTkneEvUQndtQ4ASxbFjx9S17OnpsT2lxoGampoQIIjFkIB1p1aDPV9ub\/YyzFPCBsbmQCGFBCXJfmyeYdrHSUwA0I8NofEh59E7KwKUKF5\/\/fWnn3765z\/\/ufOptWvXyjWuqalBgMBYbEEhA50HXbzHGukxp5Mddlh08uwnk2\/Mz4SzSsYm6mnYErVQZ0WA0sLzzz8v11j+9VIVTp8+fVWD0oMo71\/\/4YUDv1ja6D7YE9n0VqGE50C2YKMkTWToYmeIbRQ6mRKj0ZEEJ4J5qUV60yYtHQKUfKzL\/MYbb3gRIBs4EESjDuI9f3zu0Th6j4sDBTKqkWD7yRi5LmKSAoBs1TKpiWBeIqBT2MylV4DEe44fP75u3bqysjK5wGvXrnV5MQIEpUJF+bh4T6xb9OLDopNtP87Wy4Q5moTNf9lqUeIFiGYu7QI0NDSkvEfR2Nh448YNBAiMYvDiO7lS2eMy3uPdgfw1pTb7SUx77MScdRGTlACvV8hkO7SXQTsEKDVNy+BgU1PT2rVrRX2mTp0qF7iqqurs2bNeagYxQBA2N7\/qzao+MR3yydXk2BZrLnRsIz32kzFpXUR9EjMxxZu8sG4bXiKgrzpAgJLPF198UVNTI9f4wQcf7O\/vzytASA+Eqj7OVZs7n5n2i6WN\/3nj4YR92GJSw1JlPwpD1kW0TiMxAUC2z5XIRDAf3xQEKC309PSoy7xt2zYECExTn2Qv0WZzIC\/Nqs1+Er+Jt3OUooTykVTpTPCWqP5mLRGgFFFXVyeXuaGhAQECE9Tns+dnvLF5neG7QYVxg84bFq17QOJLxkbJ10VMZACQTcSTlwjmb9kCBChR9Pb2dnV1ffDBB1mfXb58uVxm+RcBgpKrjwr00cOE0zC84SU1LM32kzFgcwzdwBJWttawYvIEyN+yBQhQoli2bJlcyCVLlmR9dtasWS5boiJAEDjO5HY9xtnYPRCidCDb3FbK7cfZm4++YiRsB4ysApS8b5y\/q4YAJYodO3aoa9nd3W17qqOjQz311ltvIUAQNs4kL1t6l34vTvDStFkdSA8J0h3IZj+pKpZcmhj9WEWCo84TnAnv76ohQIniu+++e+ihh+Ra1tbWXrt2zXr85MmTDz74oDz+xBNPDA0NIUAQKs6BH2dmu77pacIiLQp1IBXjLA\/qZZJa+1GUanOMBAcA2UZKkhRW7\/uqIUBJQ1xn+vTpcjmnTp3a1NT04osvPvXUU+oCz549W7ciBAgCx7mwofz35le9tpfpzX9K8puc2ByIsZ9cihzlIFCCA4BspZqkOuZ74zYEKIFcvnz52Wef1de4FBlqaWkZGBhIeVWA8Mi6nUXWJQ1LHuVqDrY5L8pEpyTrIiY4AMim3UmqZr43bkOAAAGCYhm8+I5NfXo3\/L1z4MfWB01P7LO7A+lh0dhP1qoS2bqIiV92MpGZ8L61FQECBAj848xyd9\/LQh+sTmeKU1YHkqKQn9TOBrqUTJS1xfdMSozQx9USE+TkW1sRIECAwL\/92CJ+RIY83qqStxIJhEGUayX4nkmJqVMmY\/y1mLh1BAgQIPCDbdrLyyamKVz4BwJssMOeH0xkhpRLJyQZH7OYcTsECBAgKBhbvHPegZ9Mihf+gQBbuPC8ubSrL0ZJwrZELWbcDgECBAgKwxb0k3fgx3bbTeHCP1AM0ayLmIYAIJsxJKMfUkziHgIECBB4xRnyPHjRU4Okr3mT1PwaCI8I1kW0BD3xsfkJSwQrpmIgQIAAgSecQT8e7YeFf6BI9GWyQ2q20yPo+mR0kj6Lj3FlBAgQIMiPj6AfZ9+a2GcIpKkLfJAm8Ttg5OqQxP37WOTEJQIECBDkwTbt9eX2Zn93KBb+gWLQB4GC1ZTE74CRS4DiPtxV5MoFCBAgQFCA\/Qx0Hizs68fCPxBCyx2sTCd+B4xcKhn3RLAiLxwCBAgQeLIf70E\/zvssk18QbI8\/2BqVtgj9xGyJWuSFQ4AAAQJP9lPon7PwDwROGAH1qQoAUiQjEaz4bT0QIECAII\/9FBTybKHv8cnCPxAUga9YmKoAIJs6xFqAil+6CQECBAiCtx8W\/oGQCHxdxLQFAGXuHDuJ79x08Ss6IkCAAEHA9sPCPxBZ1794vU6hqScjE754c0WAAAGCIO0nQ+wzhN9+B7UuYgoDgGz2EN9EsOLNFQECBAiCtB+9RUn2rtpQQoJaF7HIhWTiS9wTwYqPgEaAAAGCLPbjI+fL2S1j4R+IpgkvZl3EFAYAKawovZgKUCCb1yJAgABBYPbD5BdERvHrIiZpUwjfAhTTjkoge9ojQIAAYT\/B2E+ouzUBuLSC\/gwmkFGEmBLIFFIJCWToDgECBAj7CcB+Mncu\/EPBQgQUmW+Y2gCgTPxHvwLJ3UOAAAHCfgKwHxb+gZJQzLqIKa+x8U1WCGr4CgECBAj7KdZ+2PUCSjiS4W9dxNQmwFvEd0vUoOYuESBAgLCfGUW+G7HPYEhz6H0sRx+zTGe5BRJHHOszR4AAAcJ+Amt+WPgHosffuojWn6Q2YD++iWBBLV6AAAEClC6+OfjrAO1HD6Vk4R8oFT4yEAlZ0wstZo16QNcOAQIEKEUMXnwnQPvJMPkFxlDQuogEAGVimwgWYAI\/AgQIUBrtR37kv9F3uwEiaM7z1kZ9ASFKLF7DYAGu3oQAAQKUCm5+1Rus\/WRY+AcMw\/u6iKndAcNGHBPBAozdRoAAAUoFeuDzNwd\/HWVjAxD9kIZ760gAkE2AYpQIFqC8IkCAAKXLfnxv867Dwj9gJnpyey4vJwDIWVwxymAIUF4RIECAEk6waV+2jiNNCBiFl3URrcFL8hatnkxciiLYLcwQIECAkowt8PnmV73BdrJZ+AdMI++6iAQAZfWJWExkB7t\/LQIECFBiCSPwucjtJwHCJu+6iAQAZf06x0KAgl29GgECBCix6KE\/A50HA3lPFv6BeA1s2IZ5gh1CSADWeFgsRnODHb1DgAABSr79BBL4bGs8mD4Ak8m1LqI1hEAFthVULAZ0gx29Q4AAAUogeuBzUPaTYeEfiA+51kWM14BHBFghfeYLULAR0AgQIEAJJPD9LmxdZya\/IBbo2V6qxupDmNRhmwCZnwgW+PQlAgQIUKIII\/A5w8I\/EEOcAfsEALl\/tQ1f0iLYCGgECBCgpKGH\/gRlPxkW\/oGYD2+oIR+rGhMAlFUTDR8VC3z9AgQIEKBk2k8g+104WxEiJyBerbu+LiIJ8NnbyJh8uwO\/fAgQIEAJIaTAZxb+gVijT3sxipmVWGyJGsZUHQIECFASCCnwOcPCPxBz9HURCQDKSuCxNWGLLK0eAoQAwY+EFPicYeEfSAT64AE12UksEsHCsDQECBCg2BNS4HNGm3Rn20iINfogEAFALoJo7EmGsYMbAgQIULzRQ38CDHzOMPkFCUJFQ0uVluaTACBn4Zj\/TQ\/DXxEgQIBijB76E2Dgc4aFfwBSKUBmDo+FtFgRAgQIUIz57PkZIU1+6TnD9JgBko3hiWAhrWCJAAECFFfC2Oxdoe96QcAEQHoEyMzh3pDy1BAgQIBiiRgPk18AEAiGJ4KFEQGNAAECFEv0vPdgV\/3JEPsMkD6sbo+ZAhTSgDQCBAhQ\/Agv751dLwDSLEAGdnv0GO1g4xERIECAYkZ4ee\/segGQTkzOhA8pAhoBAgQoZoSX955h8gsgxVhxNqYN\/VoR0IFPzyFAgADFifDy3tn1AiDNGJsIFlIENAIECFCcCC\/0J8OuFwDpxor\/M02AwluSAwECBCgehJf3nmHyCwABMjITPrwIaAQIEKB4EGreu54AwuQXQDoJabuJIgkvAhoBAgQoHoQ6+aXvekFRA6QTMxPBwouARoAAAYoB4eW9Z+7c9YLJL4A0Y+AaYOFFQCNAgACZTqh57+x6AQAWBm6JGuqmhAgQIEBGY9lPGJNfeuwzW74DIEBGdYdCjYBGgAABMppQQ3\/Y9QIAst4TDEkECzUCGgECBMhcQs17Z9cLALChz4mbcD6hRkAjQIAAGUqoee8ZFv4BANd+kQm3hVAjoBEgQIAMJdTJL3a9AAB3AQoj6Ljgxjvkk0GAAAEyDj3v\/cvtzeHdVtj1AgB0zEkECzsCGgECBMg4mPwCgJILUMlDA8OOgEaAAAEyjlAnv9j1AgBcMCcRLOwIaAQIECCzCHXR5wy7XgCAtz5SyQUo7AhoBAgQIIPQF30OY\/KLXS8AwKMAlfwuEUE4NgIECJApRDb5xcI\/AJAVczLhI1ikHgECBMgIwp78YtcLAPCCNfdUwkSwCCKgEaBEi\/znn3d0dBw5cuTo0aM9PT1UBZMJdcfTDLteAEDhnaUSDhVHEAGNACWT8+fPP\/nkk\/ffiTzy3nvvIUBmEurkF7teAICP\/pIJAhRqsioClDS6urrKysrkcpaXl7\/wwgvr1q2Tf6dPny6PTJ069eTJkwiQaXy5vTmyyS9inwHAowCVMBHMmoYLdUFqBChR\/PWvf33ooYfkWj7zzDPfffed9Xh\/f39tba08XlVVdePGDQTIHMKe\/NKn0pn8AoC86AkTpYoXjGZHDgQoUfzpT3+SC1lWVnbt2jXbU93d3eoyt7e3I0Dm8NnzM6KZ\/GLXCwAo9L5RkjFjvdsWqoEhQIli5cqVciGfe+65rM9WVFTIs5s3b0aADEEP\/RnoPBj4+zP5BQB+Ws2SDhvrK5aFeiAEKFF88sknx48fP3v2bNZny8vL5TK3trYiQCYQ9uQXu14AQJF9p9IKUNg3LgQoLZw\/f15d5o6OjrxV4fTp01c1KL0w0Ce\/bn7VG\/j7s+sFABQpQCVJBAs1Alpv2qSlQ4BSwVNPPaWCoG\/fvp1XgGzgQIETat57hl0vAKAISpsIFl4EdAqbOQQo88tf\/tI9AhoBipIoJ79Y+AcAirmHRHzoUCOgEaDU8atf\/Upd4JaWFmqGCVj2E9LkF7teAEAxlDARLNQIaAQoXbz00kvq6q5du9Z7zSAGKDzCnvxi1wsASIAAhREBfdUBApRMrl+\/Xl9fry7tli1bClJjpCckBjoPhjr5xa4XABAIpUoEi2YN6PS0emkUoGvXrtXU1Kjr+oc\/\/IGqYAI3v+rVJ79CvWcR+wwAgdxMIu5KRbMGNAKUWC5fvvzII4\/IFa2oqHDZ\/AsBipiwJ7\/Y9QIAgqIkiWCRrQGNACWTK1euKPupqqr65JNPqAqG8M3BX1v28+X25sDfn10vACBArESwKO8nka0BjQAlkJs3b6qZL3GgL774gqpgCHre+2fPzwjjEEx+AUAYAhTlLSWyNaARoASyY8cOdS1bW1u7cnD58mUEKGLCnvxi1wsACJaSJIJFGQGNACUNNfnlzrp16xCgKNEnv+T3UO8a7HoBAIHfWCKLKYwyAhoBShRXrly53wMIUJSEvehzhl0vACAcIk4EizgCGgECBChc9B1Pw578YuEfAAgQKxEsmnuLvogrrR4ChADFGz30Z6DzYKhdNHa9AICQjCSaRLCII6ARIECAwiKCyS92vQCA8NAHmCPoX0UcAY0AAQIUChEs+syuFwAQKhEngkUcAY0AAQIUCmHnvWdY+AcAImg+oxpjjj4CGgECBCh4wl70OcOuFwAQCZFtiRp9BDQCBAhQwESw6DO7XgBAxAIU9jx79BHQCBAgQAHD5BcAJIbIEsGiX3QRAQIEKEgiWPSZXS8AIDL0G0647XTkEdAIECBAgRFB3nuGXS8AIEKiSQQrSQQ0AgQIUGCEvehzhl0vACCJAlSSCGgECBCgYIhg0Wd2vQCA6IkgEawkEdAIECBAARDN5Be7XgBACQUovH5XSSKgESBAgIolgkWfM3cOEUcZJAgAKSeCRLBS3dwQIECAiiKCvHcmvwCgVFj3n5AEqFQR0AgQIECB2U9Iiz5nWPgHAAwQoJDuP6WKgEaAAAHyTzShP+x6AQAlJOxEsFJFQCNAgAAFYD\/yc\/Or3rBvPex6AQAlIdQg5VJFQCNAgAD5JIJVfzJMfgGAAYSaCFbC9A4ECBCggtFDf0La8iLDrhcAYAZWmE7gAlTCCGgECBCggtE3\/Aov9EfvGLHrBQCYIECBT8SXMAIaAQIEqDD00J\/Pnp8R3oGY\/AIAQ9BHo4MdpylhBDQCBAhQAdjWPAwv9IeFfwDAHMJLBCthBDQCBAhQAUSw5qHtpsCuFwBgRDsazmIcpV3gHgECBKhg+wk19IddLwDANMLYErW0EdAIECBAnohmzcMMk18AYLYABXhfKm0ENAIECFBh9hPemoe2uwyxzwBgDmEkgpU2AhoBAgQoP9GseZhh1wsAMBV9cDqo9yxtBDQCBAhQHqJZ8zDDrhcAYDBhJIKVPNgRAQIEKCeRrXmYYfILANIkQCWPgEaAAAHKSWRrHtruBex6AQAGEmwiWMkjoBEgQICyE9mahz\/WUXa9AICYCFAgiWAlj4BGgAAByk5kax5mmPwCgDgQbCJYySOgESBAgPLYT9ihPyz8AwCxwJqpD0SATFjuFQECBKhk9pNh1wsAiAl6b63IsWoTIqARIECA7uDL7c2RBT5n2PUCAOJDgIlgJkRAI0CAAP07etK72E\/YoT9MfgFAvAgqcMeECGgECBCgHxnoPBhl2leG2GcAiBtBJYKZEAGNAAEC9L+x7fYVgf3oI8DsegEAscAauSlSgAyZ+keAIO0CFL39sOsFAMSRQDLhDYmARoAg7QIUvf1kmPwCgHiiRy76dhdDIqARIEi1ANmWex7oPBjBQdn1AgBiSiCJYIZEQCNAkF4BstlPqDu9Z719MPkFAPFrUIsOXjQkAhoBgpQKkNiPvuDhl9ubIzioPnrM5BcAxJHit0Q1Z\/EzBAjSKEARL\/f8+V++16e9WfgHAOIuQP5uYuZEQCNAkEYBith+bAM\/2A8AxJciE8F0AaLVQ4AQoMTaj3PgR24ZrPoDAPFF79H5+HNzIqARIEhXVdDtJ+ytvhj4AYDkUWQimDkR0AgQpKgqRLbRKQM\/AIAAZW+PTdr+GQGCVFQF29hPeAseMvADAMnGdyKYURHQCBAkvyrYMt7DW+6ZgR8ASJUAFdq7MyoCGgGChFcFsZ\/Pnp8RwdgPAz8AkBJ8J4IZFQGNAEGSq4Jtn6+Q4n4Y+AGAVGEN5BQqQFYENAKEACFAITLQeVC3n5Ay3hn4AYC0od\/3CoqDNioCGgGCZFaFbw7+WrefMHa6YOAHANKJv0Qw0yKgESBIYFWwhTyHscspAz8AkGZ8LOdjWgQ0AgSJqgrRJHzZBn4MWdELACAyrEQw79E8pkVAI0CQnKoQQcLXv\/7bt1a\/xxr4MWQsFwAgMiyb8T74bVoENAIECakKESR8MfADAGC7H3pPBDMtAhoBgiRUhbATvhj4AQCw3RULimg2MAIaAYLYV4WwE74Y+AEAsFFoIpiBEdAIEMS4KjhDnoNN+GLgBwAgZ8tayJSWgRHQCBDEtSrYpr0CT\/hi4AcAwIWCtkQ1MAIaAYL4VQXnwE+wCV8M\/AAAeBcgL4lgBkZAI0AQs6pgi\/gJPOSZgR8AgILulnkTwcyMgEaAIDZVgYEfAABz0BPBvAsQrR4ChAAVhnPgJ9h4ZwZ+AAAKwnsimJkR0AgQmF4VBi++o6\/vzMAPAEC8BMjMCGgECMytCje\/6mXgBwDAWDwmgpkZAY0AgaFVwba1hRr4ESUK6v0Z+AEACEqAXBLBjI2ARoDAuKqQNdiZgR8AANPwkghmbAQ0AgQGVQVRny+3N4ea5c7ADwBAUFhy4yJAxkZAI0BgRFX45uCvbZHOgQc7Zxj4AQAIFD0TPlcctLER0AgQlLIqZA1zZlcvAIBY4CURzNgIaAQISlMVcqlP4OE+GQZ+AABCw+pbZr2vmhwBjQClgg8++OCtt94aGhoyoSoMXnzHGegTkvow8AMAECpWIljWGS6TI6ARoOTz9ddfP\/LII3J1b968WcKqoIZ8nIE+Sn0GOg8G\/sEZ+AEACBsrxjlrJrzJEdAIUMIZGBioq6tTV7ckAqS8J+uQjwr0CXBpHwsGfgAAosE9E97kCGgEKMn09fU98cQT1tWNTICU9OSKbg5ptsv5bWTgBwAgbPREMGc\/0+QIaAQosbz++uuVlZX3a4QqQHmlJwL1cQ78yH8Z+AEACA+XRDDDI6ARoARy+\/Zta+Cnrq7uj3\/8Y0gCJNIz0HkwV2SP03vCmO2yYOAHAKA0TWyOYR7DI6ARoAQioiPXsqKi4ve\/\/\/3Q0FBHR4cPAfr8vf8pvjJ48R2lOCqOp3fD38tPXt3RpSfYlQxz9T8Y+AEAKBW5tkQ1MwL6qsbp06cRoERx+\/bt7du3DwwMqP8WKkBe5CbXT+cz036xtHHGP\/yzKEhkPwz8AACYIEC2RDADI6D1fr4NBCiBhC1ASnrqlm+0iUj0Pwz8AABET65EMAMjoBEgBKgwARLFkZ8\/Pvfolv\/ytLiO+hHjmfEP\/1xy6WHgBwCgtOiJYNaDZkZAI0AIkFvNWFb9oPz898Pt\/9J+WqwiFj8M\/AAAlIqsiWBmRkBfdYAAIUB2NU5qVQAAgAgEyPA1oNPT6iFACBAAAISFMxHM8DWgESAECAECAIDABMhKBDN8DWgECAFCgAAAoFhsiWDu+2MgQAgQAgQAAEnACnlWAmT+GtAIEAKEAAEAQLHoQz7yuxUBbVsaEQFCgBAgAABIDrZEsFhEQCNACBACBAAAxWJJj741tckR0AgQAoQAAQBAsViJYPoWjYavUosAAQIEAABFYcX96D+0eggQAgQAAElGn\/mKRQQ0AgQIEAAAFIueCBaLCGgECBAgAAAoFj0RLBYR0AgQIEAAABBEW3unABkeAY0AAQIEAAABYCWCxSICGgECBAgAAAIWIPMjoBEgQIAAACAA9EQw8yOgESBAgAAAIAD0RDDzI6ARIECAAAAgAD7\/y\/fVO86rH\/MjoBEgQIAAAIBWDwGiKiBAAABAq4cAURUAAABo9RAgqgIAAACtHgJEVQAAAKDVQ4CoCgAAALR6CBBVAQAAgFYPAaIqAAAA0OohQFQFAAAAWj0EiKoAAABAq4cAURUAAABo9RAgqgIAAACtHgJEVQAAAKDVQ4CoCgAAAAgQUBUAAAAQIECAAACAVg8BoiogQAAAQKuHAFEVAAAAaPUQIKoCBFDOCoqCQqaQgUKm1UOAqAoUMlDIFDJQyJQwAkRVoJCBQqaQKWQKmRJGgKgKFDJQyBQyhQyUMAJEVaCQgUKmkClkoIQRoOCqwunTp69CCEjBUsgUMoUMFLJpJYwAIUAAAACpAwFCgAAAABAgBAgBAgAAQIAQoGQLEAAAQApJasuOAAEAAEDqQIAAAAAAAQIAAABAgAAAAAAQIAAAAAAECAAAAAABAgAAAECAAAAAABAgAAAAAAQIAAAAAAECAAAAQIAAAAAAECAAAAAABChErl271tHRceTIEfn3+vXrFEiofPDBB2+99dbQ0BBFETiff\/65qslHjx7t6emhQMLg8uXLUrxSyF1dXbdv36ZAwub48eNSq7ljBIjU25u5QYDSgujOiy++eL\/G1KlTW1tb+bKFxNdff\/3II49IOSfpa2YC58+ff\/LJJ++\/E3nkvffeo3CC4uLFi7ZCrqys\/N3vfkfJhMeBAwdUUXPHCJAXXnjh\/twgQKlAvlFPPfWUXO+ysrLGxsZ169Y9++yzqgY0NTVRPoEzMDBQV1fH7Sxwurq6pA5LqZaXl8utTWqy\/Dt9+nQl9CdPnqSIiufs2bOqSB966CHpNem3i5UrV1I+YXDlyhWp0twxAmf27NkIUNrZtm2bXOyKiooPPvjAevCNN95QleDIkSMUUYD09fU98cQT1neM21lQ\/PWvf5UmWYr0mWee+e6776zH+\/v7a2tr5fGqqqobN25QUMUwNDT02GOPSWGKwYvHO8cnOjo6KKXAy1x1ULljBN7zV0W6e\/fud7KBACWf27dvi\/qoSmB7Svp2avqAUgqK119\/vbKyUu9kcDsLij\/96U9qFPPatWu2p7q7u1Vpt7e3U1DFcOzYMVWSzsgqNQ7EmHFIHVTRd+4YwXLy5El1x0h8BBsClBPpsanvld5pVnz00Ue5bnbgQzStgR\/pPf\/xj3\/kdhYsK1eulPJ87rnnsj6rLH\/z5s0UVJEG\/\/TTT\/\/85z93PrV27Vop4ZqaGkopQD744AMp1UceecQakueOERT79++X8qytrU38J0WActLS0iKVYPbs2c6nhoaGpk6dKs9K35qCKhI13CrN8O9\/\/3spWMs7uZ0FxSeffHL8+PGzZ89mfVaFULS2tlJQIfH8889LCcu\/FEVQDA4OqglHuV10dXVxxwgWlfcj\/yJA6aWxsVEqgfyb9dm\/+7u\/k2fXrVtHQRXJ7du3t2\/fboVNIEBRcv78eSJUQuX06dOqhN944w1KIyheeuklKVL5NzMc4M8dI1hUJsprr70mtXf16tXLli0TfZfGTm4XCFBaWLp0qVSCtWvXZn12+fLlJHeEAQIUJSqGtKqqiuVqAvee48ePS5uhku9y3UbAByrcavbs2YODgwhQ4AwNDalKW11d7cz\/Eh9K0r0CAcqJWo0m1xhPQ0MDgY0IUKz55S9\/SQR0qE2IorGxkSS7oPj6669VSqO1fhUCFCwXL160qu4LL7wgN4fOzs7XXnvNitRMUrcfAcqJ+prlEiD3CTJAgAznV7\/6lSrnlpYWSiNYBgcHpWu0du1auT+oYMGqqqpcMVhQEPX19baQNQQoWI4ePVo2jG1aXLTeWh0xMSuHIUA5mTVrFiNACFAiUSEUTM1EwBdffFFTUyNF\/eCDD\/b391MgxbBnzx61\/og+C4MAhUHWMUsxe5UzsWLFCgQo4agYoNWrV2d9dtmyZSmJk0eAksT169dVH1rYsmULBRIBPT09qsC3bdtGafimu7v7b4eRX\/THEaAoUYNAs2bNQoASTlNTk8skl1opnOkDBChGXLt2TY1GCH\/4wx8okMhQaTUNDQ0UhW\/UclYzZ85cfifWYtDSKZX\/\/va3v6WswkMtAlxRUYEAJZx\/+qd\/yrUYlBXkyG4YCFBcuHz5sorrl5sXm38FTm9vb1dXl75njo5KGpV\/KSjfrFix4n4PEJdZJDdu3Pjoo4\/kdpH12dWrV6sEMQQo4aiRVREd50rQZ8+eZSVoBChGXLlyRdlPVVXVJ598QoEEjpoTX7JkSdZnVUAhq2YUw3vvvdeejdbWVnXH+POf\/yz\/Td5aNREjddhl4fg5c+YQA5QKhoaGVCLY7373O9tTaqHMrMveAwJkGlKSauZLHOiLL76gQMJgx44dqt7aIlT0Kv3WW29RUCH1VLljBMVvfvObvDWZLLAU3dRsCYEqE4HFcxGg2LXN0lfuykGuEW\/wyHfffaf6S7W1tfqms9JUPPjgg\/L4E088IX0qCgoBMpz+\/n61P6D0mvr6+vSarParrq+vT8yHRYDckBvWc889p75d8svq1auffPJJ9V82wUCA4oKa\/HKH+lw80kJMnz5dCnPq1KlNTU0vvviiFZ87e\/Zs3YoAATKZ48ePqyBXqckNDQ1Sk59++mlVyOLxzpgQBCix3Lhxo6WlRa1mphA7JtEAAYoLV65c8RI6igAFwuXLl5999lm9YOXWITcQa6s7QIBiwcWLF201WeR+8+bNavsRBChd3L59+8SJE2pLbcaxAcCFr7\/+urOzU1T+1KlT3C4gvvzlL39RDd\/p06cTWZMRIAAAAEgdCBAAAAAgQAAAAAAIEAAAAAACBAAAAIAAAQAAACBAAAAAAAgQAAAAAAIEAAAAgAABAAAAIEAAAAAACBAAAAAAAgQAAACAAAEAAAAgQAAAAAAIEAAAAAACBAAAAAgQAAAAAAIEAAAAgAABAAAAIEAAAAAACBAAAAAAAgQAAACAAAEAAAAgQAAAAAAIEAAAAAACBAAAABAc\/wskOR9BSV3boAAAAABJRU5ErkJggg==","width":365}
%---
%[text:image:3e56]
%   data: {"align":"baseline","height":26,"src":"data:image\/png;base64,iVBORw0KGgoAAAANSUhEUgAAAB4AAAApCAYAAAAiT5m3AAADOElEQVR42r1XSWgUQRSNGndR3Ii7V\/EmCCp4DaIe1Oh4EMHBwMjsq47Eg+OOJ0VIICAeFAIeXEADHgyoqChE1ASNhISAxH0jg5gxq+\/FX1A009PTM93T8OiuX7\/q1f+\/+tevqqoCTyKRWBmNRo8Cj4GPwF++I5HII7zT8Xh8eZWTTzgcnh6Lxc5j8kFgHMgCT4G7wBPgl8j\/YBGnfT7f1LJJg8HgQrGQE3diAXVciK5DIsi3o7+devh+4Pf755dMmslkpmGih0LaiHa1hf5k6J0T\/TYrfdMHKz8pFjTr1kFWD9ltvJ8Bt\/Dt1d0rYeG4Y7ZJMbAG+A300HLKuHkw2SuxKAe8lQ3Gdjv6llLP4\/FMQfs1MMBQ2SUOyaoPihur0X4BDGEDHVGLYbwhawCG6QG6W6yu43jo+uwSt3IyWLlA2vt09+F7CwlDodAaaZ+Q\/j3inZn0GENil\/gd0Ke1rwEjgUBgDqzYIe4lBiBbkkqlZov7r2hjXtLldom\/0LVa+x7QK9+NGjHduUvkfcAdbUwb0G+XuNtg8WV6QeLXbCDeKzo9QJM2phPosEt8ExijG9nG5NuKJK6VTTeXrofudbvEh2TS49r\/eakQMeQXNV2v9Nfbzc9c8U\/GWv2LKkmYEat+r9c7Q+L9nZvOdhLBhOF86c+MWJ5JkLVIX6jUdM1Jbsgk3NU1RRBPHCzQ2crxZR0U3CBC8saKGO3NCNNGx85kpk4QPLfaXJr8jGPkKs4FfqesJv9kcP1OvFeXa70Z8Ygmz1KWTCYX4fuDqlAQhnUVIWafQfesXjjgF5zlCrGWSBQuyOm1nuEARqGTqRgxKxejrm1iYL+URKPFEktJrGSDpRJ3aYlGYRhFwjK8T+lyle+1yrUsYjMM5ZG9l0tBzk3iYvGfWE6XVWYniyvEci1RgjEpZwP6Itwi7jfppHy31Mz3HSeGNZvw8aOAUs5h0olUqqqPFVIhjlcI34wXsMMuWWhEb76ibwPw1U1ibmCzwm+tdil3HEyfhcrdBhetbrW6pHe5RNxiVeTXukTcVEyevupCjA9YEqfT6XlyGXOKuINnQ1GnEy9y6uJeBuFn3qXxxyzmnP8Amz0wy7TM4YgAAAAASUVORK5CYII=","width":19}
%---
%[text:image:479b]
%   data: {"align":"baseline","height":20,"src":"data:image\/png;base64,iVBORw0KGgoAAAANSUhEUgAAADUAAAAxCAYAAAB6d+FmAAAC0ElEQVR42u2aO4gTURSGs6Lugo1WW2ghgiyCr1VWbRSR9YEgKoKohcQmEDAviYhBIaVbbKEWYi22YidoobUItoqwjSui6wt119Wsj+\/onXAcJslMZpI7AxP4Sbh37pnz3TP3zJ2TyWQS9imVStvRK1G5XL5ZqVRWZpL8MUCf0G+lz+hYIoGIyDYPIEc\/i8ViLmkRGkMfWwA5WkD7EwHEutmCs+87ADl6zfHLm4MLhcIqGs7RcV0WoA1xCa3vIkL\/CTsX\/w7G2Bka5oIMjlo4M6GBmOTRABHSeirh3S0LzSYQugHHgAPEJG+l7UOXtr6LgQeqYQZdRVf6Jc5frdfriyKIkOgHQToi1+0XpxGD+ywnhc348a5bICboqLMYmx02784hgRYAOqEzjHWoSIHiABU5kG2osECMP9lqC2IFiqS0qSdAtqAM0Ey3QOhUp81iX6F6DtRvKM6xsedA\/YQKCdQgyx0PcrKeQ4WNkE4K+LhGb6usQOHQOnnOCb31+WdrNW1TQC22BoW9Ddh9i6bRfNDdNkCH1c59LW0vpc8qFDYfo\/tkvMFqtbqM3xdkffgAmseXQ44dM3ba6bcGlc1mh9yzbaK3k\/Y37YAYc9Dl47A+xhoU0dlh7A579I3qRx6lbwAd8PAxHlA4V5BF3ea8Z11Ac62e52IDhb1bZuZL+lFdRWtQpflZzj3exlZsIvVc2b7jdW8xiWSWVL2ng4\/2ofL5\/Ars\/XJdXudN9wC\/R4Ce5PurFH58RN0+FLb2et130D1VVJlCu3zasw9FFC67dwboialUnZadQcBJsg+F09ewd9tkwLFcLrckZOTjkSgi3pmkUClUCpVCpVApVAqVQqVQ0UDp6s5IHKFMeaz5doufYuYz9bf\/XXmXQaqgcZH4I34pqBd+Qluz\/LpBUF3qCEUol3LgwyQAEbFHUrDxW6OTyk7NFEsaMYNpGL9qfoH+AOOEPfJuI6OmAAAAAElFTkSuQmCC","width":22}
%---
%[text:image:1da2]
%   data: {"align":"baseline","height":20,"src":"data:image\/png;base64,iVBORw0KGgoAAAANSUhEUgAAADUAAAAxCAYAAAB6d+FmAAAC0ElEQVR42u2aO4gTURSGs6Lugo1WW2ghgiyCr1VWbRSR9YEgKoKohcQmEDAviYhBIaVbbKEWYi22YidoobUItoqwjSui6wt119Wsj+\/onXAcJslMZpI7AxP4Sbh37pnz3TP3zJ2TyWQS9imVStvRK1G5XL5ZqVRWZpL8MUCf0G+lz+hYIoGIyDYPIEc\/i8ViLmkRGkMfWwA5WkD7EwHEutmCs+87ADl6zfHLm4MLhcIqGs7RcV0WoA1xCa3vIkL\/CTsX\/w7G2Bka5oIMjlo4M6GBmOTRABHSeirh3S0LzSYQugHHgAPEJG+l7UOXtr6LgQeqYQZdRVf6Jc5frdfriyKIkOgHQToi1+0XpxGD+ywnhc348a5bICboqLMYmx02784hgRYAOqEzjHWoSIHiABU5kG2osECMP9lqC2IFiqS0qSdAtqAM0Ey3QOhUp81iX6F6DtRvKM6xsedA\/YQKCdQgyx0PcrKeQ4WNkE4K+LhGb6usQOHQOnnOCb31+WdrNW1TQC22BoW9Ddh9i6bRfNDdNkCH1c59LW0vpc8qFDYfo\/tkvMFqtbqM3xdkffgAmseXQ44dM3ba6bcGlc1mh9yzbaK3k\/Y37YAYc9Dl47A+xhoU0dlh7A579I3qRx6lbwAd8PAxHlA4V5BF3ea8Z11Ac62e52IDhb1bZuZL+lFdRWtQpflZzj3exlZsIvVc2b7jdW8xiWSWVL2ng4\/2ofL5\/Ars\/XJdXudN9wC\/R4Ce5PurFH58RN0+FLb2et130D1VVJlCu3zasw9FFC67dwboialUnZadQcBJsg+F09ewd9tkwLFcLrckZOTjkSgi3pmkUClUCpVCpVApVAqVQqVQ0UDp6s5IHKFMeaz5doufYuYz9bf\/XXmXQaqgcZH4I34pqBd+Qluz\/LpBUF3qCEUol3LgwyQAEbFHUrDxW6OTyk7NFEsaMYNpGL9qfoH+AOOEPfJuI6OmAAAAAElFTkSuQmCC","width":22}
%---
%[text:image:7ff7]
%   data: {"align":"baseline","height":20,"src":"data:image\/png;base64,iVBORw0KGgoAAAANSUhEUgAAADUAAAAxCAYAAAB6d+FmAAAC0ElEQVR42u2aO4gTURSGs6Lugo1WW2ghgiyCr1VWbRSR9YEgKoKohcQmEDAviYhBIaVbbKEWYi22YidoobUItoqwjSui6wt119Wsj+\/onXAcJslMZpI7AxP4Sbh37pnz3TP3zJ2TyWQS9imVStvRK1G5XL5ZqVRWZpL8MUCf0G+lz+hYIoGIyDYPIEc\/i8ViLmkRGkMfWwA5WkD7EwHEutmCs+87ADl6zfHLm4MLhcIqGs7RcV0WoA1xCa3vIkL\/CTsX\/w7G2Bka5oIMjlo4M6GBmOTRABHSeirh3S0LzSYQugHHgAPEJG+l7UOXtr6LgQeqYQZdRVf6Jc5frdfriyKIkOgHQToi1+0XpxGD+ywnhc348a5bICboqLMYmx02784hgRYAOqEzjHWoSIHiABU5kG2osECMP9lqC2IFiqS0qSdAtqAM0Ey3QOhUp81iX6F6DtRvKM6xsedA\/YQKCdQgyx0PcrKeQ4WNkE4K+LhGb6usQOHQOnnOCb31+WdrNW1TQC22BoW9Ddh9i6bRfNDdNkCH1c59LW0vpc8qFDYfo\/tkvMFqtbqM3xdkffgAmseXQ44dM3ba6bcGlc1mh9yzbaK3k\/Y37YAYc9Dl47A+xhoU0dlh7A579I3qRx6lbwAd8PAxHlA4V5BF3ea8Z11Ac62e52IDhb1bZuZL+lFdRWtQpflZzj3exlZsIvVc2b7jdW8xiWSWVL2ng4\/2ofL5\/Ars\/XJdXudN9wC\/R4Ce5PurFH58RN0+FLb2et130D1VVJlCu3zasw9FFC67dwboialUnZadQcBJsg+F09ewd9tkwLFcLrckZOTjkSgi3pmkUClUCpVCpVApVAqVQqVQ0UDp6s5IHKFMeaz5doufYuYz9bf\/XXmXQaqgcZH4I34pqBd+Qluz\/LpBUF3qCEUol3LgwyQAEbFHUrDxW6OTyk7NFEsaMYNpGL9qfoH+AOOEPfJuI6OmAAAAAElFTkSuQmCC","width":22}
%---
%[text:image:8f66]
%   data: {"align":"baseline","height":20,"src":"data:image\/png;base64,iVBORw0KGgoAAAANSUhEUgAAADUAAAAxCAYAAAB6d+FmAAAC0ElEQVR42u2aO4gTURSGs6Lugo1WW2ghgiyCr1VWbRSR9YEgKoKohcQmEDAviYhBIaVbbKEWYi22YidoobUItoqwjSui6wt119Wsj+\/onXAcJslMZpI7AxP4Sbh37pnz3TP3zJ2TyWQS9imVStvRK1G5XL5ZqVRWZpL8MUCf0G+lz+hYIoGIyDYPIEc\/i8ViLmkRGkMfWwA5WkD7EwHEutmCs+87ADl6zfHLm4MLhcIqGs7RcV0WoA1xCa3vIkL\/CTsX\/w7G2Bka5oIMjlo4M6GBmOTRABHSeirh3S0LzSYQugHHgAPEJG+l7UOXtr6LgQeqYQZdRVf6Jc5frdfriyKIkOgHQToi1+0XpxGD+ywnhc348a5bICboqLMYmx02784hgRYAOqEzjHWoSIHiABU5kG2osECMP9lqC2IFiqS0qSdAtqAM0Ey3QOhUp81iX6F6DtRvKM6xsedA\/YQKCdQgyx0PcrKeQ4WNkE4K+LhGb6usQOHQOnnOCb31+WdrNW1TQC22BoW9Ddh9i6bRfNDdNkCH1c59LW0vpc8qFDYfo\/tkvMFqtbqM3xdkffgAmseXQ44dM3ba6bcGlc1mh9yzbaK3k\/Y37YAYc9Dl47A+xhoU0dlh7A579I3qRx6lbwAd8PAxHlA4V5BF3ea8Z11Ac62e52IDhb1bZuZL+lFdRWtQpflZzj3exlZsIvVc2b7jdW8xiWSWVL2ng4\/2ofL5\/Ars\/XJdXudN9wC\/R4Ce5PurFH58RN0+FLb2et130D1VVJlCu3zasw9FFC67dwboialUnZadQcBJsg+F09ewd9tkwLFcLrckZOTjkSgi3pmkUClUCpVCpVApVAqVQqVQ0UDp6s5IHKFMeaz5doufYuYz9bf\/XXmXQaqgcZH4I34pqBd+Qluz\/LpBUF3qCEUol3LgwyQAEbFHUrDxW6OTyk7NFEsaMYNpGL9qfoH+AOOEPfJuI6OmAAAAAElFTkSuQmCC","width":22}
%---
%[text:image:00e9]
%   data: {"align":"baseline","height":24,"src":"data:image\/png;base64,iVBORw0KGgoAAAANSUhEUgAAACgAAAAsCAYAAAAXb\/p7AAADlklEQVR42u1YS0hUYRQejR4UvR+SvaCyWiS2DIoCKWjVYzG2SsYWQ+a8HRwXFkOgqdGLSoSeqyBaJUGLCKGkNpGtgiyScnpYBpaU5au+E+eH03Wu93rvP2OEFw46955z\/u8\/7\/\/3eDQ+4XD4Eui65199AK4d1DEJcBLgfw0wGo2ujkQi1yoqKlY5AFgDqnWw5lpaMxaLrbBkDgaDm7HIEKjTCcjxPqFQqABrdYEGsHaRXaESCAyCXpNFMwwuReDw\/77xusurQGJna0ysPR2K94CnGdQKesnUyu92J5PJaelk4c51Chzcu9dp0O9nkO3yvd\/vnwqlEbzvAf2yoB5sIkwyBt0doJ+0Qbdu2AXyC8UrOVuNQH5Q3IJegfrTfH8ikwC\/A9hjsdaYCQQCG6D4vVj0DShB7+HKXMGaQ\/EFADEGrPhJdn1GAhoZvRDKX4jFTvt8vhlWchSD4D0OGiE5AH9eXl4+PxNF+IoCB8sccyBfreQB8qJWcAC0CYqHeYE2cqEDNTmQvcc6hlC+CnXWq\/PCtTtdeGGr0HNWFz7aeTcr\/eT1eqe41PVWJYxd62zkovwXqQ6Cv8vErm9r8MZNEctLVf9Ph4GwecSOjPSQu8V28e6chmRrFPq28btHJhhSBKDIBH0B726HEDilAWCtsGCx6MmjMNgaHqBkiygPl3UmHE1OrjOEiqoqsqDHGizYxrqGAXCOriL9jJUOoq3lO9UDQItpQGD3PtXZRapFHB51oSchwiWsDWA8Hl8Cpb2svA+WWO4AXJ7Q0Z1IJObq7sUBN\/UQLr0hrHfANSCaQihrobiBf+dC+QOxSNk4MrdEyN1VvRy6T+DdVbOp2wpcCyutN8yDahjtVZ3A4sS2ALwflYxhaK1n0C22QfL8dkuNRYZBlKxxRLj6gg3XNgj+w8beLOriHcv50gocJ8wsfP\/ASgfMDlRs8XzwfGPeThMr2QcpEqFprJmPSoSwSvMYfCcFX6nFlNPEfAGrUuC1GkhxQpspTnTfKysrFxl5qqqqZouy0mU81ZmApB6cp2vKlrFVk+Z7TGRuPOsXRZSNfGYmEO\/ofoXmOiKKS3Ga6wPYeRNxk9Vo49BONAIL1mUdIBa9bxPgn+zMOkAqIXDdQbp1sKAy6uWeyWd0Cyuk5LDh3pTtez\/NSVJqNwbh5kNZB8htkTrP1zHA9dM1nZ07nExmc50ZQGA7M+GxyLden9MA\/OLm\/KKe34xPoKAD7jPkAAAAAElFTkSuQmCC","width":22}
%---
%[text:image:0d6c]
%   data: {"align":"baseline","height":20,"src":"data:image\/png;base64,iVBORw0KGgoAAAANSUhEUgAAADUAAAAxCAYAAAB6d+FmAAAC0ElEQVR42u2aO4gTURSGs6Lugo1WW2ghgiyCr1VWbRSR9YEgKoKohcQmEDAviYhBIaVbbKEWYi22YidoobUItoqwjSui6wt119Wsj+\/onXAcJslMZpI7AxP4Sbh37pnz3TP3zJ2TyWQS9imVStvRK1G5XL5ZqVRWZpL8MUCf0G+lz+hYIoGIyDYPIEc\/i8ViLmkRGkMfWwA5WkD7EwHEutmCs+87ADl6zfHLm4MLhcIqGs7RcV0WoA1xCa3vIkL\/CTsX\/w7G2Bka5oIMjlo4M6GBmOTRABHSeirh3S0LzSYQugHHgAPEJG+l7UOXtr6LgQeqYQZdRVf6Jc5frdfriyKIkOgHQToi1+0XpxGD+ywnhc348a5bICboqLMYmx02784hgRYAOqEzjHWoSIHiABU5kG2osECMP9lqC2IFiqS0qSdAtqAM0Ey3QOhUp81iX6F6DtRvKM6xsedA\/YQKCdQgyx0PcrKeQ4WNkE4K+LhGb6usQOHQOnnOCb31+WdrNW1TQC22BoW9Ddh9i6bRfNDdNkCH1c59LW0vpc8qFDYfo\/tkvMFqtbqM3xdkffgAmseXQ44dM3ba6bcGlc1mh9yzbaK3k\/Y37YAYc9Dl47A+xhoU0dlh7A579I3qRx6lbwAd8PAxHlA4V5BF3ea8Z11Ac62e52IDhb1bZuZL+lFdRWtQpflZzj3exlZsIvVc2b7jdW8xiWSWVL2ng4\/2ofL5\/Ars\/XJdXudN9wC\/R4Ce5PurFH58RN0+FLb2et130D1VVJlCu3zasw9FFC67dwboialUnZadQcBJsg+F09ewd9tkwLFcLrckZOTjkSgi3pmkUClUCpVCpVApVAqVQqVQ0UDp6s5IHKFMeaz5doufYuYz9bf\/XXmXQaqgcZH4I34pqBd+Qluz\/LpBUF3qCEUol3LgwyQAEbFHUrDxW6OTyk7NFEsaMYNpGL9qfoH+AOOEPfJuI6OmAAAAAElFTkSuQmCC","width":22}
%---
%[text:image:66f3]
%   data: {"align":"baseline","height":20,"src":"data:image\/png;base64,iVBORw0KGgoAAAANSUhEUgAAADUAAAAxCAYAAAB6d+FmAAAC0ElEQVR42u2aO4gTURSGs6Lugo1WW2ghgiyCr1VWbRSR9YEgKoKohcQmEDAviYhBIaVbbKEWYi22YidoobUItoqwjSui6wt119Wsj+\/onXAcJslMZpI7AxP4Sbh37pnz3TP3zJ2TyWQS9imVStvRK1G5XL5ZqVRWZpL8MUCf0G+lz+hYIoGIyDYPIEc\/i8ViLmkRGkMfWwA5WkD7EwHEutmCs+87ADl6zfHLm4MLhcIqGs7RcV0WoA1xCa3vIkL\/CTsX\/w7G2Bka5oIMjlo4M6GBmOTRABHSeirh3S0LzSYQugHHgAPEJG+l7UOXtr6LgQeqYQZdRVf6Jc5frdfriyKIkOgHQToi1+0XpxGD+ywnhc348a5bICboqLMYmx02784hgRYAOqEzjHWoSIHiABU5kG2osECMP9lqC2IFiqS0qSdAtqAM0Ey3QOhUp81iX6F6DtRvKM6xsedA\/YQKCdQgyx0PcrKeQ4WNkE4K+LhGb6usQOHQOnnOCb31+WdrNW1TQC22BoW9Ddh9i6bRfNDdNkCH1c59LW0vpc8qFDYfo\/tkvMFqtbqM3xdkffgAmseXQ44dM3ba6bcGlc1mh9yzbaK3k\/Y37YAYc9Dl47A+xhoU0dlh7A579I3qRx6lbwAd8PAxHlA4V5BF3ea8Z11Ac62e52IDhb1bZuZL+lFdRWtQpflZzj3exlZsIvVc2b7jdW8xiWSWVL2ng4\/2ofL5\/Ars\/XJdXudN9wC\/R4Ce5PurFH58RN0+FLb2et130D1VVJlCu3zasw9FFC67dwboialUnZadQcBJsg+F09ewd9tkwLFcLrckZOTjkSgi3pmkUClUCpVCpVApVAqVQqVQ0UDp6s5IHKFMeaz5doufYuYz9bf\/XXmXQaqgcZH4I34pqBd+Qluz\/LpBUF3qCEUol3LgwyQAEbFHUrDxW6OTyk7NFEsaMYNpGL9qfoH+AOOEPfJuI6OmAAAAAElFTkSuQmCC","width":22}
%---
%[text:image:129c]
%   data: {"align":"baseline","height":24,"src":"data:image\/png;base64,iVBORw0KGgoAAAANSUhEUgAAACgAAAAsCAYAAAAXb\/p7AAADlklEQVR42u1YS0hUYRQejR4UvR+SvaCyWiS2DIoCKWjVYzG2SsYWQ+a8HRwXFkOgqdGLSoSeqyBaJUGLCKGkNpGtgiyScnpYBpaU5au+E+eH03Wu93rvP2OEFw46955z\/u8\/7\/\/3eDQ+4XD4Eui65199AK4d1DEJcBLgfw0wGo2ujkQi1yoqKlY5AFgDqnWw5lpaMxaLrbBkDgaDm7HIEKjTCcjxPqFQqABrdYEGsHaRXaESCAyCXpNFMwwuReDw\/77xusurQGJna0ysPR2K94CnGdQKesnUyu92J5PJaelk4c51Chzcu9dp0O9nkO3yvd\/vnwqlEbzvAf2yoB5sIkwyBt0doJ+0Qbdu2AXyC8UrOVuNQH5Q3IJegfrTfH8ikwC\/A9hjsdaYCQQCG6D4vVj0DShB7+HKXMGaQ\/EFADEGrPhJdn1GAhoZvRDKX4jFTvt8vhlWchSD4D0OGiE5AH9eXl4+PxNF+IoCB8sccyBfreQB8qJWcAC0CYqHeYE2cqEDNTmQvcc6hlC+CnXWq\/PCtTtdeGGr0HNWFz7aeTcr\/eT1eqe41PVWJYxd62zkovwXqQ6Cv8vErm9r8MZNEctLVf9Ph4GwecSOjPSQu8V28e6chmRrFPq28btHJhhSBKDIBH0B726HEDilAWCtsGCx6MmjMNgaHqBkiygPl3UmHE1OrjOEiqoqsqDHGizYxrqGAXCOriL9jJUOoq3lO9UDQItpQGD3PtXZRapFHB51oSchwiWsDWA8Hl8Cpb2svA+WWO4AXJ7Q0Z1IJObq7sUBN\/UQLr0hrHfANSCaQihrobiBf+dC+QOxSNk4MrdEyN1VvRy6T+DdVbOp2wpcCyutN8yDahjtVZ3A4sS2ALwflYxhaK1n0C22QfL8dkuNRYZBlKxxRLj6gg3XNgj+w8beLOriHcv50gocJ8wsfP\/ASgfMDlRs8XzwfGPeThMr2QcpEqFprJmPSoSwSvMYfCcFX6nFlNPEfAGrUuC1GkhxQpspTnTfKysrFxl5qqqqZouy0mU81ZmApB6cp2vKlrFVk+Z7TGRuPOsXRZSNfGYmEO\/ofoXmOiKKS3Ga6wPYeRNxk9Vo49BONAIL1mUdIBa9bxPgn+zMOkAqIXDdQbp1sKAy6uWeyWd0Cyuk5LDh3pTtez\/NSVJqNwbh5kNZB8htkTrP1zHA9dM1nZ07nExmc50ZQGA7M+GxyLden9MA\/OLm\/KKe34xPoKAD7jPkAAAAAElFTkSuQmCC","width":22}
%---
%[text:image:9822]
%   data: {"align":"baseline","height":26,"src":"data:image\/png;base64,iVBORw0KGgoAAAANSUhEUgAAAB4AAAApCAYAAAAiT5m3AAADOElEQVR42r1XSWgUQRSNGndR3Ii7V\/EmCCp4DaIe1Oh4EMHBwMjsq47Eg+OOJ0VIICAeFAIeXEADHgyoqChE1ASNhISAxH0jg5gxq+\/FX1A009PTM93T8OiuX7\/q1f+\/+tevqqoCTyKRWBmNRo8Cj4GPwF++I5HII7zT8Xh8eZWTTzgcnh6Lxc5j8kFgHMgCT4G7wBPgl8j\/YBGnfT7f1LJJg8HgQrGQE3diAXVciK5DIsi3o7+devh+4Pf755dMmslkpmGih0LaiHa1hf5k6J0T\/TYrfdMHKz8pFjTr1kFWD9ltvJ8Bt\/Dt1d0rYeG4Y7ZJMbAG+A300HLKuHkw2SuxKAe8lQ3Gdjv6llLP4\/FMQfs1MMBQ2SUOyaoPihur0X4BDGEDHVGLYbwhawCG6QG6W6yu43jo+uwSt3IyWLlA2vt09+F7CwlDodAaaZ+Q\/j3inZn0GENil\/gd0Ke1rwEjgUBgDqzYIe4lBiBbkkqlZov7r2hjXtLldom\/0LVa+x7QK9+NGjHduUvkfcAdbUwb0G+XuNtg8WV6QeLXbCDeKzo9QJM2phPosEt8ExijG9nG5NuKJK6VTTeXrofudbvEh2TS49r\/eakQMeQXNV2v9Nfbzc9c8U\/GWv2LKkmYEat+r9c7Q+L9nZvOdhLBhOF86c+MWJ5JkLVIX6jUdM1Jbsgk3NU1RRBPHCzQ2crxZR0U3CBC8saKGO3NCNNGx85kpk4QPLfaXJr8jGPkKs4FfqesJv9kcP1OvFeXa70Z8Ygmz1KWTCYX4fuDqlAQhnUVIWafQfesXjjgF5zlCrGWSBQuyOm1nuEARqGTqRgxKxejrm1iYL+URKPFEktJrGSDpRJ3aYlGYRhFwjK8T+lyle+1yrUsYjMM5ZG9l0tBzk3iYvGfWE6XVWYniyvEci1RgjEpZwP6Itwi7jfppHy31Mz3HSeGNZvw8aOAUs5h0olUqqqPFVIhjlcI34wXsMMuWWhEb76ibwPw1U1ibmCzwm+tdil3HEyfhcrdBhetbrW6pHe5RNxiVeTXukTcVEyevupCjA9YEqfT6XlyGXOKuINnQ1GnEy9y6uJeBuFn3qXxxyzmnP8Amz0wy7TM4YgAAAAASUVORK5CYII=","width":19}
%---
%[control:dropdown:7bd4]
%   data: {"defaultValue":"1e5","itemLabels":["1e2","1e3","1e4","1e5","1e6","1e7","1e8"],"items":["1e2","1e3","1e4","1e5","1e6","1e7","1e8"],"label":"numSteps","run":"Section"}
%---
%[text:image:6062]
%   data: {"align":"baseline","height":24,"src":"data:image\/png;base64,iVBORw0KGgoAAAANSUhEUgAAACgAAAAsCAYAAAAXb\/p7AAADlklEQVR42u1YS0hUYRQejR4UvR+SvaCyWiS2DIoCKWjVYzG2SsYWQ+a8HRwXFkOgqdGLSoSeqyBaJUGLCKGkNpGtgiyScnpYBpaU5au+E+eH03Wu93rvP2OEFw46955z\/u8\/7\/\/3eDQ+4XD4Eui65199AK4d1DEJcBLgfw0wGo2ujkQi1yoqKlY5AFgDqnWw5lpaMxaLrbBkDgaDm7HIEKjTCcjxPqFQqABrdYEGsHaRXaESCAyCXpNFMwwuReDw\/77xusurQGJna0ysPR2K94CnGdQKesnUyu92J5PJaelk4c51Chzcu9dp0O9nkO3yvd\/vnwqlEbzvAf2yoB5sIkwyBt0doJ+0Qbdu2AXyC8UrOVuNQH5Q3IJegfrTfH8ikwC\/A9hjsdaYCQQCG6D4vVj0DShB7+HKXMGaQ\/EFADEGrPhJdn1GAhoZvRDKX4jFTvt8vhlWchSD4D0OGiE5AH9eXl4+PxNF+IoCB8sccyBfreQB8qJWcAC0CYqHeYE2cqEDNTmQvcc6hlC+CnXWq\/PCtTtdeGGr0HNWFz7aeTcr\/eT1eqe41PVWJYxd62zkovwXqQ6Cv8vErm9r8MZNEctLVf9Ph4GwecSOjPSQu8V28e6chmRrFPq28btHJhhSBKDIBH0B726HEDilAWCtsGCx6MmjMNgaHqBkiygPl3UmHE1OrjOEiqoqsqDHGizYxrqGAXCOriL9jJUOoq3lO9UDQItpQGD3PtXZRapFHB51oSchwiWsDWA8Hl8Cpb2svA+WWO4AXJ7Q0Z1IJObq7sUBN\/UQLr0hrHfANSCaQihrobiBf+dC+QOxSNk4MrdEyN1VvRy6T+DdVbOp2wpcCyutN8yDahjtVZ3A4sS2ALwflYxhaK1n0C22QfL8dkuNRYZBlKxxRLj6gg3XNgj+w8beLOriHcv50gocJ8wsfP\/ASgfMDlRs8XzwfGPeThMr2QcpEqFprJmPSoSwSvMYfCcFX6nFlNPEfAGrUuC1GkhxQpspTnTfKysrFxl5qqqqZouy0mU81ZmApB6cp2vKlrFVk+Z7TGRuPOsXRZSNfGYmEO\/ofoXmOiKKS3Ga6wPYeRNxk9Vo49BONAIL1mUdIBa9bxPgn+zMOkAqIXDdQbp1sKAy6uWeyWd0Cyuk5LDh3pTtez\/NSVJqNwbh5kNZB8htkTrP1zHA9dM1nZ07nExmc50ZQGA7M+GxyLden9MA\/OLm\/KKe34xPoKAD7jPkAAAAAElFTkSuQmCC","width":22}
%---
%[text:image:1282]
%   data: {"align":"baseline","height":24,"src":"data:image\/png;base64,iVBORw0KGgoAAAANSUhEUgAAACgAAAAsCAYAAAAXb\/p7AAADlklEQVR42u1YS0hUYRQejR4UvR+SvaCyWiS2DIoCKWjVYzG2SsYWQ+a8HRwXFkOgqdGLSoSeqyBaJUGLCKGkNpGtgiyScnpYBpaU5au+E+eH03Wu93rvP2OEFw46955z\/u8\/7\/\/3eDQ+4XD4Eui65199AK4d1DEJcBLgfw0wGo2ujkQi1yoqKlY5AFgDqnWw5lpaMxaLrbBkDgaDm7HIEKjTCcjxPqFQqABrdYEGsHaRXaESCAyCXpNFMwwuReDw\/77xusurQGJna0ysPR2K94CnGdQKesnUyu92J5PJaelk4c51Chzcu9dp0O9nkO3yvd\/vnwqlEbzvAf2yoB5sIkwyBt0doJ+0Qbdu2AXyC8UrOVuNQH5Q3IJegfrTfH8ikwC\/A9hjsdaYCQQCG6D4vVj0DShB7+HKXMGaQ\/EFADEGrPhJdn1GAhoZvRDKX4jFTvt8vhlWchSD4D0OGiE5AH9eXl4+PxNF+IoCB8sccyBfreQB8qJWcAC0CYqHeYE2cqEDNTmQvcc6hlC+CnXWq\/PCtTtdeGGr0HNWFz7aeTcr\/eT1eqe41PVWJYxd62zkovwXqQ6Cv8vErm9r8MZNEctLVf9Ph4GwecSOjPSQu8V28e6chmRrFPq28btHJhhSBKDIBH0B726HEDilAWCtsGCx6MmjMNgaHqBkiygPl3UmHE1OrjOEiqoqsqDHGizYxrqGAXCOriL9jJUOoq3lO9UDQItpQGD3PtXZRapFHB51oSchwiWsDWA8Hl8Cpb2svA+WWO4AXJ7Q0Z1IJObq7sUBN\/UQLr0hrHfANSCaQihrobiBf+dC+QOxSNk4MrdEyN1VvRy6T+DdVbOp2wpcCyutN8yDahjtVZ3A4sS2ALwflYxhaK1n0C22QfL8dkuNRYZBlKxxRLj6gg3XNgj+w8beLOriHcv50gocJ8wsfP\/ASgfMDlRs8XzwfGPeThMr2QcpEqFprJmPSoSwSvMYfCcFX6nFlNPEfAGrUuC1GkhxQpspTnTfKysrFxl5qqqqZouy0mU81ZmApB6cp2vKlrFVk+Z7TGRuPOsXRZSNfGYmEO\/ofoXmOiKKS3Ga6wPYeRNxk9Vo49BONAIL1mUdIBa9bxPgn+zMOkAqIXDdQbp1sKAy6uWeyWd0Cyuk5LDh3pTtez\/NSVJqNwbh5kNZB8htkTrP1zHA9dM1nZ07nExmc50ZQGA7M+GxyLden9MA\/OLm\/KKe34xPoKAD7jPkAAAAAElFTkSuQmCC","width":22}
%---
%[output:89a30e6c]
%   data: {"dataType":"symbolic","outputData":{"name":"ySol(t)","value":"$$ 2\\,\\mathrm{atan}\\left({\\mathrm{e}}^{\\frac{t^2 }{2}+\\log \\left(\\tan \\left(\\frac{1}{2}\\right)\\right)} \\right) $$"}}
%---
%[output:14af296e]
%   data: {"dataType":"symbolic","outputData":{"name":"ySol(t)","value":"$$ 2\\,\\mathrm{atan}\\left({\\mathrm{e}}^{\\frac{t^2 }{2}+\\log \\left(\\tan \\left(\\frac{1}{2}\\right)\\right)} \\right) $$"}}
%---
%[output:691451ec]
%   data: {"dataType":"text","outputData":{"text":"Calculating with 0.1...\nCalculating with 0.01...\nCalculating with 0.001...\nCalculating with 0.0001...\nCalculating with 1e-05...\nCalculating with 1e-06...\nCalculating with 1e-07...\nCalculating with 1e-08...\nCalculating with 1e-09...\n","truncated":false}}
%---
%[output:1aa9d86f]
%   data: {"dataType":"matrix","outputData":{"columns":1,"name":"yErr","rows":9,"type":"double","value":[["0.0542"],["0.0055"],["0.0005"],["0.0001"],["0.0000"],["0.0000"],["0.0000"],["0.0000"],["-0.0000"]]}}
%---
%[output:68dd1868]
%   data: {"dataType":"matrix","outputData":{"columns":1,"name":"ratio","rows":9,"type":"double","value":[["NaN"],["0.1006"],["0.1000"],["0.1000"],["0.1000"],["0.1000"],["0.1001"],["0.0913"],["-0.0122"]]}}
%---
%[output:2ccb8d90]
%   data: {"dataType":"tabular","outputData":{"columnNames":["h","Error at tEnd=1","Ratio","Estimated Order"],"columns":4,"dataTypes":["double","double","double","double"],"header":"9×4 table","name":"T","rows":9,"type":"table","value":[["0.100000000000000","0.054191147246600","NaN","NaN + 0.000000000000000i"],["0.010000000000000","0.005452253013084","0.100611507416019","0.997352344116404 + 0.000000000000000i"],["1.000000000000000e-03","5.454565690130586e-04","0.100042416906208","0.999815824774902 + 0.000000000000000i"],["1.000000000000000e-04","5.454786466341233e-05","0.100004047548846","0.999982422074445 + 0.000000000000000i"],["1.000000000000000e-05","5.454808747584750e-06","0.100000408471416","0.999998226034803 + 0.000000000000000i"],["1.000000000000000e-06","5.454814944183539e-07","0.100000113598828","0.999999506646840 + 0.000000000000000i"],["1.000000000000000e-07","5.460381613531240e-08","0.100102050562753","0.999557026027502 + 0.000000000000000i"],["1.000000000000000e-08","4.987495083597082e-09","0.091339679835521","1.039340515018380 + 0.000000000000000i"],["1.000000000000000e-09","-6.064437840791470e-11","-0.012159285852203","1.915091931605656 - 1.364376353841841i"]]}}
%---
