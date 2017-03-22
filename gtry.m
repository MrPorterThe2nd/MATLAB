% Driven Cavity by Vorticity-Stream Function Method
Nx=17;
Ny=17;
MaxStep=200;
Visc=0.1;
dt=0.005;
time=0.0;
h=1.0/(Nx-1);

MaxIt=100; Beta=1.5; MaxErr=0.001; % parameters for SOR

sf=zeros(Nx,Ny); vt=zeros(Nx,Ny); vto=zeros(Nx,Ny); x=zeros(Nx,Ny); y=zeros(Nx,Ny);
for i=1:Nx,for j=1:Ny,x(i,j)=h*(i-1);y(i,j)=h*(j-1);end,end;
for istep=1:MaxStep,
 for iter=1:MaxIt, % Time loop
 vto=sf;
 for i=2:Nx-1; for j=2:Ny-1 % solve for the stream function by SOR iteration
 sf(i,j)=0.25*Beta*(sf(i+1,j)+sf(i-1,j)+sf(i,j+1)+sf(i,j-1)+h*h*vt(i,j))+(1.0-Beta)*sf(i,j);
 end; end;
 Err=0.0; for i=1:Nx; for j=1:Ny, Err=Err+abs(vto(i,j)-sf(i,j)); end; end; % check error
 if Err <= MaxErr, break, end % stop if converged
 end;
 vt(2:Nx-1,1)=-2.0*sf(2:Nx-1,2)/(h*h); % vorticity on bdrys
 vt(2:Nx-1,Ny)=-2.0*sf(2:Nx-1,Ny-1)/(h*h)-2.0/h; % top wall
 vt(1,2:Ny-1)=-2.0*sf(2,2:Ny-1)/(h*h); % right wall
 vt(Nx,2:Ny-1)=-2.0*sf(Nx-1,2:Ny-1)/(h*h); % left wall
 vto=vt;
 for i=2:Nx-1
     for j=2:Ny-1
 vt(i,j)=vt(i,j)+dt*(-0.25*((sf(i,j+1)-sf(i,j-1))*(vto(i+1,j)-vto(i-1,j))-(sf(i+1,j)-sf(i-1,j))*(vto(i,j+1)-vto(i,j-1)))/(h*h)+Visc*(vto(i+1,j)+vto(i-1,j)+vto(i,j+1)+vto(i,j-1)-4.0*vto(i,j))/(h^2) );
     end; 
 end;
 time=time+dt;
 subplot(121), contour(x,y,vt,40), axis('square');
 subplot(122), contour(x,y,sf), axis('square'); pause(0.01)
end;