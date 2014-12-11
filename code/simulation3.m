function [ data ] = simulation3( saveit , tmax)
%simulation perform simulation
%
%   input:
%   saveit: if 1 data is saved, if 0 not
%
%   returns:
%   data: simulation data


%simulation

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
            [a,b] = generatePlane(n,2);
            %[a,b] = generateRandom(n);
            fprintf('.');
            [x,y] = makeMatch(a,b,freq,0.5);
            data(i,sizer,k,l,:) = y;
        end
        fprintf('\n');
    end
    fprintf('n = %4d complete after %5.1f\n', n, toc);
end

fprintf('simuation for radius const\n')
% radius const
for i=1:tmax
    n = t(i);
    for j=1:sizer-1
        radius = r(j);
        for k=1:sizef
            freq = f(k);
            for l=1:m
                [a,b] = generatePlane(n,1,radius);
                %[a,b] = generateRandom(n);
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

% plot optimality index for each radius
hold on
handle = figure(1);
col = hsv(sizer);
for i=1:sizer
    mm = squeeze(mean(data(:,i,1,:,4),4));
    st = squeeze(std(data(:,i,1,:,4),0,4));
    %plot(1:tmax,data(:,i,1,1,4),'color', col(i,:), 'marker', '*','linestyle','--');
    errorbar(1:tmax,mm,st,'color', col(i,:), 'marker', '*','linestyle','--');
    title('optimality index for for different radiuses');
    
end
arr = ['r','a','n','d','o','m',' ',' ',' ',' ',' ',' '];
xlabel('input size 2^x');
ylabel('optimality index');
ylim([0,1.1]);
legend([num2str(r','radius %1.3f');arr]);
if saveit==1
    saveas(handle,sprintf('%s/figure_1.pdf', dirname));
end
hold off


% saving
if (saveit==1)
    save(sprintf('%s/data.mat',dirname),'data','seed');
end

end
