function gplot_inspect(X, Xpod, avg, rows, cols, r, snap, CM)
% this is just to compare reconstructed and original
% plots raw, randomly selected snapshot from X matrix
if snap > size(X,2)
    disp('You cannot select number larger than ', num2str(size(X,2)), ' number of snapshots in your X matrix!')
end
% we add avarage to reconstructed flucctuating part Xpod
Xr = Xpod+avg*ones(1,size(X,2));
figure;

subplot(1,2,1)
imagesc(reshape(X(:,r),rows,cols))
set(gca,'XTick',[1 50 100 150 200 250 300 350 400 449],'XTickLabel',{'-1','0','1','2','3','4','5','6','7','8'})
set(gca,'YTick',[1 50 100 150 199],'YTickLabel',{'2','1','0','-1','-2'});
set(gca,'FontSize',10)
xlabel('X [m]');
ylabel('Y [m]');
xlim([1 cols]);
ylim([1 rows]);
title('Raw data')
subtitle(['Snapshot ' num2str(snap)])
colormap(CM);

% plots reconstructed, randomly selected snapshot from Xpod matrix
subplot(1,2,2)
imagesc(reshape(Xr(:,r),rows,cols))
set(gca,'XTick',[1 50 100 150 200 250 300 350 400 449],'XTickLabel',{'-1','0','1','2','3','4','5','6','7','8'})
set(gca,'YTick',[1 50 100 150 199],'YTickLabel',{'2','1','0','-1','-2'});
set(gca,'FontSize',10)
xlabel('X [m]');
ylabel('Y [m]');
xlim([1 cols]);
ylim([1 rows]);
title([num2str(r) ' POD modes'])
subtitle(['Snapshot ' num2str(snap)])
colormap(CM);
set(gcf,'Position',[600 400 950 250])
end