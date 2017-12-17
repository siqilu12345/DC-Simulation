# DC-Simulation
Using finite element method for calculating direct current method in Geoelectricity.

We use finite element method(MATLAB PDE Toolbox) combined with Distmesh for simulation. The governing equation is ▽(σ▽u)=-Iδ(r), where u denotes the electric potential, σ is the conductivity of the material. The right-hand-side represents a point source. The region for our problem is half space. 
    
The problem is specifically difficult in the following aspects. First, there is a delta impulse in the function, so the mesh grid near the source must be small enough. Second, the boundary condition for infinite half space can not be used, we must use a finite region instead. 
    
To solve these difficulties, we use Distmesh to generate non-uniform grid size(can not be done by MATLAB Toolbox itself), and we divide our region into 3 parts. The first part is near the source, and has the smallest grid size. The second part is the region we want to study. And the last part is bigger than the second part, with the largest grid size, and is used to give the boundary condition. We use the mixed boundary condition instead just Dirichlet or Neumann boundary conditions for better accuracy.
    
There is also a problem in the orginal Distmesh package. The package needs to generate the mesh using the smallest size at first, which makes the array size unaffordable for the memory of the computer. I rewrite the program script so that it can generate array no more than the limite size at one time, and cut off nodes we don't need, and continue. The calculation takes a long time and is done bu using the server.
