function [x] = solvet(c,b,a,b)
 
n = length(b);
x = (1:n);
y = (1:n);

%Solve Tridiagonal system LUx=b;

% Step 1 : Solve Ly=b for y
y(1) = b(1);
for i=2:n
    y(i) = b(i) - a(i-1)*y(i-1);
end
 
% Step 2 : Solve Ux=y for x
x(n) = y(n)/b(n);  
for i=(n-1):-1:1
    x(i) = (y(i)-c(i)*x(i+1))/b(i);
End
