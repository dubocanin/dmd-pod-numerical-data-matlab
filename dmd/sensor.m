function [signal,time] = sensor(X,mpl,O,sim_dt)
% time vector
time = mpl*(0:size(X,2)-1)*sim_dt;
signal = X(O,:); % neutral position
end