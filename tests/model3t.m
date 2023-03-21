function dydt = model3t(t,y,L,g,M,b,c)
theta = y(1);
omega = y(2);
if omega < 0
    c = -c;
end
dydt = [omega; ...
    (-g*M*L*sin(theta)-b*omega-c*omega^2)/(M*L^2)];
end