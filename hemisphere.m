function hemisphere
dr=30;
r1=1000;
r2=3*r1;
hmin=1;
k1=40;
k2=400;
x1=-r2;
x2=r2;
y1=-r2;
y2=r2;
z1=-hmin;
z2=r2;
d1=@(p) (p(:,1).^2+p(:,2).^2+p(:,3).^2).^0.5-r2;
d2=@(p) -p(:,3);
d3=@(p) (((p(:,1).^2+p(:,2).^2).^0.5-r2).^2+p(:,3).^2).^0.5;
rp=@(p) (p(:,1).^2+p(:,2).^2).^0.5-r2;
Rp=@(p) (p(:,1).^2+p(:,2).^2+p(:,3).^2).^0.5;
d=@(p) d3(p).*(rp(p)>0&d2(p)>0)+max(d1(p),d2(p)).*(rp(p)<=0|d2(p)<=0);
fh=@(p) 1.*(Rp(p)<=dr)+((k1-1)./(r1-dr).*(Rp(p)-dr)+1).*(Rp(p)<=r1&Rp(p)>dr)+...
    ((k2-k1)./(r2-r1).*(Rp(p)-r1)+k1).*(Rp(p)<=r2&Rp(p)>r1);
distmeshndrev(d,fh,hmin,[x1,y1,z1;x2,y2,z2],[0,0,0]);
%distmeshndrev2(d,fh,hmin,[x1,y1,z1;x2,y2,z2],[0,0,0]);


