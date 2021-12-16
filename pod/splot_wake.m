function splot_wake(data, X, Y, CM)
% create a mesh for interpolation of the data
[xi,yi] = meshgrid(-1.5:0.05:24, -5:0.05:5);

% create a circle and set it as a boundary
% theta = (1:100)/100'*2*pi;
% x = 0.99*sin(theta)';
% y = 0.99*cos(theta)';
% b = boundary(x,y);

% place the boundary over the mesh and get the all cells with(in)
% in = inpolygon(xi,yi,x(b),y(b));

% set zero vorticity at the cylinder location (cells with(in) the boundary)
% and interpolate results!
vec = griddata(X,Y,data, xi, yi, 'linear');
% vec(in) = 0;

% plot results
s = surface(xi, yi, vec, 'FaceAlpha', 0.7);
xlabel('X')
ylabel('Y')
axis([-2 30 -6 6])
s.EdgeColor = 'none';

% create a circle to represent a cylinder in 2D
% theta = (1:100)/100'*2*pi;
% x = 0+1*sin(theta);
% y = 0+1*cos(theta);
% fill(x,y,[0 0 0])  % place cylinder
% plot(x,y,'k','LineWidth',1.2) % cylinder boundary

% load cool colors for a colormap
colormap(CM);  % use custom colormap
c = colorbar;
c.Label.String = 'Vorticity';
set(gcf,'Position',[500 300 400 200])
set(gcf,'PaperPositionMode','auto')

end