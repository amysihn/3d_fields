
%Read in E(z,y,x) field data and reorder index to (z,x,y)
ExR = h5read('E_Real.h5','/data/200/fields/E_Real/x');
EyR = h5read('E_Real.h5','/data/200/fields/E_Real/y');
EzR = h5read('E_Real.h5','/data/200/fields/E_Real/z');
%% 
ExR = permute(ExR,[1 3 2]);
EyR = permute(EyR,[1 3 2]);
EzR = permute(EzR,[1 3 2]);

%% 

%Read in grid spacing and create 2D Cartesian grid in (x,y)
gridsp = h5readatt('E_Real.h5','/data/200/fields/E_Real','gridSpacing');
offs = h5readatt('E_Real.h5','/data/200/fields/E_Real','gridGlobalOffset');
xn = size(ExR,2);	yn = size(ExR,3);	zn = size(ExR,1);
x = linspace(offs(1),offs(1)+(xn-1)*gridsp(1),xn);
y = linspace(offs(2),offs(2)+(yn-1)*gridsp(2),yn);
z = linspace(offs(3),offs(3)+(zn-1)*gridsp(3),zn);
[Y2D,X2D] = meshgrid(y,x);
% 
%% 
fontsz = 20;

%Plot real part of Ez at z = 0
surf(X2D,Y2D,squeeze(EzR(1,:,:)))
set(gca,'fontsize',fontsz,'fontname','times')
xlabel('$x\,{\rm [m]}$','interpreter','latex','fontsize',fontsz)
ylabel('$y\,{\rm [m]}$','interpreter','latex','fontsize',fontsz)
zlabel('$\Re(E_z)\,{\rm [V/m]}$','interpreter','latex','fontsize',fontsz)
title('$\Re(E_z)$ at ${z=0\,{\rm mm}}$','interpreter','latex','fontsize',fontsz)

%%
M = max(EzR, [], 'all');

%% 
% %Plot real part of Ez at z = 1 cm
% figure
% surf(X2D,Y2D,squeeze(EzR(11,:,:)))
% set(gca,'fontsize',fontsz,'fontname','times')
% xlabel('$x\,{\rm [m]}$','interpreter','latex','fontsize',fontsz)
% ylabel('$y\,{\rm [m]}$','interpreter','latex','fontsize',fontsz)
% zlabel('$\Re(E_z)\,{\rm [V/m]}$','interpreter','latex','fontsize',fontsz)
% title('$\Re(E_z)$ at ${z=10\,{\rm mm}}$','interpreter','latex','fontsize',fontsz)
% 
% %Plot real part of Ez at z = 5 cm
% figure
% surf(X2D,Y2D,squeeze(EzR(51,:,:)))
% set(gca,'fontsize',fontsz,'fontname','times')
% xlabel('$x\,{\rm [m]}$','interpreter','latex','fontsize',fontsz)
% ylabel('$y\,{\rm [m]}$','interpreter','latex','fontsize',fontsz)
% zlabel('$\Re(E_z)\,{\rm [V/m]}$','interpreter','latex','fontsize',fontsz)
% title('$\Re(E_z)$ at ${z=50\,{\rm mm}}$','interpreter','latex','fontsize',fontsz)
%

