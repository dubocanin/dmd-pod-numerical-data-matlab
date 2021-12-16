function gplot_wake(data, row, col, CM)
imagesc(reshape(data,row,col))
set(gca,'XTick',[1 50 100 150 200 250 300 350 400 449],'XTickLabel',{'-1','0','1','2','3','4','5','6','7','8'})
set(gca,'YTick',[1 50 100 150 199],'YTickLabel',{'2','1','0','-1','-2'});
set(gca,'FontSize',10)
colormap(CM);
colorbar;
ylabel('Y [m]');
xlabel('X [m]');

% position on a display when ploted, and figure size
set(gcf,'Position',[500 300 400 200])
set(gcf,'PaperPositionMode','auto')
end