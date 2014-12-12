function [ ] = plotbar2(saveit, dataplot)

    if saveit==1
        dirname = sprintf('data/%s',datestr(now,'yyyy_mm_dd_HH_MM_SS'));
        mkdir(dirname);
    end

tmax=11;
c=27; %upper bound ylim
%plot no of inst over no of person with random radius and radius=0.1, prob. for only men,
%prob only women, prob=1
hold on
handle=figure(20);    

        subplot(2,2,1);

        bar(1:tmax,dataplot(:,5,1));
        xlabel('input size 2^x');
        ylabel('# instabilities');
        title(sprintf('changes only for men with random radius'));
        xlim([0,11]);
        ylim([0,c]);
        
        subplot(2,2,2);
        bar(1:tmax,dataplot(:,20,1));
        xlabel('input size 2^x');
        ylabel('# instabilities');
        title(sprintf('changes only for men with radius=0.1'));
        xlim([0,11]);
        ylim([0,c]);
        
        subplot(2,2,3);
        bar(1:tmax,dataplot(:,10,1));
        xlabel('input size 2^x');
        ylabel('# instabilities');
        title(sprintf('changes only for women with random radius'));
        xlim([0,11]);
        ylim([0,c]);
 
    
        subplot(2,2,4);
        bar(1:tmax,dataplot(:,25,1));
        xlabel('input size 2^x');
        ylabel('# instabilities');
        title(sprintf('changes only for women with radius=0.1'));
        xlim([0,11]);
        ylim([0,c]);
        if saveit==1
            saveas(handle,sprintf('%s/instability.pdf', dirname));
        end
hold off


% saving
if (saveit==1)
    save(sprintf('%s/data.mat',dirname));
end
end