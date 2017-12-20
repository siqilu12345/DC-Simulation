function [p,t]=distmeshndrev(fdist,fh,h,box,fix,varargin)
%DISTMESHND N-D Mesh Generator using Distance Functions.
%   [P,T]=DISTMESHND(FDIST,FH,H,BOX,FIX,FDISTPARAMS)
%
%      P:           Node positions (NxNDIM)
%      T:           Triangle indices (NTx(NDIM+1))
%      FDIST:       Distance function
%      FH:          Edge length function
%      H:           Smallest edge length
%      BOX:         Bounding box [xmin,xmax;ymin,ymax; ...] (NDIMx2)
%      FIX:         Fixed node positions (NFIXxNDIM)
%      FDISTPARAMS: Additional parameters passed to FDIST
%
%   Example: Unit ball
%      dim=3;
%      d=inline('sqrt(sum(p.^2,2))-1','p');
%      [p,t]=distmeshnd(d,@huniform,0.2,[-ones(1,dim);ones(1,dim)],[]);
%
%   See also: DISTMESH2D, DELAUNAYN, TRIMESH, MESHDEMOND.

%   Copyright (C) 2004-2012 Per-Olof Persson. See COPYRIGHT.TXT for details.

dim=size(box,2);
ptol=.001; ttol=.1; L0mult=1+.4/2^(dim-1); deltat=.1; geps=1e-1*h; deps=sqrt(eps)*h;


% 1. Create initial distribution in bounding box
if dim==1
  p=(box(1):h:box(2))';
else
  cbox=cell(1,dim);
  for ii=1:dim
    cbox{ii}=box(1,ii):h:box(2,ii);
  end
  pp=cell(1,dim-1);
  [pp{:}]=ndgrid(cbox{2:dim});
  l2=prod(size(pp{1}));
  p=[];
  rmin=1;   %require min(fh(p))=1
  x1=[box(1,1):h:box(2,1)];
  l1=length(x1);
  dl=floor(4e8/l2);
  if dl<1
      disp('Memory not enough');
      return;
  end
  l0=0;
  n=floor(l1/dl);
  disp(n);
  cbox=cell(n,1);
  for i=1:n
      dp=[reshape(repmat(x1((i-1)*dl+1:i*dl),l2,1),[],1),...
          repmat(pp{1}(:),dl,1),repmat(pp{2}(:),dl,1)];
      dp=dp(feval(fdist,dp,varargin{:})<geps,:);
      r0=feval(fh,dp);
      dp=[dp(rand(size(dp,1),1)<rmin^dim./r0.^dim,:)];
      cbox{i}=dp;
      disp(i);
  end
  p=cell2mat(cbox);
  clear cbox;
  rl=l1-n*dl;
  if rl~=0
    dp=[reshape(repmat(x1(n*dl+1:l1),l2,1),[],1),...
            repmat(pp{1}(:),rl,1),repmat(pp{2}(:),rl,1)];
    dp=dp(feval(fdist,dp,varargin{:})<geps,:);
    r0=feval(fh,dp);
    dp=[dp(rand(size(dp,1),1)<rmin.^dim./r0.^dim,:)];
    p=[p;dp];
  end
end
disp('First step finished');
save('firstp.mat','p');

