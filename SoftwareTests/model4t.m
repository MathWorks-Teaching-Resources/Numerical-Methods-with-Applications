function dydt = model4t(t,y,L,g,M,m,b,c)
theta = y(1);
omega = y(2);
if omega < 0
    c = -c;
end
rotInertia = m*L^2/3+M*L^2;
dydt = [omega; ...
    (-g*(M*L+m*L/2)*sin(theta)-b*omega-c*omega^2)/rotInertia];
end