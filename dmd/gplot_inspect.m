function gplot_inspect(X, Xdmd, xi, yi, r, snap, CM)
% this is just to compare reconstructed and original
% plots raw, randomly selected snapshot from X matrix
if snap > size(X,2)
    disp('You cannot select number larger than ', num2str(size(X,2)), ' number of snapshots in your X matrix!')
end

row = size(xi,1);
col = size(xi,2);

% plot results
figure;
colormap(CM);

% plot of selcetd snapshot using raw data allocated in matrix X
subplot(1,2,1)
s = surface(xi, yi, reshape(X(:,snap),row,col));
s.EdgeColor = 'none';
shading interp;
title('Raw data')
subtitle(['Snapshot ' num2str(snap)])
xlabel('X')
ylabel('Y')
zlabel('Vorticity [rotations/s]')
axis([min(xi,[],'all') max(xi,[],'all') min(yi,[],'all') max(yi,[],'all')])

% plot reconstructed, randomly selected snapshot from Xdmd matrix
subplot(1,2,2)
s = surface(xi, yi, reshape(real(Xdmd(:,snap)),row,col));
s.EdgeColor = 'none';
shading interp;
title([num2str(r) ' DMD modes'])
subtitle(['Snapshot ' num2str(snap)])
xlabel('X')
ylabel('Y')
zlabel('Vorticity [rotations/s]')
axis([min(xi,[],'all') max(xi,[],'all') min(yi,[],'all') max(yi,[],'all')])

set(gcf,'Position',[600 400 950 250])
end