close;
clear;
clc;
%% svd
A = [1  3   1;
     2  -4   2; 
     2  -4   2;
     1  3   1;
     1  3   1;
     2  -4   2; 
     2  -4   2;
     1  3   1;
     1  3   1;
     2  -4   2; 
     2  -4   2;
     1  3   1];
[phi, Sigma, U] = svd(A);
[V, D] = eig(A*A');
%% checking orthonomality
unit = sqrt(sum(phi(:,1).^2));
vec_orthon = dot(phi(:,1),phi(:,2));
%% Plots that are proving something is wrong with 'econ' function
load ..\colormaps\CCool.mat
figure;
subplot(1,3,1);
hold on
imagesc(reshape(phi(:,1),3,4))
colorbar
colormap(CCool);
hold off

subplot(1,3,2);
hold on
imagesc(reshape(phi(:,2),3,4))
colorbar
colormap(CCool);
hold off

subplot(1,3,3);
hold on
imagesc(reshape(phi(:,3),3,4))
colorbar
colormap(CCool);
hold off