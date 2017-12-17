function f=fcoeffunction(region,state)
s1=1;
sig=10;
nr=length(region.x);
f=zeros(1,nr);
f(1,:)=1./(sqrt(2.*pi).*sig).^3.*...
    exp(1./sig.^2./2.*(-region.x.^2-region.y.^2-region.z.^2));
%f(1,:)=-s1.*isregion(region.x,region.y,region.z).*;
%f=1./(pi.*0.01).*isregion(region.x,region.y,region.z);