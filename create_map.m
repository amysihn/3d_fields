% Create input file
fileID = fopen('i10.txt','w');

% File header
fprintf(fileID,'3DDynamic\n'); 

fprintf(fileID, '%d\n', 187);  % Frequency in MHz
fprintf(fileID, '%d\t', -1.5, 1.5, 100);  % Nx = X-1
fprintf(fileID, '\n');
fprintf(fileID, '%d\t', -1.5, 1.5, 100);  % Ny = Y-1
fprintf(fileID, '\n');
fprintf(fileID, '%d\t', 0, 20, 200);  % Nz = Z-1
fprintf(fileID, '\n');

% Get E and B data from .h5 files
ExR = h5read('E_Real.h5','/data/200/fields/E_Real/x');
EyR = h5read('E_Real.h5','/data/200/fields/E_Real/y');
EzR = h5read('E_Real.h5','/data/200/fields/E_Real/z');

BxR = h5read('B_Real.h5','/data/200/fields/B_Real/x');
ByR = h5read('B_Real.h5','/data/200/fields/B_Real/y');
BzR = h5read('B_Real.h5','/data/200/fields/B_Real/z');

% Reorder index to (z,x,y)
ExP = permute(ExR,[1 3 2]);
EyP = permute(EyR,[1 3 2]);
EzP = permute(EzR,[1 3 2]);

% Read in grid spacing and create 2D Cartesian grid in (x,y)
gridsp = h5readatt('E_Real.h5','/data/200/fields/E_Real','gridSpacing');
offs = h5readatt('E_Real.h5','/data/200/fields/E_Real','gridGlobalOffset');
xn = size(ExP,2);	yn = size(ExP,3);	zn = size(ExP,1);
x = linspace(offs(1),offs(1)+(xn-1)*gridsp(1),xn);
y = linspace(offs(2),offs(2)+(yn-1)*gridsp(2),yn);
z = linspace(offs(3),offs(3)+(zn-1)*gridsp(3),zn);
[Y2D,X2D] = meshgrid(y,x);

% Find max Ez on-axis and scale all values
M = interp2(Y2D,X2D,squeeze(EzP(1,:,:)),0,0); % M=53.5643;
Ex = ExR./M;
Ey = EyR./M;
Ez = EzR./M;
Bx = BxR./M;
By = ByR./M;
Bz = BzR./M;

% Calculate H
mu = 4*pi*10^(-7);

Hx = Bx./mu;
Hy = By./mu;
Hz = Bz./mu;

% Write field map data
for i = 1:101
    for j = 1:101
        for k = 1:201
            fprintf(fileID, '%d\t', Ex(k,j,i), Ey(k,j,i), Ez(k,j,i), Hx(k,j,i), Hy(k,j,i), Hz(k,j,i));
            fprintf(fileID, '\n');
        end
    end
end

fclose(fileID);