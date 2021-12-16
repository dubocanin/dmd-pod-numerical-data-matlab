%% load the data
clc
close all
clearvars
load ('..\data\cyl_0-7500_1dt.mat', 'VORT_Z', 'PLANE') % add dt later on!!!!
load ('..\colormaps\CCnash.mat')
%% define matrix X with defined number of snapshots
mpl = 50; 
% to extract every 8th snapshot, change e.g. mpl = 20 if you want to 
% extract every 20th snapshot!
[X] = extract_snaps(VORT_Z,mpl);
Xi = PLANE(:,1);
Yi = PLANE(:,2);
%% perform the POD
% might have been better if I just defined rank(number of modes)
% in order to compute less modes >>> requires less RAM
[phi, V, sig, avg, xt] = pod(X);

%% determine sufficient number of POD modes
[r] = how_many_modes(sig, input('Enter the amount of energy to be preserved (0-1): '));
%%
figure
splot_wake(avg, Xi, Yi, CCnash)
% saveas(gcf,'..\results\fig_name.png')

%% plot the singular values
figure;
plot_energy(sig,r)
% saveas(gcf,'..\results\fig_name.png')
%% plot POD modes
frow = 4;
fcol = 2;
figure;
for i = 1:frow*fcol
    subplot(frow,fcol,i);
    splot_mod(phi(:,i), Xi, Yi, CCnash)
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
splot_inspect(X, Xpod, avg, Xi, Yi, r, 51, CCnash)
% saveas(gcf,'..\results\fig_name.png')