function [PHI,mu,lambda,b,r]= dmd(X1,X2,energy,dt) 
% Computes the Dynamic Mode Decomposition of X1, X2 

% % INPUTS:
% X1 - X(1:end-1)
% X2 - X(2:end)
% r - target rank of SVD 
% dt - timestep advancing X1 to X2 (X to X’) 

% % OUTPUTS: 
% Phi - DMD modes 
% omega - the continuous-time DMD eigenvalues 
% lambda - the discrete-time DMD eigenvalues 
% b - vector of magnitudes of modes Phi 
% Xdmd - reconstructed initial matrix X using DMD modes 

%% perform the DMD 
% STEP 1 - since X2=A*X1, we will SVD the X1 
% (if curious why, refer to a paper https://arxiv.org/pdf/1702.01453.pdf)
[phi, sigma, V]= svd(X1, 'econ');

% since sigma can be related to kinematic energy for fluid flows we will
% determine how many modes we want to work with based on what % of
% kinematic energy we want to preserve!
[r] = how_many_modes(sigma, energy);

% once we determined how many modes are necessary for the model
% reconstruciotn, we will reduce the size of the original eigenvector
% matrix phi to phi_r, and continue with smaller matrix that is easier to
% work with and requires less computational power.

% STEP 2 - reduciton
phi_r = phi(:, 1:r);        % all rows but only r-columns
sigma_r = sigma(1:r,1:r);   % square matrix, we reduce both dimensions
Vr = V(:, 1:r);             % all rows but only r-columns

% STEP 3 - forming a reduced Atilde matrix
% here we use values we got after SVD and reduciton to express the A matrix
% or more precisely, its reduced version!
Atilde = phi_r'* X2 * Vr/sigma_r; % low-rank dynamics 

% now, since we have a matrix Atilde (that is almost similar to real A) we
% can write A*wr = wr*D, do the eigendecomposition, and get the wr, last
% component (eigenvectors, that we are not interested in but we need them)
% to compute PHI acording to Tu et al.

[wr, mu]= eig(Atilde);

% step 4 - computing DMD modes according to Tu et al.
PHI = X2*Vr/sigma_r*wr;         % DMD modes

% Using the above relationship, the growth/decay rates and frequencies of 
% the DMD modes can be inferred by examining the real and imaginary 
% components of lambda eigenvalue!

mu_col = diag(mu);              % discrete -time eigenvalues 
lambda = log(mu_col)/dt;        % continuous-time eigenvalues
%% Compute DMD mode amplitudes b
Xo = X1(:, 1);      % the initial condition
b = PHI\Xo;         % amplitudes, backlash indicates left matrix division
end