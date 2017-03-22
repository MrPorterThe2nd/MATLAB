
%% Initialize
clear
clc

L = 2;
H = 1;
n = 50;
h = H/(H*n);
k =L/(L*n); 
SOR_count = 0;
error_J = 1;
error_GS = 1;
error_SOR = 1;
tolerance = 0.9;
gamma = (h^2)/(k^2);
omega_optimal = 1.65;
rel_SOR = zeros(n*H,n*L);
Bi = 0.25;
u_inf = 0;

u = zeros(n*H,n*L);

for row=1:n*H
   u(row,1) = 50;
   
end

for column=2:n*L
    x = column/n;
    u(1,column) = 50-12.5*(x);
    u(n*H,column) = -4*(x^2)-4.5*x+50;
end

u_3 = u;
u_SOR = u;


%% GAUSS-SEIDEL w/ SOR

while error_SOR > tolerance
    SOR_count = SOR_count + 1;
    for j3 = 2:n*H-1
        for i3 = 2:n*L-1
            u_SOR(j3,i3)=(1/(2*(1+gamma)))*(u_3(j3+1,i3)+u_SOR(j3-1,i3)+ gamma*u_3(j3,i3+1)+gamma*u_SOR(j3,i3-1));
            u_SOR(j3,i3) = omega_optimal*u_SOR(j3,i3) + (1-omega_optimal)*u_3(j3,i3);
            rel_SOR(j3,i3) = (u_SOR(j3,i3)-u_3(j3,i3))/(u_SOR(j3,i3));
        end
    end
    for j3 = 2:n*H
        u_SOR(j3,n*L) = (1/(2+2*gamma+2*h*Bi))*(2*u_SOR(j3-1,i3) + 2*h*Bi*u_inf + gamma*(u_SOR(j3,i3+1) + u_SOR(j3,i3-1)));
        u_SOR(j3,n*L) = omega_optimal*u_SOR(j3,n*L) + (1-omega_optimal)*u_3(j3,n*L);
        rel_SOR(j3,n*L) = (u_SOR(j3,n*L)-u_3(j3,n*L))/(u_SOR(j3,n*L));
    end
    
    max_SOR(SOR_count,1) = max(max(rel_SOR));
    error_SOR = sqrt(sum(sum((u_SOR-u_3).^2)));
    u_3 = u_SOR;
end
