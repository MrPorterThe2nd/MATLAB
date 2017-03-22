%%Consts Beam Bending

function y=step_sf(x,a)
y = (x>a);

function y=lin_sf(x,a)
y = (x-a).*(x>a);

function y =quad_sf(x,a)
y = ((x-a).^2).*(x>a); 

function y=cubic_sf(x,a)
y=((x-a).^3).*(x > a);

%%Put parameters off beam here
C1=0;
C2 = 0;
Fa = 1490;
Fb = -1280;
Fc = 3295;
w = 20.3216;
C3 = -23024821;
E = 30e6;
I = 13.1;
b = 116.25;
c = 136.25;

V = Fa*step_sf(x,0)-w*lin_sf(x,0)+Fb*step(x,b)+Fc*step(x,c);

plot(x,V)

