
%% Initialize Parameters for Iteration

M = 1;      %% x-length
N = 1;      %% y-length
n = 100;    %% for desired 0.01 step
h = N/(N*n);    %% x-step 
k = M/(M*n);    %% y-step
Re = 100;         %%Reynolds Number (Increase for Solutions)

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

%% Remember
%j=row
%i=column

%% Solve
for d=1:10000
 
    for column=2:n-1
    zeta(column,1)=-2*(psi(column,n-1)/k^2);  %bottom wall
    zeta(column,n*M)=-2*(u(1,column)/k)+-2*psi(column,n-1)/k^2;     %top wall (u matrix has ones along top)
end

for row=2:n-1
    zeta(1,row)= -2*(psi(2,row))/h^2;               %left wall
    zeta(n,row)= -2*(psi(n-1,row))/h^2;               %right wall
end
    
    for j=2:n-1       
        for i=2:n-1
            zeta(j,i) = 0.25*h*h*((zeta(j,i+1)+zeta(j,i-1))/(h*h)+(zeta(j+1,i)+zeta(j-1,i))/(h*h)...
                        -Re*(psi(j+1,i)-psi(j-1,i))/(4*h*h)...
                        +Re*(psi(j,i+1)-psi(j,i-1))/(4*h*h));
                
            psi(j,i) = 1/(2*(1/h^2+1/h^2))*(zeta(j,i)+(psi(j,i+1)+psi(j,i-1))/h^2+(psi(j+1,i) ...
                        +psi(j-1,i))/h^2);
        end
    end 
    
    %{
    rearrange in cartesian coordinate 
    (which originally in matrix coordinate)
    for i=1:n
        for j=1:n
            k=i; l=j;
            Psi(l,k)=psi(i,j);
            Zeta(l,k)=zeta(i,j);
            uact(l,k)=u(i,j);
            vact(l,k)=v(i,j);
        end
    end
    
    figure(1)% Streamline plot with number
    Z = Psi(1:n,1:n); 
    X = linspace(0,1,size(Z,2));
    Y = linspace(0,1,size(Z,1));
    contour(X,Y,Z),xlabel('X'),ylabel('Y'),title('Stream Function');
    axis equal, axis([0 1 0 1]), drawnow
    %}
    
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

