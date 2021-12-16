function [Xdmd, dynamics] = recon(X,PHI,lambda,b,r,dt)
%% DMD reconstruction
% the reconstruction is done according to the expression:
% Xdmd = PHI*b*e^(lambda*t)

% the number of snapshots to be reconstructed equals number of columns of X
% keep in mind that, prediction is possible by extending the snapshots 
% vector! e.g. instead of using below expression to determine the
% number of snapshots in provided dataset, we can simply define a number 
% that is larger than the number of snapshots in our dataset, hence
% obtaining the future state of considered system.

snapshots = size(X,2);     

% matrix that will hold the expression b*e^(lambda*t) is defined below
% first dimension is 'r', becasue the lambda also has 'r' dimension!
dynamics = zeros(r, snapshots);

% time vector, since it starts from zero, last snapshot is subtracted
% the number of snapshots is multiplied by dt. the get the actual time that
% passed between first and the last snapshot
t = (0:snapshots-1)*dt;                
for i = 1:snapshots
    dynamics(:,i) = (b.*exp(lambda*t(i)));
end

Xdmd = PHI*dynamics;
end