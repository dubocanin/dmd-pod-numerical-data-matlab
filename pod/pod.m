function [phi,V, S,avg,xt] = pod(X)
% compute mean;
avg = mean(X,2); 

% subtract the avg
avg_mat = avg*ones(1,size(X,2));
xt = X-avg_mat;

% compute POD after subtracting mean
[phi,S,V] = svd(xt, 'econ'); % phi are POD modes
end