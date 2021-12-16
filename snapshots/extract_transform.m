close all 
clearvars 
clc
myDir = uigetdir;                       % sets the data directory
myFiles = dir(fullfile(myDir,'*.csv')); % gets all csv files in struct
[~,index] = sortrows([myFiles.datenum].'); % sort files in ascending order
myFiles = myFiles(index); 
clear index
c = length(myFiles);                    % number of .csv files (each represents one time step)
r = 4848;                               % number of rows in one .csv file, read from .csv file
%% extract the vector components of velocity and vorticity
% x-component
Ux = zeros(r,c);
for k = 1:c
    Ux(:,k) = readtable(myFiles(k).name).U_0;
end
% y-component
Uy = zeros(r,c);
for k = 1:c
    Uy(:,k) = readtable(myFiles(k).name).U_1;
end
%% sqrt of squared Ux and Uy >> U magnitude
U = zeros(r,c);
for row = 1:r
    for col = 1:c
        U(row,col)= sqrt(Ux(row,col)^2+Uy(row,col)^2);
    end
end
%% vorticity raw
VORT_Z = zeros(r,c);
for k = 1:c
    VORT_Z(:,k) = readtable(myFiles(k).name).Vorticity_2;
end
%% XY - plane points
[X] = readtable(myFiles(1).name).Points_0;
[Y] = readtable(myFiles(1).name).Points_1;
PLANE = [X Y];
%% save results for further analysis
save('..\cyl_0-7500_1dt.mat','VORT_Z','PLANE', '-v7.3','-nocompression')