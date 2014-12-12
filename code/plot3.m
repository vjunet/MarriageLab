function [  ] = plot3( data )
%PLOT3 plotting for optimality index analysis
%
%   simfeld
if 1==0
dirname = sprintf('data/%s',datestr(now,'yyyy_mm_dd_HH_MM_SS'));
mkdir(dirname);
% define arrays
sizer = size(data,2);
r=0.1:0.1:0.5;
f=0:0.5:1;
sizef=size(f,2);
tmax = size(data,1);
t=1:tmax;

% x-axis n, diff radius, plots freq
col = hsv(sizer);
for j=1:sizef
    freq = f(j);
    handle = figure(j);
    set(gca,'FontSize',16);
    hold on
    for i=1:sizer
        mm = squeeze(mean(data(:,i,j,:,4),4));
        st = squeeze(std(data(:,i,j,:,4),0,4));
        %plot(1:tmax,data(:,i,1,1,4),'color', col(i,:), 'marker', '*','linestyle','--');
        errorbar(1:tmax,mm,st,'color', col(i,:), 'marker', '.','linestyle','-.', 'LineWidth', 2);
    end
    hold off
    box on
    grid on
    title(sprintf('optimality index for for different radii, changerate is %1.1f',freq));
    arr = ['r','a','n','d','o','m',' ',' ',' ',' '];
    xlabel('input size 2^x');
    ylabel('optimality index');
    ylim([0,1.1]);
    xlim([0,11]);
    legend([num2str(r','radius %1.1f');arr]);
    saveas(handle,sprintf('%s/figure_%d.pdf', dirname, j));
end

% x-axis radius, diff n, plots freq
col = hsv(tmax);
for j=1:sizef
    freq = f(j);
    handle = figure(j+3);
    set(gca,'FontSize',16);
    hold on
    for i=1:tmax
        mm = squeeze(mean(data(i,:,j,:,4),4));
        st = squeeze(std(data(i,:,j,:,4),0,4));
        %plot(1:tmax,data(:,i,1,1,4),'color', col(i,:), 'marker', '*','linestyle','--');
        errorbar(0.1:0.1:0.6,mm,st,'color', col(i,:), 'marker', '.','linestyle','-.', 'LineWidth', 2);
    end
    hold off
    box on
    grid on
    title(sprintf('optimality index for for different n, changerate is %1.1f',freq));
    %arr = ['r','a','n','d','o','m',' ',' ',' ',' ',' ',' '];
    xlabel('radius, 0.6 is random');
    ylabel('optimality index');
    ylim([0,1.1]);
    xlim([0,0.9])
    legend(num2str(t','n = 2^{%2d}'));
    saveas(handle,sprintf('%s/figure_%d.pdf', dirname, j+3));
end

% x-axis freq, diff n, plots radius
col = hsv(tmax);
for j=1:sizer
    if j~= sizer radius = r(j); end
    handle = figure(j+6);
    set(gca,'FontSize',16);
    hold on
    for i=1:tmax
        mm = squeeze(mean(data(i,j,:,:,4),4));
        st = squeeze(std(data(i,j,:,:,4),0,4));
        %plot(1:tmax,data(:,i,1,1,4),'color', col(i,:), 'marker', '*','linestyle','--');
        errorbar(f,mm,st,'color', col(i,:), 'marker', '.','linestyle','-.', 'LineWidth', 2);
    end
    hold off
    box on
    grid on
    if j~= sizer
        title(sprintf('optimality index for for different n, radius %1.1f',radius));
    else
        title(sprintf('optimality index for for different n, radius random'));
    end
    %arr = ['r','a','n','d','o','m',' ',' ',' ',' ',' ',' '];
    xlabel('changerate');
    ylabel('optimality index');
    ylim([0,1.1]);
    xlim([-0.1,1.4]);
    legend(num2str(t','n = 2^{%2d}'));
    saveas(handle,sprintf('%s/figure_%d.pdf', dirname, j+6));
end

% surfs
handle = figure(13);
[a,b]=meshgrid(1:10,0.1:0.1:0.5);
hold on;
mm = squeeze(mean(data(:,1:5,3,:,4),4));
view(0,90);
box on
grid on
surf(a,b,mm','EdgeColor','none');
colorbar;
set(gca,'FontSize',16);
xlim([1,10]);
xlabel('input size2^x');
ylabel('radius');
saveas(handle,sprintf('%s/figure_13.pdf', dirname));
end
%generaterandom
handle = figure(14);
set(gca,'FontSize',16);
box on
dd=zeros(10,20,4);
for i=1:10
    n = 2^i;
    for j=1:20
        [a,b] = generateRandom(n);
        [x,y] = makeMatch(a,b);
        dd(i,j,:) = y;
        fprintf('.');
    end
    fprintf('\n');
end
mm = squeeze(mean(dd(:,:,4),2));
st = squeeze(std(dd(:,:,4),0,2));
errorbar(1:10,mm,st, 'marker', '.','linestyle','-.', 'LineWidth', 2);
%plot(1:10,log2(mm), 'marker', '.','linestyle','-.', 'LineWidth', 2);
p = polyfit(1:10,log2(mm'),1);
% line = polyval(p,1:10);
hold on;
x=1:10;
plot(x,(2^p(2))*(x.^(p(1))));
p
xlabel('input size 2^x');
ylabel('optimality index');
title('optimality index for randomly generated preferences');
%ylim([0,1.1]);
xlim([0,11]);
box on
grid on
%saveas(handle,sprintf('%s/figure_14.pdf', dirname));
end

