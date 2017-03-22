
%% Initialize Parameters for Iteration

M = 1;      %% x-length
N = 1;      %% y-length
n = 100;    %% for desired 0.01 step
h = N/(N*n);    %% x-step 
k = M/(M*n);    %% y-step
Re = 1;         %%Reynolds Number (Increase for Solutions)

%% Initialize Matrices for Solution
u = zeros(n*N,n*M);
v = zeros(n*N,n*M);
psi = zeros(n*N,n*M);
zeta = zeros(n*N,n*M);

epsi = zeros(n*N,n*M);      %Grab previous iteration value for error comparison
pzeta = zeros(n*N,n*M);

%% Initial boundary conditions
for col=1:n
    u(1,col) = 1;    %top velocity condition
end

for column=2:n-1
    zeta(column,1)=-2*(psi(column,n-1)/k^2);  %bottom wall
    zeta(column,n*M)=-2*(u(1,column)/k)+-2*psi(column,n-1)/k^2;     %top wall (u matrix has ones along top)
end

for row=2:n-1
    zeta(1,row)= -2*(psi(2,row))/h^2;               %left wall
    zeta(n,row)= -2*(psi(n-1,row))/h^2;               %right wall
end

%% Remember
%j=row
%i=column

%% Solve
for d=1:10000
 
    for j=2:n-1       
        for i=2:n-1
            zeta(j,i)= -0.25*Re*h*((psi(j,i+1)-psi(j,i-1)))*((zeta(j+1,i)-zeta(j-1,i)))+...
            ((psi(j+1,i)-psi(j-1,i)))*((zeta(j,i+1)-zeta(j,i-1)))+...
            0.25*(zeta(j+1,i)+zeta(j-1,i)+zeta(j,i+1)+zeta(j,i-1)); %zeta Solve
                
            psi(i,j) = 1/(2*(1/h^2+1/h^2))*(zeta1(i,j)+(psi(i+1,j)+psi(i-1,j))/h^2+(psi(i,j+1) ...
                        +psi(i,j-1))/h^2);
        end
    end   
end

%% Find Velocities

for j3=2:n-1
    for i3=2:n-1
        u(j3,i3) = (psi(j3,i3+1)-psi(j3,i3-1))/2/h;
        v(j3,i3) = (psi(j3+1,i3)-psi(j3-1,i3))/2/h;
    end
end

%% Present Results

figure(01);
contour(psi);
figure(02);
quiver(v,u);
figure(03);
contour(zeta);

