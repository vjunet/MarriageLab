function [ data ] = simulation2( saveit )
%simulation perform simulation
%
%   input:
%   saveit: if 1 data is saved, if 0 not
%
%   returns:
%   data: simulation data


%simulation

% simulate match making
% n is 2et, t from 1 to 6
% radius is either constant or random
%   when constant, r=0.4
%makeMatch with preference changes for men, women, men/women and
%probability of changing in p=0.1:0.1:0.9

global verbosity
verbosity = 0;

assert(~isempty(find(saveit==[0,1],1)));
tmax = 11;
t = 2.^(1:tmax);
p = 0.0:0.25:1.0;
pmax=size(p,2);
m=12; %number of different makeMatch called in simulation2
data = zeros(tmax,m*pmax,4);
r= 0.1:0.15:0.4;
seed = rng;
if saveit==1
    dirname = sprintf('data/%s',datestr(now,'yyyy_mm_dd_HH_MM_SS'));
    mkdir(dirname);
end

% radius random
for i=1:tmax
    n = t(i);
    [a,b] = generatePlane(n,2);
    fprintf('Plane with rand radius, size %d is generated\n', n);
    for j=1:pmax
       [x1,y1] = makeMatch(a,b, p(j),1);% x: engagement matrix; y(1): #unstable mariage, y(2): #single men/women, y(3): #dumps, y(4): optimality index
       [x2,y2] = makeMatch(a,b, p(j),0);
       [x3,y3] = makeMatch(a,b, p(j),0.5);
       data(i,j,:) = y1;
       data(i,pmax+j,:)=y2;
       data(i,2*pmax+j,:)=y3;
    end
end

%constant radius in r=[0.1,0.25,0.4]
for i=1:tmax
    n = t(i);
    [a,b] = generatePlane(n,1, r(1));
    fprintf('Plane with radius r=0.1, size %d is generated\n', n);
    for j=1:pmax
       [v1,w1] = makeMatch(a,b, p(j),1);% x: engagement matrix; y(1): #unstable mariage, y(2): #single men/women, y(3): #dumps, y(4): optimality index
       [v2,w2] = makeMatch(a,b, p(j),0);
       [v3,w3] = makeMatch(a,b, p(j),0.5);
       data(i,3*pmax+j,:) = w1;
       data(i,4*pmax+j,:) = w2;
       data(i,5*pmax+j,:) = w3;
    end
end

for i=1:tmax
    n = t(i);
    [a,b] = generatePlane(n,1, r(2));
    fprintf('Plane with radius r=0.25, size %d is generated\n', n);
    for j=1:pmax
       [v1,w1] = makeMatch(a,b, p(j),1);% x: engagement matrix; y(1): #unstable mariage, y(2): #single men/women, y(3): #dumps, y(4): optimality index
       [v2,w2] = makeMatch(a,b, p(j),0);
       [v3,w3] = makeMatch(a,b, p(j),0.5);
       data(i,6*pmax+j,:) = w1;
       data(i,7*pmax+j,:) = w2;
       data(i,8*pmax+j,:) = w3;
    end
end

for i=1:tmax
    n = t(i);
    [a,b] = generatePlane(n,1, r(3));
    fprintf('Plane with radius r=0.4, size %d is generated\n', n);
    for j=1:pmax
       [v1,w1] = makeMatch(a,b, p(j),1);% x: engagement matrix; y(1): #unstable mariage, y(2): #single men/women, y(3): #dumps, y(4): optimality index
       [v2,w2] = makeMatch(a,b, p(j),0);
       [v3,w3] = makeMatch(a,b, p(j),0.5);
       data(i,9*pmax+j,:) = w1;
       data(i,10*pmax+j,:) = w2;
       data(i,11*pmax+j,:) = w3;
    end
end




% saving
if (saveit==1)
    save(sprintf('%s/data.mat',dirname),'data','seed');
end

end