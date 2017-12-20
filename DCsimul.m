function results=DCsimul
%{
[x,y,z] = meshgrid(-10:20:10);
x = x(:);
y = y(:);
z = z(:);
K = convhull(x,y,z);
nodes = [x';y';z'];
elements = K';
%}
r2=3000;
load('meshdata800.mat');
model = createpde(1);
model.SolverOptions.AbsoluteTolerance = 1e-8;
model.SolverOptions.RelativeTolerance = 1e-4;
model.SolverOptions.ResidualTolerance = 1e-4;
model.SolverOptions.MaxIterations = 100; 
geometryFromMesh(model,p',t');
figure(1)
%pdegplot(model,'Facelabels','on');
pdemesh(model);
applyBoundaryCondition(model,'neumann','Face',[1],'q',0,'g',0);
applyBoundaryCondition(model,'neumann','Face',[2],'q',1./r2,'g',0);
specifyCoefficients(model,'f',@fcoeffunction,'c',@ccoeffunction,'m',0,...
    'd',0,'a',0);
%generateMesh(model,'GeometricOrder','quadratic');
%mesh=generateMesh(model,'GeometricOrder','quadratic');
%pdegplot3D(model);
results=solvepde(model)
figure(2)
pdeplot3D(model,'ColorMapData',results.NodalSolution)
xq=linspace(60,1000,900);
yq=linspace(2,2,900);
zq=linspace(2,2,900);
uintrp=interpolateSolution(results,xq,yq,zq);
figure(3)
plot(xq,uintrp,xq,100./(4*pi.*(xq.^2+8).^0.5));
legend('Numerical','Theoretical');
xlim([60,1000]);
xlabel('Distance');
ylabel('Electric Potential');


