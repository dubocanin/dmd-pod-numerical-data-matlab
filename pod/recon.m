function [Xsum, a] = recon(X, xt, phi, r)
% compute the temporal coefficients
a = zeros(size(X,2)*r, size(X,1));
for q = 1:r
    for j = 1:size(X,2)
        if q == 1
            a(j,:) = xt(:,j)'*phi(:,q);
        else
            a(j+size(X,2)*(q-1),:) = xt(:,j)'*phi(:,q);
        end
    end
end

% reconstruct the model
Xpod = zeros(size(X,1), size(X,2));
Xsum = zeros(size(X,1), size(X,2));
for i = 1:r
    for m = 1:size(X,2)
        if i == 1
            Xpod(:,m) = a(m,:)'.*phi(:,i);
        else
            Xpod(:,m) = a(m+size(X,2)*(i-1),:)'.*phi(:,i); 
        end
    end
    Xsum = Xsum + Xpod;
end
end