- all files except 'POD_gridded/scattered.mat' are functions used by the script 'POD_gridded/scattered.mat'

- to perform the POD analysis, run the 'POD_analysis.mat' script
	1. load the desired file, and specify variable to perform the POD on
	2. adjust the name of your variable within the variable "X"
	3. when prompted, specify the amount of energy to be preserved 
	   (between 0 and 0.999, for 1 the code doesn't work)
	4. the rest of a script runs on it own


Below, the intuition behind the "recon" function is given:

If we suppose we want to keep 5 POD modes, then we would have to 
compute 5 time coefficients. Bellow is an example of how is that 
done manually. 'recon.mat' function can accomplish the same through loops...
that are not so efficient (if your RAM is getting consumed, comment out reconstruction part). 

% compute the time coefficients
aj1 = zeros(size(X,2), size(X,1));
aj2 = zeros(size(X,2), size(X,1));
aj3 = zeros(size(X,2), size(X,1));
aj4 = zeros(size(X,2), size(X,1));
aj5 = zeros(size(X,2), size(X,1));
for j = 1:size(X,2)
    aj1(j,:) = xt(:,j)'*phi(:,1);
    aj2(j,:) = xt(:,j)'*phi(:,2);
    aj3(j,:) = xt(:,j)'*phi(:,3);
    aj4(j,:) = xt(:,j)'*phi(:,4);
    aj5(j,:) = xt(:,j)'*phi(:,5);
end

%%
Xpod1 = zeros(size(X,1), size(X,2));
% reconstruct the X, with predetermined number of modes
for m = 1:size(X,2)
    Xpod1(:,m) = aj1(m,:)'.*phi(:,1);
end
Xpod2 = zeros(size(X,1), size(X,2));
% reconstruct the X, with predetermined number of modes
for m = 1:size(X,2)
    Xpod2(:,m) = aj1(m,:)'.*phi(:,1)...
        + aj2(m,:)'.*phi(:,2);
end
Xpod3 = zeros(size(X,1), size(X,2));
% reconstruct the X, with predetermined number of modes
for m = 1:size(X,2)
    Xpod3(:,m) = aj1(m,:)'.*phi(:,1)...
        + aj2(m,:)'.*phi(:,2)...
        + aj3(m,:)'.*phi(:,3);
end
Xpod4 = zeros(size(X,1), size(X,2));
% reconstruct the X, with predetermined number of modes
for m = 1:size(X,2)
    Xpod4(:,m) = aj1(m,:)'.*phi(:,1)...
        + aj2(m,:)'.*phi(:,2)...
        + aj3(m,:)'.*phi(:,3)...
        + aj4(m,:)'.*phi(:,4);
end
Xpod5 = zeros(size(X,1), size(X,2));
% reconstruct the X, with predetermined number of modes
for m = 1:size(X,2)
    Xpod5(:,m) = aj1(m,:)'.*phi(:,1)...
        + aj2(m,:)'.*phi(:,2)...
        + aj3(m,:)'.*phi(:,3)...
        + aj4(m,:)'.*phi(:,4)...
        + aj5(m,:)'.*phi(:,5);
end