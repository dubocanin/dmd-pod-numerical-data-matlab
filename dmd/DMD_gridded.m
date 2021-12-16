%% load the data
clc
close all
clearvars
load ('..\data\book_data.mat', 'VORTALL', 'nx', 'ny', 'xi', 'yi') % add dt later on!!!!
load ('..\colormaps\CCnash.mat')
%% define simulation dt and snapshots dt, also define the matrix X
mpl = 10;
sim_dt = 0.02; % has to be read from simulation data
dt = mpl*sim_dt;

% matrix 
X = VORTALL;
X1 = X(:,1:end-1);
X2 = X(:,2:end);
rows = ny;
cols = nx;
%% fourier transform and determining fmax
% this is done in order to find the highest frequency in a data and then to
% adjust the sampling time, extraction of snapshots.
O = 40100; % position of a sensor [X = 2 and Y = 0]
% % 
[signal, time] = sensor(X,mpl,O, dt);
[f, S1] = fourier_transform(signal, dt);

%% perform the DMD
[PHI,mu,lambda,b,r] = dmd(X1, X2, 0.999, dt); % 99.9% of "energy" to be preserved

%% interpretation parameters
% The real part R(λi) of the exponential eigenvalue λi determines the decay or growth
% In case of temporally sampled data, the imaginary part I(λi) determines the 
% frequency of the time-dependent oscillating function. It can be represented by 
% angular eigenfrequency ωi or time domain frequency fi = ωi/2π.

sigma = real(lambda);
omega = imag(lambda);
zeta = sigma/omega;
freq = omega/(2*pi);

%% selection of modes for plotting by amplitude
idx = zeros(1,21);

i = 1;
temp = b;
while i < size(b,1)+1
    [v,id] = max(abs(temp));
    idx(:,i) = id;
    temp(id) = 0;
    i = i+1;
end
% now we take only first five indices from idx
modID = [idx(2), idx(4), idx(6), idx(8), idx(10), idx(12), idx(14), idx(16)];

%% plot DMD modes
% It is suggested to inspect frequencies and interpretation parameters
% before plotting the modes. Then a list with indices of desired modes can
% be made and only selected modes plotted!
frow = 4;
fcol = 2;

fig = figure;
for i = 1:length(modID)
    subplot(frow,fcol,i);
    gplot_mod(real(PHI(:,modID(i))), rows, cols, CCnash)
    title(['mode ',num2str(i)], 'FontWeight', 'normal')
end
% saveas(gcf,'..\results\fig_name.png')

figure;
for i = 1:length(modID)
    subplot(frow,fcol,i);
    gplot_mod(imag(PHI(:,modID(i))), rows, cols,CCnash)
    title(['mode ',num2str(i)], 'FontWeight', 'normal')
end
% saveas(gcf,'..\results\fig_name.png')

%% plot DMD spectrum
% DMD spectrum
interpretation(mu, lambda, omega, freq, b, f, S1, time, signal)
% saveas(gcf,'..\results\fig_name.png')

%% reconsrtuction of one arbitrarly selected snapshot

[Xdmd, dynamics] = recon(X, PHI, lambda, b, r, dt);
gplot_inspect(X, Xdmd, xi, yi, r, 58, CCnash)
% saveas(gcf,'..\results\fig_name.png')
Xdmd = real(Xdmd);

%% model error
% compute the error
MAPE = mean(abs((X-Xdmd)./X), 'all');
disp(['[MAPE] is: ',num2str(MAPE),'[%]'])