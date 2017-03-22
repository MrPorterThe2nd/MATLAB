qsource = 5e6;
k = 25;
t = 50e-6;

theta = linspace(0,(pi/2-0.0001),50);

h = 26 + theta.*0.637 - 8.92.*theta.*theta;

ts = tinf + qsource.*t./h;

theta = linspace(0,pi,100);

h = ones(1,50).*5;

ts1 = tinf + qsource.*t./h;

t = [ ts, ts1]

plot (theta,t)
ylabel('T(C)')
xlabel('theta (rad)')