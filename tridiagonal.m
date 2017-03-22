% implementation of Gaussian elimination for a tridiagonal system (p. 146)
function [L,U,x] = tridiagonal(A,n)

for i = 2:n % decomposition phase
    A(i,1) = A(i,1)/A(i-1,2);
    A(i,2) = A(i,2) - A(i,1) * A(i-1,3);
    A(i,4) = A(i,4) - A(i,1) * A(i-1,4);
end

% back substitution
A(n,4) = A(n,4) / A(n,2);
for i = (n-1):-1:1
    A(i,4) = (A(i,4) - A(i,3) * A(i+1,4))/A(i,2);
end

% disp(A)

for i = 1:n
    x(i) = A(i,4);
    for j = 1:n
        if i == j
            L(i,j) = 1;
            U(i,j) = A(i,2);
        elseif i == j + 1
                L(i,j) = A(i,1);
        elseif i == j - 1
            U(i,j) = A(i,3);
        end
    end
end

x = x'; % transpose
% disp(L)
% disp(U)
% disp(x)