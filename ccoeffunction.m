function cmatrix=ccoeffunction(region,state)
s1=1;
ds=1;
n1 = 9;
nr = numel(region.x);
cmatrix = zeros(n1,nr);
cmatrix(1,:) = ones(1,nr);%.*(s1+ds.*isregion(region.x,region.y,region.z));
cmatrix(2,:) = zeros(1,nr);
cmatrix(3,:) = zeros(1,nr);
cmatrix(4,:) = zeros(1,nr);
cmatrix(5,:) = ones(1,nr);%.*(s1+ds.*isregion(region.x,region.y,region.z));
cmatrix(6,:) = zeros(1,nr);
cmatrix(7,:) = zeros(1,nr);
cmatrix(8,:) = zeros(1,nr);
cmatrix(9,:) = ones(1,nr);%.*(s1+ds.*isregion(region.x,region.y,region.z));