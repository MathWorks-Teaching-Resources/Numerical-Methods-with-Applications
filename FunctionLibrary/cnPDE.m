function u = cnPDE(f,alpha,beta,tEnd,dx,gamma,L)
% Solve the 1D heat equation u_t = gamma*u_{xx} on a rod of length L
%   using the Crank-Nicolson method
%   u(t,0) = alpha(t)
%   u(t,L) = beta(t)
%   u(0,x) = f(x)
%   The desired spatial resolution is dx
%   Output is u = u(tEnd,x_m), a vector of values on the mesh points

% %% Define dt with reference to both error and stability concerns
% Optimal step size dtOpt for stability
dtOpt = nan;

% Forcing an integer numbers of dt steps that terminate at tEnd
dt = tEnd/ceil(tEnd/dtOpt);
 
% %% Set up helper values for defining the required matrices A and B 
% %% such as the number of rows, the value of mu, etc 


% %% Define modA for the explicit updating rule 
% %% modA-I = (A-I)/2, where I is the identity matrix


% %% Define modB for the implicit updating rule 
% %% modB-I = (B-I)/2, where I is the identity matrix


% %% Initialize bAvg = b^(j)+b^(j+1) as a vector of zeros


% %% Define a spatial mesh vector xVals
xVals = [0;0;0];

% %% Set up a column vector u0 of the initial values of u when t=0
u0 = 0;
u = u0;

% %% Initialize the output to the interior points of u0 


% To visualize the outputs
p = plot(xVals,u0,"LineWidth",4);
ax = p.Parent;

% Set the y limits to reasonable fixed values
minAlpha = min(alpha(0:dt:tEnd));
maxAlpha = max(alpha(0:dt:tEnd));
minBeta = min(beta(0:dt:tEnd));
maxBeta = max(beta(0:dt:tEnd));
yLower = min([ax.YLim(1),minAlpha,minBeta]);
yUpper = max([ax.YLim(2),maxAlpha,maxBeta]);
scale = (yUpper-yLower)*0.05;
ax.YLim = [yLower-scale yUpper+scale];

% These values generate well-sized y limits for the example function 
% used in partialDiffEqs.mlx 
ylim([-4 1.5]);
title("Solving $\frac{\partial u}{\partial t} = \gamma \frac{\partial^2 u}{\partial x^2}$","Interpreter","latex")
subtitle("$t=0$","Interpreter","latex")
xlabel("$x$","Interpreter","latex")
ylabel("$u$","Interpreter","latex")

% %% Compute new values for halfB*u^(j+1)-b^(j+1) = halfA*u^(j)+b^(j)
% %% Loop over timesteps to reach tEnd
for j = 1:(tEnd/dt)
    

    % To visualize the outputs
    hold on
    delete(ax.Children(1:end-1));
    plot(xVals,[alpha(j*dt);u;beta(j*dt)],"k","LineWidth",1)
    subtitle("$t = $"+dt*j)
    drawnow
    pause(0.1)     
    hold off
    % End visualization code
end

end
