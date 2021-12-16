function [r] = how_many_modes(sigma,energy)
% function to determine sufficient number of POD modes
cumeng = energy; % the amount of energy we want to preserve
eng = sigma(1,1);
t = 1;
while eng/sum(diag(sigma)) < cumeng
    t = t + 1;
    eng = eng + sigma(t,t);
end
disp(['First ', num2str(t), ' modes contain ' ,num2str(round(eng/sum(diag(sigma)),10)*100), '% of kinematic energy.']);
r = t;
end