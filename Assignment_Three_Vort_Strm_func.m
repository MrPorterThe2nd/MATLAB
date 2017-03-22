%% STEP 1: Declare and Initialize Variables
x1 = 1;
y1 = 1;

del_x = 0.01;
del_y = 0.01;

N = x1/del_x;
M = y1/del_y;

h = del_x;
k = h;

tolerance = 0.01;
iteration_max = 1000;

Re = 1;
U = 1;

%% STEP 2: Initialize Stream and Vorticity Matrices to ZERO

Psi = zeros(N,M);
Zeta = zeros(N,M);
F = zeros(N,M);


%% STEP 3: Solve Boundary Conditions

%Top
Zeta(2:N-1,M) = (-(2*Psi(2:N-1,M-1)/(h*h)) - (2*U/h));
%Bottom
Zeta(2:N-1,1) = -2*Psi(2:N-1,2)/(h*h);
%Left
Zeta(1,2:M-1) = -2*Psi(2,2:M-1)/(h*h);
%Right
Zeta(N,2:M-1) = -2*Psi(N-1,2:M-1)/(h*h);

%% STEP 4: Solve Governing Equations

for iterations = 1:iteration_max
    F = Psi;
    for i = 2:N-1
        for j = 2:M-1;

            Zeta(i,j) = -0.25*h*Re*((Psi(i,j+1)-Psi(i,j-1))*(Zeta(i+1,j)-Zeta(i-1,j)) + (Psi(i+1,j)-Psi(i-1,j))*(Zeta(i,j+1)-Zeta(i,j-1))) + (0.25*(Zeta(i+1,j)+Zeta(i-1,j)+Zeta(i,j+1)+Zeta(i,j-1)));
            Psi(i,j) = 0.25*(Psi(i+1,j)+Psi(i-1,j)+Psi(i,j+1)+Psi(i,j-1)+h*h*Zeta(i,j));
        end
    end

%% STEP 5: Check Convergence & STEP 6: Conditional Check

    Error = 0;
    for i = 1:N
        for j = 1:M
            Error = Error + abs(F(i,j)-Psi(i,j));
        end
    end

    if Error <= tolerance
        break
    end
end

%% STEP 7: Calculate Velocities




%% STEP 8: Display Plots

contour(Psi);
