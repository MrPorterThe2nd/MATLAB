n = 50; %mesh size
xi = 1/n;

A = zeros(n-1); %Initialize a Matrix

%Add Finite Difference
for i = 1:n
A(i,i) = 2;
end

for i = 1:n-1
A(i,i+1) = -1;
A(i+1,i) = -1;
end

%Boundary Conditions
b = zeros(n,1);
%Initial Boundary Conidtion
u0 = 1;
b(1) = u0;
%convective tip ot be solve in forward substitution

%decomposition
for j = 2:n-1
A(j,j-1) = A(j,j-1)/A(j-1,j-1);
A(j,j) = A(j,j)-A(j,j-1)*A(j-1,j);
end

%forward substitution
for j = 2:n
b(j,1) = b(j,1) - A(j,j-1)*b(j-1,1);
end
%convective tip solved during forward substitution
b(n) = b(n)-b(n-1)+0.3*b(n)/xi;

%back substitution
sol = zeros(n,1);

%robin Boundary Condition
sol(n) = b(n)/A(n,n);

%back substitution
for j = n-1:-1:1
sol(j,1) = (b(j,1)- A(j,j+1)*sol(j+1,1))/A(j,j);
end

