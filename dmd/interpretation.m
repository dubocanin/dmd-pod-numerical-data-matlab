function interpretation(mu, lambda, omega, freq, b, f, S1, time, signal)

% sensor data
figure;
subplot(2,3,1)
hold on 
scatter(time, signal, 20, 'filled')
plot(time, signal)
ylabel('Vorticity [rotations/s]')
xlabel('Time [s]')
hold off

% FFT
subplot(2,3,2)
plot(f,S1,'LineWidth', 2) 
title('Single-Sided Amplitude Spectrum of Vort(t)')
% xlim([0 0.5])
xlabel('f [Hz]')
ylabel('Amplitude [-]')

% spectrum plot
subplot(2,3,3)
theta = (0:1:100)*2*pi/100; % create the unit circle
plot(cos(theta),sin(theta),'k--') % plot it
hold on, grid on 
scatter(real(diag(mu)),imag(diag(mu)), abs(b), abs(b), 'filled','MarkerEdgeColor',[0 .1 .1])
xlabel('real(\mu)')
ylabel('imag(\mu)')
colormap('parula')
colorbar
axis([-1.1 1.1 -1.1 1.1]);
hold off

% plot angular frequency
e1 = omega;
for i=1:length(omega)
    if e1(i) > 0
        e1(i,1) = e1(i);
    else
        e1(i,1) = 0;
    end
end
subplot(2,3,4)
stem(e1, 2*abs(b), 'filled')
ylabel('Amplitude [-]')
xlabel('Angular frequency [rad]')

% plot nfrequency
e2 = freq;
for i=1:length(e2)
    if e2(i) > 0
        e2(i,1) = e2(i);
    else
        e2(i,1) = 0;
    end
end
subplot(2,3,5)
stem(e2, 2*abs(real(b)), 'filled')
ylabel('Amplitude [-]')
xlabel('Frequency [Hz]')

% exponential eigenvalues spectrum
subplot(2,3,6)
scatter(imag(lambda), real(lambda), abs(b), abs(b), 'filled','MarkerEdgeColor',[0 .1 .1])
ylabel('real(\lambda)')
xlabel('imag(\lambda)')
colormap('parula')
colorbar

set(gcf,'Position',[400 200 1300 600])
set(gcf,'PaperPositionMode','auto')
end