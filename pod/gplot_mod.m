function gplot_mod(data, rows, cols, CM)
% hold on should be turned on only if one wants image origin to be at the bottom of
% a figure! The author of a DMD book have used "hold on" which is wrong. This
% should be off. One can check by first transforming one mode, into matrix 
% that will be ploted as image. The number of the first column of the first cell,
% has to be the same as the value on the upper, left corner of an image
% Antisymmetric (colorwise) figures will be fliped if hold is "on"! Keep it
% off!
imagesc(reshape(data,rows,cols))
set(gca,'XTick',[1 50 100 150 200 250 300 350 400 449],'XTickLabel',{'-1','0','1','2','3','4','5','6','7','8'})
set(gca,'YTick',[1 50 100 150 199],'YTickLabel',{'2','1','0','-1','-2'});
set(gca,'FontSize',10)
xlim([1 cols]);
ylim([1 rows]);
colormap(CM);  % use custom colormap
c = colorbar;
c.Label.String = 'Eigenvector Value';
ylabel(c, '\phi_i(\xi)',fontsize=12)
ylabel('Y [m]');
xlabel('X [m]');

% position on a display when ploted, and figure size
set(gcf,'Position',[400 75 900 800])
set(gcf,'PaperPositionMode','auto')
end