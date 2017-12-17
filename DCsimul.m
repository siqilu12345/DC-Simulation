function [results,uintrp,xq]=DCsimul
%{
[x,y,z] = meshgrid(-10:20:10);
x = x(:);
y = y(:);
z = z(:);
K = convhull(x,y,z);
nodes = [x';y';z'];
elements = K';
%}
r2=1;
load('meshdata.mat');
model = createpde(1);
geometryFromMesh(model,p',t');
figure(1)
pdegplot(model,'Facelabels','on');
%pdemesh(model);
applyBoundaryCondition(model,'neumann','Face',[1],'q',0,'g',0);
applyBoundaryCondition(model,'neumann','Face',[2],'q',r2,'g',0);
specifyCoefficients(model,'f',@fcoeffunction,'c',@ccoeffunction,'m',0,...
    'd',0,'a',0);
%generateMesh(model,'GeometricOrder','quadratic');
%mesh=generateMesh(model,'GeometricOrder','quadratic');
%pdegplot3D(model);
results=solvepde(model)
figure(2)
pdeplot3D(model,'ColorMapData',results.NodalSolution)
xq=linspace(0.1,1,90);
yq=linspace(0.0001,0.0001,90);
zq=linspace(0.0001,0.0001,90);
uintrp=interpolateSolution(results,xq,yq,zq);
figure(3)
plot(xq,uintrp,xq,1./(4*pi.*xq));

