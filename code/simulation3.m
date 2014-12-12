function [ data ] = simulation3( saveit , tmax )
%SIMULATION3 perform simulation
%
%   simfeld
%
%   input:
%   saveit: if 1 data is saved, if 0 not
%   tmax: maximal exponent form input size (base 2)
%
%   returns:
%   data: simulation data

% simulate match making
% n is 2^t, t from 1 to tmax
% radius is either constant or random
%   when constant, in 0.1:rstep:0.5
% frequency changerate 0:fstep:1
% in makeMatch argument list p=0.5 -> change pref for both men and women

global verbosity
verbosity = 0;

assert(~isempty(find(saveit==[0,1],1)));
if nargin < 2
    tmax = 6;
end
t = 2.^(1:tmax);
rstep = 0.1;
r = 0.1:rstep:0.5;
fstep = 0.5;
f = 0:fstep:1;
sizef = size(f,2);
sizer = size(r,2)+1;
m = 10; % number of iterations
data = zeros(tmax,sizer,sizef,m,4);
% data dimensions:
% 1 input size n, tmax
% 2 radius, sizer
% 3 frequency, sizef
% 4 iterations, m
% 5 output values, 4
seed = rng;
disp(seed);
if saveit==1
    dirname = sprintf('data/%s',datestr(now,'yyyy_mm_dd_HH_MM_SS'));
    mkdir(dirname);
end
tic
fprintf('simulating for radius random\n');
% radius random
for i=1:tmax
    n = t(i);
    for k=1:sizef
        freq = f(k);
        for l=1:m
            %[a,b] = generatePlane(n,2);
            [a,b] = generateRandom(n);
            fprintf('.');
            [x,y] = makeMatch(a,b,freq,0.5);
            data(i,sizer,k,l,:) = y;
        end
        fprintf('\n');
    end
    fprintf('n = %4d complete after %5.1f\n', n, toc);
end
if 1==0
fprintf('simuation for radius const\n')
% radius const
for i=1:tmax
    n = t(i);
    for j=1:sizer-1
        radius = r(j);
        for k=1:sizef
            freq = f(k);
            for l=1:m
                %[a,b] = generatePlane(n,1,radius);
                [a,b] = generateRandom(n);
                fprintf('.');
                [x,y] = makeMatch(a,b,freq,0.5);
                data(i,j,k,l,:) = y;
            end
            fprintf('\n');
        end
        fprintf('radius %1.1f complete\n', radius);
    end
    fprintf('n = %4d complete after %5.1f\n', n, toc);
end
end
% plotting
plot3(data);
% saving
if (saveit==1)
    save(sprintf('%s/data.mat',dirname),'data','seed');
end

end
