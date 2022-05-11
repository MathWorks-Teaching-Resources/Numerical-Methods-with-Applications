# Numerical Methods with Applications 
[![View Numerical-Methods-with-Applications on File Exchange](https://www.mathworks.com/matlabcentral/images/matlab-file-exchange.svg)](https://www.mathworks.com/matlabcentral/fileexchange/111490-numerical-methods-with-applications)
**Curriculum Module**  
_Created with R2021b. Compatible with R2021b and later releases._ 

## Description ##
This curriculum module contains interactive [live scripts](https://www.mathworks.com/products/matlab/live-editor.html) that teach fundamental concepts and basic terminology related to designing and implementing numerical methods related to interpolation, numerical integration and differentiation, and numerical solutions to ordinary and partial differential equations.

These live scripts can be used as part of a lecture, as activities in an instructional setting, or as interactive assignments to be completed outside of class.

Get started with the Numerical Methods with Applications interactive examples by downloading and unzipping the repository. Then, double-click the NumericalMethods.prj file inside MATLAB&reg;. From there, you can follow the landing page instructions to get started with the examples. The instructions inside the live scripts will guide you through the exercises and activities. Get started with each live script by running it one section at a time. To stop running the script or a section midway (for example, if a loop is running longer than intended), click the **Stop** button in the **RUN** section of the **Live Editor** tab in the MATLAB Toolstrip.

## Prerequisite Domain Knowledge ##
This module assumes familiarity with basic programming concepts such as floating-point doubles and strings, structures including constants, vectors, matrices, arrays, control flows including if/else, for loops, and while loops, and how to use them in MATLAB. These ideas are all presented with interactive examples in [Fundamentals of Programming](https://www.mathworks.com/matlabcentral/fileexchange/103225-fundamentals-of-programming). This module assumes familiarity with polynomials, derivatives, and integrals. To use the partial differential equation scripts, a student must be familiar with the concepts of partial derivatives and multivariable functions. These scripts do not assume knowledge of analytic solutions to ordinary or partial differential equations. 

## Details ##
**NavigationOverview.mlx**
This script brings together links and short descriptions of the content in the recommended order of use.

## ##
**Interpolation**
This folder includes the interactive example script `interpolation.mlx` that guides students through building their own data set(s) using `hand.mlx` and writing their own linear interpolation function and piecewise cubic Hermite interpolation function. The laboratory script `trackStorms.mlx` allows students to apply the scripts they have created to interpolate the paths of tropical cyclones from NOAA data. 

<img src="https://user-images.githubusercontent.com/88841524/162816985-0db8f5b1-ab50-4964-bf05-26cb8518fd08.png" width="350"> <img src="https://user-images.githubusercontent.com/88841524/162816939-c8e32e8a-9973-4c43-93e7-55b6a4934ccb.png" width="450"> 

**Learning Goals:**
- Define interpolation and explain how it is different from regression and extrapolation.
- Demonstrate multiple solutions to an interpolation problem, even when interpolating by polynomials.

## ##
**Derivatives**
This folder includes the interactive example script `approximatingDerivatives.mlx` that introduces the method of Taylor series approximation to create and analyze numerical approximations to derivatives of different orders.

<img src="https://user-images.githubusercontent.com/88841524/162816959-45133265-2918-4bb3-a45a-288b487a8a5b.png" width="500">

**Learning Goals:**
- Determine numerical derivative approximations formulas.
- Use Taylor's theorem to calculate the order of the error for a numerical approximation to a derivative.
- Demonstrate how numerical derivatives can magnify approximation errors. 

## ##
**Integrals**
This folder includes the interactive example script `numericalIntegration.mlx` that guides students through building functions to compute forward and backward Euler method approximations, a 2-point Gaussian approximation, and a Simpson's rule approximation. The laboratory script `measureLake.mlx` presents two maps of a lake from different points in time and guides students through collecting data and realizing the complexities of numerically integrating from data.

<img src="https://user-images.githubusercontent.com/88841524/162817001-9b06a4d4-c135-4922-acde-62aae705958a.png" width="400">
<img src="https://user-images.githubusercontent.com/88841524/162817010-eefa8b73-c787-4f20-9f62-5cdac6e66c19.png"
 width="400">

**Learning Goals:**
- Implement Euler's method, Gaussian 2-point approximations, and Simpson's rule for numerical integration.
- Explain why higher-order approximations may not be appropriate in applications.

## ##
**Ordinary Differential Equations**
This folder includes the interactive example script `diffEqs.mlx` that guides students through implementing an Euler method solver and a four-step Runge-Kutta method solver, and comparing the results of their implementations to the built-in solver `ode45`. The laboratory script `pendulum.mlx` offers students a chance to apply numerical solution methods to create increasingly more realistic models of a simple pendulum. 

<img src="https://user-images.githubusercontent.com/88841524/162816991-740d32bf-0c73-48eb-8a1b-7be600901669.png" width="400"> <img src="https://user-images.githubusercontent.com/88841524/162816951-013a06cd-8aac-4696-9e59-6346fb87983d.png" width="400">

**Learning Goals:**
- Implement Euler's method for first-order initial value problems.
- Implement a four-step Runge-Kutta method.

## ##
**Partial Differential Equations**
This folder includes the interactive example script `partialDiffEqs.mlx` that guides students through an exploration of explicit, implicit, and mixed methods for numerically solving first-order ordinary differential equations. The activity script `implementExplicitSolver.mlx` provides scaffolded checks of each component required for creating `explicitPDE.m` to solve a first-order 1-D heat equation. The rest of `partialDiffEqs.mlx` builds upon `explictPDE.m` to create a related implicit method solver, a Crank-Nicolson solver, and a combined method solver. 

<img src="https://user-images.githubusercontent.com/88841524/162998892-d5ec6d99-ca37-4969-b841-8c7c87c850f9.gif" width="500">

**Learning Goals:**
- Identify errors from discretizing the problem and from discretizing the method and choose appropriate parameters to minimize overall error.
- Explain the importance of stability when choosing a numerical method.
- Implement explicit, implicit, and Crank-Nicolson methods to solve a 1-D heat equation.

## Products ##
MATLAB&reg;, Symbolic Math Toolbox&trade;, Statistics and Machine Learning Toolbox&trade;, Curve Fitting Toolbox&trade;, Automated Driving Toolbox&trade;

## License ##
The license for this module is available in the [LICENSE.TXT](license.txt) file in this GitHub repository.

## Support ##
Have any questions or feedback? Contact the <a href="mailto:onlineteaching@mathworks.com">MathWorks online teaching team.</a>

# #
_Copyright 2022 The MathWorks, Inc._
