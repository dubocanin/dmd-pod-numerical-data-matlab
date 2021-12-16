function [f, S1] = fourier_transform(signal, dt)
T = dt; % time between taking the samples (snapshots)
fs = 1/T; % sampling frequency [Hz]
L = length(signal); % total number of points that signal has

f = fs*(0:L/2)/L; % frequency domain

FFT = fft(signal);
S2 = abs(FFT/L); % FFT has complex numbers, abs returns theirs magnitude
                 % division by signal length is done to get the values of 
                 % Fourier transformed function normalized over the whole
                 % signal length (2-sided FT-signal spectrum)
S1 = S2(1:(L/2)+1);
S1(1:end) = 2*S1(1:end);
end