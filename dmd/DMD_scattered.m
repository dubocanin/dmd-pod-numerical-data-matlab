%% load the data
clc
close all
clearvars
load ('..\data\cyl_0-7500_1dt.mat', 'VORT_Z', 'PLANE') % add dt later on!!!!
load ('..\colormaps\CCnash.mat')
%% define simulation dt and snapshots dt, also define the matrix X
mpl = 50;
sim_dt = 0.02; % has to be read from simulation data
dt = mpl*sim_dt;

[X] = extract_snaps(VORT_Z,mpl);
X1 = X(:,1:end-1);
X2 = X(:,2:end);
Xi = PLANE(:,1);
Yi = PLANE(:,2);

%% fourier transform and determining fmax
% this is done in order to find the highest frequency in a data and then to
% adjust the sampling time, extraction of snapshots.
O = 1150; % position of a sensor [X = 2 and Y = 0]

[signal, time] = sensor(X,mpl,O,sim_dt);
[f, S1] = fourier_transform(signal, sim_dt);

%% perform the DMD
[PHI,mu,lambda,b,r] = dmd(X1, X2, 0.999999, dt); % 0.98 of "energy" to be preserved

%% interpretation parameters
% The real part R(λi) of the exponential eigenvalue λi determines the decay or growth
% In case of temporally sampled data, the imaginary part I(λi) determines the 
% frequency of the time-dependent oscillating function. It can be represented by 
% angular eigenfrequency ωi or eigenfrequency fi = ωi/2π.

sigma = real(lambda);
omega = imag(lambda);
zeta = sigma/omega;
freq = omega/(2*pi);

%% selection of modes for plotting
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
modID = [idx(2), idx(5), idx(7), idx(9), idx(11), idx(13)];

%% plot DMD modes
% It is suggested to inspect frequencies and interpretation parameters
% before plotting the modes. Then a list with indices of desired modes can
% be made and only selected modes plotted!
frow = 3;
fcol = 2;

figure;
for i = 1:length(modID)
    subplot(frow,fcol,i);
    splot_mod(real(PHI(:,modID(i))), Xi, Yi, CCnash)
end
% saveas(gcf,'..\results\fig_name.png')

figure;
for i = 1:length(modID)
    subplot(frow,fcol,i);
    splot_mod(imag(PHI(:,modID(i))), Xi, Yi, CCnash)
end
% saveas(gcf,'..\results\fig_name.png')

%% plot DMD spectrum
% DMD spectrum
interpretation(mu, lambda, omega, freq, b, f, S1, time, signal)
% saveas(gcf,'..\results\fig_name.png')

%% reconsrtuction of one arbitrarly selected snapshot

[Xdmd, dynamics] = recon(X, PHI, lambda, b, r, dt);
splot_inspect(X, Xdmd, Xi, Yi, r, 58, CCnash)
% saveas(gcf,'..\results\fig_name.png')
Xdmd = real(Xdmd);

%% model error
% compute the error
MAPE = mean(abs((X-Xdmd)./X)*100, 'all');
disp(['[MAPE] is: ',num2str(MAPE),'[%]'])