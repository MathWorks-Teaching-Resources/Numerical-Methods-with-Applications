function dydt = model2t(t,y,L,g)
theta = y(1);
omega = y(2);
dydt = [omega; ...
    -g/L*sin(theta)];
end