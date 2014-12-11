function [  ] = plot3( data )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
% plot optimality index for each radius
dirname = sprintf('data/%s',datestr(now,'yyyy_mm_dd_HH_MM_SS'));
mkdir(dirname);
hold on
handle = figure(1);
sizer = size(data,2);
r=0.1:0.1:0.5;
tmax = size(data,1);
col = hsv(sizer);
for i=1:sizer
    mm = squeeze(mean(data(:,i,3,:,4),4));
    st = squeeze(std(data(:,i,3,:,4),0,4));
    %plot(1:tmax,data(:,i,1,1,4),'color', col(i,:), 'marker', '*','linestyle','--');
    errorbar(1:tmax,mm,st,'color', col(i,:), 'marker', '*','linestyle','--');
    title('optimality index for for different radiuses');
    
end
arr = ['r','a','n','d','o','m',' ',' ',' ',' ',' ',' '];
xlabel('input size 2^x');
ylabel('optimality index');
ylim([0,1.1]);
legend([num2str(r','radius %1.3f');arr]);
saveas(handle,sprintf('%s/figure_1.pdf', dirname));
hold off

end

