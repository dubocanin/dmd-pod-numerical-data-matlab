function [X] = extract_snaps(VORTz, mpl)
snaps = 1:mpl:size(VORTz,2);
X = zeros(size(VORTz,1),length(snaps));
for i=1:length(snaps)
    X(:,i)=VORTz(:,snaps(i));
end
end