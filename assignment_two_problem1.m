
%% Initialize
clear
clc

L = 2;
H = 1;
n = 50;
h = H/(H*n);
k =L/(L*n); 
jacobian_count = 0;
gauss_count = 0;
SOR_count = 0;
error_J = 1;
error_GS = 1;
error_SOR = 1;
tolerance = 0.9;
gamma = (h^2)/(k^2);
omega_optimal = 1.65;
rel_J = zeros(n*H,n*L);
rel_GS = zeros(n*H,n*L);
rel_SOR = zeros(n*H,n*L);

u = zeros(n*H,n*L);
%initialize the domain boundary conditions
for row=1:n*H
   u(row,1) = 50;
   u(row,n*L) = 25;
end

for column=2:n*L
    x = column/n;
    u(1,column) = 50-12.5*(x);
    u(n*H,column) = -4*(x^2)-4.5*x+50;
end
%develop domains for all iterations
u_1 = u;
u_2 = u;
u_3 = u;
u_J = u;
u_GS = u;
u_SOR = u;
disp('2. starting Jacobian');
%% JACOBIAN
while error_J > tolerance
    jacobian_count = jacobian_count + 1;
    for j1 = 2:n*H-1
        for i1 = 2:n*L-1
            u_J(j1,i1)=(1/(2*(1+gamma)))*(u_1(j1+1,i1)+u_1(j1-1,i1)+u_1(j1,i1+1)+u_1(j1,i1-1)); %interior nodes
            rel_J(j1,i1) = (u_J(j1,i1)-u_1(j1,i1))/(u_J(j1,i1)); %relative error check
        end
    end
    max_J(jacobian_count,1) = max(max(rel_J)); %create a matrix of max relative errors for plot
    error_J = sqrt(sum(sum((u_J-u_1).^2))); %error to check convergence
    if (error_J < tolerance) %allows last two iterates to be seen at the end for comparison
        break
    end
    u_1 = u_J;
end

%% GAUSS-SEIDEL
while error_GS > tolerance
    gauss_count = gauss_count + 1;
    for j2=2:n*H-1
        for i2=2:n*L-1
            u_GS(j2,i2)=(1/(2*(1+gamma)))*(u_2(j2 +1,i2)+u_GS(j2 -1,i2)+u_2(j2,i2+1)+u_GS(j2,i2 -1));
            rel_GS(j2,i2) = (u_GS(j2,i2)-u_2(j2,i2))/(u_GS(j2,i2));
        end
    end
    max_GS(gauss_count,1) = max(max(rel_GS));
    error_GS = sqrt(sum(sum((u_GS-u_2).^2)));
    if (error_GS < tolerance)
       break
    end
    u_2 = u_GS;
end

%% GAUSS-SEIDEL w/ SOR

while error_SOR > tolerance
    SOR_count = SOR_count + 1;
    for j3 = 2:n*H-1
        for i3 = 2:n*L-1
            u_SOR(j3,i3)=(1/(2*(1+gamma)))*(u_3(j3+1,i3)+u_SOR(j3-1,i3)+u_3(j3,i3+1)+u_SOR(j3,i3-1));
            u_SOR(j3,i3) = omega_optimal*u_SOR(j3,i3) + (1-omega_optimal)*u_3(j3,i3); %relaxation parameter
            rel_SOR(j3,i3) = (u_SOR(j3,i3)-u_3(j3,i3))/(u_SOR(j3,i3));
        end
    end
    max_SOR(SOR_count,1) = max(max(rel_SOR));
    error_SOR = sqrt(sum(sum((u_SOR-u_3).^2)));
    if (error_SOR < tolerance)
        break
    end
    u_3 = u_SOR;
end
