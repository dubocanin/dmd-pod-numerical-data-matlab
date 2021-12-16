function plot_energy(sigma,no_modes)
% plot the singular values
subplot(2,1,1);
plot(diag(sigma), 'b--o');
axis([0 no_modes 0 inf])
xlabel('mode')
ylabel('\sigma_i') % kinetic energy

subplot(2,1,2);
plot(cumsum(diag(sigma)/sum(diag(sigma))), 'b--o');
axis([0 no_modes 0 inf])
xlabel('mode')
ylabel('Cumulative Energy \Sigma')

set(gcf,'Position',[700 300 450 325])
end