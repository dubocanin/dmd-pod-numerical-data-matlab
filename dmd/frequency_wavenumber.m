clear,
close all,
clc,
load('cyl_mode1_dmd.mat');
%%
Nx = 64; % Number of samples collected along first dimension
Nt = 32; % Number of samples collected along second dimension
dx = 1;  % Distance increment (i.e., Spacing between each column)
dt = .1; % Time increment (i.e., Spacing between each row)
x = 0 : dx : (Nx-1)*dx; % distance
t = 0 : dt : (Nt-1)*dt; % time
data_spacetime = cyl_mod1_dmd; % random 2D matrix
Nyq_k = 1/(2*dx); % Nyquist of data in first dimension
Nyq_f = 1/(2*dt); % Nyquist of data in second dimension
dk = 1/(Nx*dx);   % Wavenumber increment
df = 1/(Nt*dt);   % Frequency increment
k = -Nyq_k : dk : Nyq_k-dk; % wavenumber
f = -Nyq_f : df : Nyq_f-df; % frequency
data_wavenumberfrequency = zeros(size(data_spacetime)); % initialize data
% Compute 2D Discrete Fourier Transform
for i1 = 1 : Nx
for j1 = 1 : Nt
for i2 = 1 : Nx
 for j2 = 1 : Nt
  data_wavenumberfrequency(j1,i1) = data_wavenumberfrequency(j1,i1) + ...
   data_spacetime(j2,i2)*exp(-1i*(2*pi)*(k(i1)*x(i2)+f(j1)*t(j2)))*dx*dt;
 end
end
end
end
%% visualization
figure;
subplot(3,1,1);
imagesc(k,f,abs(data_wavenumberfrequency));
colorbar; v = caxis;
title('2D DFT');
fft2result = fftshift(fft2(data_spacetime))*dx*dt;
subplot(3,1,2);
imagesc(k,f,abs(fft2result));
colorbar; caxis(v);
title('FFT2');
subplot(3,1,3);
imagesc(k,f,abs(fft2result-data_wavenumberfrequency));
colorbar; caxis(v);
title('Difference');