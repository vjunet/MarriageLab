function [ ] = plotbar3(saveit, dataplot)

    if saveit==1
        dirname = sprintf('data/%s',datestr(now,'yyyy_mm_dd_HH_MM_SS'));
        mkdir(dirname);
    end

tmax=11;
%plot no of singles over no of person for different radius
hold on
handle=figure(1);    

        subplot(1,4,1);

        bar(1:tmax,dataplot(:,5,2));
        xlabel('input size 2^x');
        ylabel('# singles');
        title(sprintf('random radius'));
        xlim([0,12]);
        ylim([0,35]);
        
        subplot(1,4,2);
        bar(1:tmax,dataplot(:,20,2));
        xlabel('input size 2^x');
        ylabel('# singles');
        title(sprintf('radius=0.1'));
        xlim([0,12]);
        ylim([0,35]);
        
        subplot(1,4,3);
        bar(1:tmax,dataplot(:,35,2));
        xlabel('input size 2^x');
        ylabel('# singles');
        title(sprintf('radius=0.25'));
        xlim([0,12]);
        ylim([0,35]);
 
    
        subplot(1,4,4);
        bar(1:tmax,dataplot(:,50,2));
        xlabel('input size 2^x');
        ylabel('# singles');
        title(sprintf('radius=0.4'));
        xlim([0,12]);
        ylim([0,35]);
hold off
if saveit==1
    saveas(handle,sprintf('%s/No of singles.pdf', dirname));
end

% saving
if (saveit==1)
    save(sprintf('%s/data.mat',dirname));
end
end