function splot_inspect(X, Xpod, avg, Xi, Yi, r, snap, CM)
% this is just to compare reconstructed and original
% plots raw, randomly selected snapshot from X matrix
if snap > size(X,2)
    disp('You cannot select number larger than ', num2str(size(X,2)), ' number of snapshots in your X matrix!')
end

[xi,yi] = meshgrid(-1.5:0.05:24, -5:0.05:5);
row = size(xi,1);
col = size(xi,2);
% create a circle and set it as a boundary
theta = (1:100)/100'*2*pi;
x = 0.99*sin(theta)';
y = 0.99*cos(theta)';
b = boundary(x,y);

% place the boundary over the mesh and get the all cells with(in)
in = inpolygon(xi,yi,x(b),y(b));

% set zero vorticity at the cylinder location (cells with(in) the boundary)
% and interpolate results!
vecX = griddata(Xi,Yi,X(:,snap), xi, yi, 'linear');
vecX(in) = 0;

vecXpod = griddata(Xi,Yi,Xpod(:,snap), xi, yi, 'linear');
vecXpod(in) = 0;

vecAVG = griddata(Xi,Yi,avg, xi, yi, 'linear');
vecAVG(in) = 0;


figure;
colormap(CM);

subplot(1,2,1)
s = surface(xi, yi, vecX);
s.EdgeColor = 'none';
shading interp;
title('Raw data')
subtitle(['Snapshot ' num2str(snap)])
xlabel('X')
ylabel('Y')
zlabel('Vorticity [rotations/s]')
axis([min(xi,[],'all') max(xi,[],'all') min(yi,[],'all') max(yi,[],'all')])

% plots reconstructed, randomly selected snapshot from Xpod matrix
subplot(1,2,2)
s = surface(xi, yi, vecXpod+vecAVG);
s.EdgeColor = 'none';
shading interp;
title([num2str(r) ' POD modes'])
subtitle(['Snapshot ' num2str(snap)])
xlabel('X')
ylabel('Y')
zlabel('Vorticity [rotations/s]')
axis([min(xi,[],'all') max(xi,[],'all') min(yi,[],'all') max(yi,[],'all')])

set(gcf,'Position',[800 500 950 250])
end