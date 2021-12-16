function gplot_mod(data, rows, cols, CM)
imagesc(reshape(data,rows,cols))
set(gca,'XTick',[1 50 100 150 200 250 300 350 400 449],'XTickLabel',{'-1','0','1','2','3','4','5','6','7','8'})
set(gca,'YTick',[1 50 100 150 199],'YTickLabel',{'2','1','0','-1','-2'});
set(gca,'FontSize',10)
xlim([1 cols]);
ylim([1 rows]);
colormap(CM);  % use custom colormap
c = colorbar;
caxis([-0.02 0.02])
c.Label.String = 'Eigenvector Value';
ylabel(c, '\phi_i(\xi)',fontsize=12)
ylabel('Y [m]');
xlabel('X [m]');

% position on a display when ploted, and figure size
set(gcf,'Position',[500 100 700 700])
set(gcf,'PaperPositionMode','auto')
end