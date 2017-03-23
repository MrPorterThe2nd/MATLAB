%% Workspace Setup
clear
clf
clc

%% Inital Parameters
N=51;  
M=51; 
h=0.1;

U=1;
Re= 1; 
iteration_max = 1000;


%% Initialize Matrices

psi1(1:N,1:M)=0; 
zeta1(1:N,1:M)=0;
Psi(1:N,1:M)=0;
Zeta(1:N,1:M)=0;
uact(1:N,1:M)=0;
vact(1:N,1:M)=0;
u(1:N,1:M)=0;
v(1:N,1:M)=0;
u(1:N,M)=1;

%% Iterate through nodes

for iteration =1:iteration_max

    disp(['iteration= ',int2str(iteration)]) 
        
    % Update stream function(internal nodes)
    for i=2:(N-1)
        for j=2:(M-1)
            psi1(i,j) = 1/(2*(1/h^2+1/h^2))*(zeta1(i,j)+(psi1(i+1,j)+psi1(i-1,j))/h^2+(psi1(i,j+1) ...
                        +psi1(i,j-1))/h^2);
           
        end
    end

    % Vorticity (Boundary nodes)
    for j=1:M 
        for i=1:N
        %left side
        zeta1(1,j) = -2*psi1(2,j)/h^2;
        %right side
        zeta1(N,j) = -2*psi1(N-1,j)/h^2; %right side(CD)
        %bottom
        zeta1(i,1)= -2*psi1(i,2)/h^2; 
        %top
        zeta1(i,M)= -(2*psi1(i,M-1)+2*U*h)/h^2;
        end
    end

   

    %vorticity internal nodes 
       

    for i=2:(N-1)
        for j=2:(M-1)
            
%             Zx = (zeta1(i+1,j)-zeta1(i-1,j));
%             Zy = (zeta1(i,j+1)-zeta1(i,j-1));

             if (psi1(i,j+1)-psi1(i,j-1)) >= 0
                Zx = (zeta1(i,j)-zeta1(i-1,j));
             end
             
             if (psi1(i,j+1)-psi1(i,j-1)) < 0
                Zx = (zeta1(i+1,j)-zeta1(i,j));
             end
             
             if (psi1(i+1,j)-psi1(i-1,j)) >= 0
                Zy = (zeta1(i,j)-zeta1(i,j-1));
             end
             
             if (psi1(i+1,j)-psi1(i-1,j)) < 0
                Zy = (zeta1(i,j+1)-zeta1(i,j));
             end

            zeta1(i,j) = 0.25*h*h*((zeta1(i+1,j)+zeta1(i-1,j))/(h*h)+(zeta1(i,j+1)+zeta1(i,j-1))/(h*h) ...
                        -Re*(psi1(i,j+1)-psi1(i,j-1))*Zx/(4*h*h)...
                        +Re*(psi1(i+1,j)-psi1(i-1,j))*Zy/(4*h*h));
        end
    end

    % Calculate the velocity (u and v)

    for i=2:(N-1)
        for j=2:(M-1)
            u(i,j) = (psi1(i,j+1)-psi1(i,j-1))/(2*h);
            v(i,j) = -(psi1(i+1,j)-psi1(i-1,j))/(2*h);
        end
    end

    % rearrange in cartesian coordinate 
    %(which originally in matrix coordinate)
    for i=1:N
        for j=1:M
            k=i; l=j;
            Psi(l,k)=psi1(i,j);
            Zeta(l,k)=zeta1(i,j);
            uact(l,k)=u(i,j);
            vact(l,k)=v(i,j);
        end
    end
    
    figure(1)% Streamline plot with number
    Z = Psi(1:M,1:N); 
    X = linspace(0,1,size(Z,2));
    Y = linspace(0,1,size(Z,1));
    contour(X,Y,Z),xlabel('X'),ylabel('Y'),title('Stream Function');
    axis equal, axis([0 1 0 1]), drawnow
            
end

figure('Name','Stream Function');
contour(Psi),xlabel('N'),ylabel('M'),title('Stream Function');axis('square','tight');colorbar

figure('Name','Vorticity');
contour(Zeta),xlabel('N'),ylabel('M'),title('Vorticity');axis('square','tight');colorbar

figure('Name','Velocity Profile');
quiver(uact,vact), xlabel('N'),ylabel('M'),title('Velocity Distribution');axis('square','tight');colorbar


