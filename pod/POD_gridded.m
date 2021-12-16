%% load data
clc
close all
clearvars
load ('..\data\book_data.mat','VORTALL', 'nx', 'ny')
load ('..\colormaps\CCnash.mat');
%% define matrix X with defined number of snapshots
[X] = VORTALL;
rows = ny;
cols = nx;
%% perform the POD
% might have been better if I just defined rank(number of modes)
% in order to compute less modes >>> requires less RAM
[phi, V, sig, avg, xt] = pod(X);

%% determine sufficient number of POD modes
[r] = how_many_modes(sig, input('Enter the amount of energy to be preserved (0-1): '));
%%
% figure
gplot_wake(avg, rows, cols, CCnash)
% saveas(gcf,'..\results\fig_name.png')

%% plot the singular values
figure;
plot_energy(sig,r)
% saveas(gcf,'..\results\fig_name.png')

%% plot POD modes
frow = 4;
fcol = 2;
fig = figure;
for i = 1:frow*fcol
    subplot(frow,fcol,i);
    gplot_mod(phi(:,i), rows, cols, CCnash)
    title(['mode ',num2str(i)], 'FontWeight', 'normal')
end

% saveas(gcf,'..\results\fig_name.png')
%% POD reconstruction
% >>> compute reconstructed X using predetermined number of POD modes
% >>> also computes the time coefficients aj, as one big matrix
% >>> aj is unique to each mode and each snapshot, e.g. if we decide to 
% keep 5 modes and if we have 100 snapshots, this matrix will have 5*100 
% columns meaning that first 100 rows (rows >>> because it's transposed) 
% contain aj for mode 1, next 100 rows contain aj for mode 2 and so on!

[Xpod, aj] = recon(X,xt,phi,r);
%% visual inspection
% requires X, Xpod, avg, col, row, r, snap(number of a snapshot you want to reconstruct)
gplot_inspect(X, Xpod, avg, rows, cols, r, 51, CCnash)
% saveas(gcf,'..\results\fig_name.png')
MAPE = mean(abs((X-(Xpod+avg))./X), 'all');
disp(['[MAPE] is: ',num2str(MAPE),'[%]'])