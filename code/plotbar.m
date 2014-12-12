function [ dataplot] = plotbar(saveit, dataplot)

    if saveit==1
        dirname = sprintf('data/%s',datestr(now,'yyyy_mm_dd_HH_MM_SS'));
        mkdir(dirname);
    end

tmax=11;
t = 2.^(1:tmax);
p = 0.0:0.25:1.0;
pmax=size(p,2);
c=27; %upper bound ylim
d=35;
%plot no of single over no of person with random radius
hold on
handle = figure(1);    
for i=1:3*pmax
    subplot(3,pmax,i);
    if i<=pmax
        bar(1:tmax,dataplot(:,i,2));
        xlabel('input size 2^x');
        ylabel('# singles');
        title(sprintf('probability (man) %1.2f %', p(i)));
        xlim([0,11]);
        ylim([0,d]);
    end
    
    if i<=2*pmax && i>pmax
        bar(1:tmax,dataplot(:,i,2));
        xlabel('input size 2^x');
        ylabel('# singles');
        title(sprintf('probability (women) %1.2f %', p(i-pmax)));
        xlim([0,11]);
        ylim([0,d]);
    end
    
    if i>2*pmax
        bar(1:tmax,dataplot(:,i,2));
        xlabel('input size 2^x');
        ylabel('# singles');
        title(sprintf('probability (men/women) %1.2f %', p(i-2*pmax)));
        xlim([0,11]);
        ylim([0,d]);
    end

end
if saveit==1
    saveas(handle,sprintf('%s/(1)no of single over no of person with random radius.pdf', dirname));
end
hold off

%plot no of single over no of person with radius=0.1
hold on
handle = figure(2);    
for i=1:3*pmax
    subplot(3,pmax,i);
    if i<=pmax
        bar(1:tmax,dataplot(:,3*pmax+i,2));
        xlabel('input size 2^x');
        ylabel('# singles');
        title(sprintf('probability (man) %1.2f %', p(i)));
        xlim([0,11]);
        ylim([0,d]);
    end
    
    if i<=2*pmax && i>pmax
        bar(1:tmax,dataplot(:,3*pmax+i,2));
        xlabel('input size 2^x');
        ylabel('# singles');
        title(sprintf('probability (women) %1.2f %', p(i-pmax)));
        xlim([0,10]);
        ylim([0,d]);
    end
    
    if i>2*pmax
        bar(1:tmax,dataplot(:,3*pmax+i,2));
        xlabel('input size 2^x');
        ylabel('# singles');
        title(sprintf('probability (men/women) %1.2f %', p(i-2*pmax)));
        xlim([0,11]);
        ylim([0,d]);
    end

end
if saveit==1
    saveas(handle,sprintf('%s/(2)no of single over no of person with radius=0.1.pdf', dirname));
end
hold off

%plot no of single over no of person with constant radius=0.25
hold on
handle = figure(3);    
for i=1:3*pmax
    subplot(3,pmax,i);
    if i<=pmax
        bar(1:tmax,dataplot(:,6*pmax+i,2));
        xlabel('input size 2^x');
        ylabel('# singles');
        title(sprintf('probability (man) %1.3f %', p(i)));
        xlim([0,11]);
        ylim([0,d]);
    end
    
    if i<=2*pmax && i>pmax
        bar(1:tmax,dataplot(:,6*pmax+i,2));
        xlabel('input size 2^x');
        ylabel('# singles');
        title(sprintf('probability (women) %1.3f %', p(i-pmax)));
        xlim([0,11]);
        ylim([0,d]);
    end
    
    if i>2*pmax
        bar(1:tmax,dataplot(:,6*pmax+i,2));
        xlabel('input size 2^x');
        ylabel('# singles');
        title(sprintf('probability (men/women) %1.3f %', p(i-2*pmax)));
        xlim([0,11]);
        ylim([0,d]);
    end

end
if saveit==1
    saveas(handle,sprintf('%s/(3)no of single over no of person with radius=0.25.pdf', dirname));
end
hold off

%plot no of single over no of person with constant radius=0.4
hold on
handle = figure(4);    
for i=1:3*pmax
    subplot(3,pmax,i);
    xlim([0,10]);
    if i<=pmax
        bar(1:tmax,dataplot(:,9*pmax+i,2));
        xlabel('input size 2^x');
        ylabel('# singles');
        title(sprintf('probability (man) %1.3f %', p(i)));
        xlim([0,11]);
        ylim([0,d]);
    end
    
    if i<=2*pmax && i>pmax
        bar(1:tmax,dataplot(:,9*pmax+i,2));
        xlabel('input size 2^x');
        ylabel('# singles');
        title(sprintf('probability (women) %1.3f %', p(i-pmax)));
        xlim([0,11]);
        ylim([0,d]);
    end
    
    if i>2*pmax
        bar(1:tmax,dataplot(:,9*pmax+i,2));
        xlabel('input size 2^x');
        ylabel('# singles');
        title(sprintf('probability (men/women) %1.3f %', p(i-2*pmax)));
        xlim([0,11]);
        ylim([0,d]);
    end

end
if saveit==1
    saveas(handle,sprintf('%s/(4)no of single over no of person with radius=0.4.pdf', dirname));
end
hold off


% plot no of single men/women for each probability, with random radius
hold on
handle = figure(5);
for i=1:3*tmax
    subplot(3,tmax,i);
    if i<=tmax
        bar(p,dataplot(i,1:pmax,2));
        if i==1
            xlabel('probability (man)');
            ylabel('# singles');
        end
        xlim([0,1]);
        ylim([0,40]);
        title(sprintf('input size %1.0f',t(i)));
    end
    
    if i<=2*tmax && i>tmax
        bar(p,dataplot(i-tmax,pmax+1:2*pmax,2));
        if i==tmax+1
            xlabel('probability (women)');
            ylabel('# singles');
        end
        xlim([0,1]);
        ylim([0,40]);
    end
    
    if i>2*tmax
        bar(p,dataplot(i-2*tmax,2*pmax+1:3*pmax,2));
        if i==2*tmax+1
            xlabel('probability (men/women)');
            ylabel('# singles');
        end
        xlim([0,1]);
        ylim([0,40]);
    end
end

if saveit==1
    saveas(handle,sprintf('%s/(5)no of single for each probability with random radius.pdf', dirname));
end

hold off

% plot no of single for each probability, with constant radius=0.1
hold on
handle = figure(6);
for i=1:3*tmax
    subplot(3,tmax,i);
    if i<=tmax
        bar(p,dataplot(i,3*pmax+1:4*pmax,2));
        if i==1
            xlabel('probability (man)');
            ylabel('# singles');
        end
        xlim([0,1]);
        ylim([0,40]);
        title(sprintf('input size %1.0f',t(i)));
    end
    
    if i<=2*tmax && i>tmax
        bar(p,dataplot(i-tmax,4*pmax+1:5*pmax,2));
        if i==tmax+1
            xlabel('probability (women)');
            ylabel('# singles');
        end
        xlim([0,1]);
        ylim([0,40]);
    end
    
    if i>2*tmax
        bar(p,dataplot(i-2*tmax,5*pmax+1:6*pmax,2));
        if i==2*tmax+1
            xlabel('probability (men/women)');
            ylabel('# singles');
        end
        xlim([0,1]);
        ylim([0,40]);
    end
end
if saveit==1
    saveas(handle,sprintf('%s/(6)no of single for each probability with radius=0.1.pdf', dirname));
end
hold off

% plot no of single for each probability, with constant radius=0.25
hold on
handle = figure(7);
for i=1:3*tmax
    subplot(3,tmax,i);
    if i<=tmax
        bar(p,dataplot(i,6*pmax+1:7*pmax,2));
        if i==1
            xlabel('probability (man)');
            ylabel('# singles');
        end
        xlim([0,1]);
        ylim([0,40]);
        title(sprintf('input size %1.0f',t(i)));
    end
    
    if i<=2*tmax && i>tmax
        bar(p,dataplot(i-tmax,7*pmax+1:8*pmax,2));
        if i==tmax+1
            xlabel('probability (women)');
            ylabel('# singles');
        end
        xlim([0,1]);
        ylim([0,40]);
    end
    
    if i>2*tmax
        bar(p,dataplot(i-2*tmax,8*pmax+1:9*pmax,2));
        if i==2*tmax+1
            xlabel('probability (men/women)');
            ylabel('# singles');
        end
        xlim([0,1]);
        ylim([0,40]);
    end
end
if saveit==1
    saveas(handle,sprintf('%s/(7)no of single for each probability with radius=0.25.pdf', dirname));
end
hold off

% plot no of single for each probability, with constant radius=0.4
hold on
handle = figure(8);
for i=1:3*tmax
    subplot(3,tmax,i);
    if i<=tmax
        bar(p,dataplot(i,9*pmax+1:10*pmax,2));
        if i==1
            xlabel('probability (man)');
            ylabel('# singles');
        end
        xlim([0,1]);
        ylim([0,40]);
        title(sprintf('input size %1.0f',t(i)));
    end
    
    if i<=2*tmax && i>tmax
        bar(p,dataplot(i-tmax,10*pmax+1:11*pmax,2));
        if i==tmax+1
            xlabel('probability (women)');
            ylabel('# singles');
        end
        xlim([0,1]);
        ylim([0,40]);
    end
    
    if i>2*tmax
        bar(p,dataplot(i-2*tmax,11*pmax+1:12*pmax,2));
        if i==2*tmax+1
            xlabel('probability (men/women)');
            ylabel('# singles');
        end
        xlim([0,1]);
        ylim([0,40]);
    end
end
if saveit==1
    saveas(handle,sprintf('%s/(8)no of single for each probability with radius=0.4.pdf', dirname));
end
hold off


%plot no of inst over no of person with random radius
hold on
handle = figure(9);    
for i=1:3*pmax
    subplot(3,pmax,i);
    if i<=pmax
        bar(1:tmax,dataplot(:,i,1));
        xlabel('input size 2^x');
        ylabel('# inst');
        title(sprintf('probability (man) %1.3f %', p(i)));
        xlim([0,11]);
        ylim([0,c]);
    end
    
    if i<=2*pmax && i>pmax
        bar(1:tmax,dataplot(:,i,1));
        xlabel('input size 2^x');
        ylabel('# inst');
        title(sprintf('probability (women) %1.3f %', p(i-pmax)));
        xlim([0,11]);
        ylim([0,c]);
    end
    
    if i>2*pmax
        bar(1:tmax,dataplot(:,i,1));
        xlabel('input size 2^x');
        ylabel('# inst');
        title(sprintf('probability (men/women) %1.3f %', p(i-2*pmax)));
        xlim([0,11]);
        ylim([0,c]);
    end

end
if saveit==1
    saveas(handle,sprintf('%s/(9)no of inst over no of person with random radius.pdf', dirname));
end
hold off

%plot no of inst over no of person with constant radius=0.1
hold on
handle = figure(10);    
for i=1:3*pmax
    subplot(3,pmax,i);
    if i<=pmax
        bar(1:tmax,dataplot(:,3*pmax+i,1));
        xlabel('input size 2^x');
        ylabel('# inst');
        title(sprintf('probability (men) %1.3f %', p(i)));
        xlim([0,11]);
        ylim([0,c]);
    end
    
    if i<=2*pmax && i>pmax
        bar(1:tmax,dataplot(:,3*pmax+i,1));
        xlabel('input size 2^x');
        ylabel('# inst');
        title(sprintf('probability (women) %1.3f %', p(i-pmax)));
        xlim([0,11]);
        ylim([0,c]);
    end
    
    if i>2*pmax
        bar(1:tmax,dataplot(:,3*pmax+i,1));
        xlabel('input size 2^x');
        ylabel('# inst');
        title(sprintf('probability (men/women) %1.3f %', p(i-2*pmax)));
        xlim([0,11]);
        ylim([0,c]);
    end

end
if saveit==1
    saveas(handle,sprintf('%s/(10)no of inst over no of person with radius=0.1.pdf', dirname));
end
hold off

%plot no of inst over no of person with constant radius=0.25
hold on
handle = figure(11);    
for i=1:3*pmax
    subplot(3,pmax,i);
    if i<=pmax
        bar(1:tmax,dataplot(:,6*pmax+i,1));
        xlabel('input size 2^x');
        ylabel('# inst');
        title(sprintf('probability (men) %1.3f %', p(i)));
        xlim([0,11]);
        ylim([0,c]);
    end
    
    if i<=2*pmax && i>pmax
        bar(1:tmax,dataplot(:,6*pmax+i,1));
        xlabel('input size 2^x');
        ylabel('# inst');
        title(sprintf('probability (women) %1.3f %', p(i-pmax)));
        xlim([0,11]);
        ylim([0,c]);
    end
    
    if i>2*pmax
        bar(1:tmax,dataplot(:,6*pmax+i,1));
        xlabel('input size 2^x');
        ylabel('# inst');
        title(sprintf('probability (men/women) %1.3f %', p(i-2*pmax)));
        xlim([0,11]);
        ylim([0,c]);
    end

end
if saveit==1
    saveas(handle,sprintf('%s/(11)no of inst over no of person with radius=0.25.pdf', dirname));
end
hold off


%plot no of inst over no of person with constant radius=0.4
hold on
handle = figure(12);    
for i=1:3*pmax
    subplot(3,pmax,i);
    if i<=pmax
        bar(1:tmax,dataplot(:,9*pmax+i,1));
        xlabel('input size 2^x');
        ylabel('# inst');
        title(sprintf('probability (men) %1.3f %', p(i)));
        xlim([0,11]);
        ylim([0,c]);
    end
    
    if i<=2*pmax && i>pmax
        bar(1:tmax,dataplot(:,9*pmax+i,1));
        xlabel('input size 2^x');
        ylabel('# inst');
        title(sprintf('probability (women) %1.3f %', p(i-pmax)));
        xlim([0,11]);
        ylim([0,c]);
    end
    
    if i>2*pmax
        bar(1:tmax,dataplot(:,9*pmax+i,1));
        xlabel('input size 2^x');
        ylabel('# inst');
        title(sprintf('probability (men/women) %1.3f %', p(i-2*pmax)));
        xlim([0,11]);
        ylim([0,c]);
    end

end
if saveit==1
    saveas(handle,sprintf('%s/(12)no of inst over no of person with radius=0.4.pdf', dirname));
end
hold off


% plot no of inst men/women for each probability, with random radius
hold on
handle = figure(13);
for i=1:3*tmax
    subplot(3,tmax,i);
    if i<=tmax
        bar(p,dataplot(i,1:pmax,1));
        if i==1
            xlabel('probability (man)');
            ylabel('# inst');
        end
        xlim([0,1]);
        ylim([0,c]);
        title(sprintf('input size %1.0f',t(i)));
    end
    
    if i<=2*tmax && i>tmax
        bar(p,dataplot(i-tmax,pmax+1:2*pmax,1));
        if i==tmax+1
            xlabel('probability (women)');
            ylabel('# inst');
        end
        xlim([0,1]);
        ylim([0,c]);
    end
    
    if i>2*tmax
        bar(p,dataplot(i-2*tmax,2*pmax+1:3*pmax,1));
        if i==2*tmax+1
            xlabel('probability (men/women)');
            ylabel('# inst');
        end
        xlim([0,1]);
        ylim([0,c]);
    end

    
end
if saveit==1
    saveas(handle,sprintf('%s/(13)no of inst for each probability, with random radius.pdf', dirname));
end
hold off

% plot no of single for each probability, with constant radius=0.1
hold on
handle = figure(14);
for i=1:3*tmax
    subplot(3,tmax,i);
    if i<=tmax
        bar(p,dataplot(i,3*pmax+1:4*pmax,1));
        if i==1
            xlabel('probability (man)');
            ylabel('# inst');
        end
        xlim([0,1]);
        ylim([0,c]);
        title(sprintf('input size %1.0f',t(i)));
    end
    
    if i<=2*tmax && i>tmax
        bar(p,dataplot(i-tmax,4*pmax+1:5*pmax,1));
        if i==tmax+1
            xlabel('probability (women)');
            ylabel('# inst');
        end
        xlim([0,1]);
        ylim([0,c]);
    end
    
    if i>2*tmax
        bar(p,dataplot(i-2*tmax,5*pmax+1:6*pmax,1));
        if i==2*tmax+1
            xlabel('probability (men/women)');
            ylabel('# singles');
        end
        xlim([0,1]);
        ylim([0,c]);
    end
end
if saveit==1
    saveas(handle,sprintf('%s/(14)no of inst for each probability, with radius=0.1.pdf', dirname));
end
hold off

% plot no of single for each probability, with constant radius=0.25
hold on
handle = figure(15);
for i=1:3*tmax
    subplot(3,tmax,i);
    if i<=tmax
        bar(p,dataplot(i,6*pmax+1:7*pmax,1));
        if i==1
            xlabel('probability (man)');
            ylabel('# inst');
        end
        xlim([0,1]);
        ylim([0,c]);
        title(sprintf('input size %1.0f',t(i)));
    end
    
    if i<=2*tmax && i>tmax
        bar(p,dataplot(i-tmax,7*pmax+1:8*pmax,1));
        if i==tmax+1
            xlabel('probability (women)');
            ylabel('# inst');
        end
        xlim([0,1]);
        ylim([0,c]);
    end
    
    if i>2*tmax
        bar(p,dataplot(i-2*tmax,8*pmax+1:9*pmax,1));
        if i==2*tmax+1
            xlabel('probability (men/women)');
            ylabel('# inst');
        end
        xlim([0,1]);
        ylim([0,c]);
    end
end
if saveit==1
    saveas(handle,sprintf('%s/(15)no of inst for each probability, with radius=0.25.pdf', dirname));
end
hold off

% plot no of single for each probability, with constant radius=0.4
hold on
handle = figure(16);
for i=1:3*tmax
    subplot(3,tmax,i);
    if i<=tmax
        bar(p,dataplot(i,9*pmax+1:10*pmax,1));
        if i==1
            xlabel('probability (man)');
            ylabel('# inst');
        end
        xlim([0,1]);
        ylim([0,c]);
        title(sprintf('input size %1.0f',t(i)));
    end
    
    if i<=2*tmax && i>tmax
        bar(p,dataplot(i-tmax,10*pmax+1:11*pmax,1));
        if i==tmax+1
            xlabel('probability (women)');
            ylabel('# inst');
        end
        xlim([0,1]);
        ylim([0,c]);
    end
    
    if i>2*tmax
        bar(p,dataplot(i-2*tmax,11*pmax+1:12*pmax,1));
        if i==2*tmax+1
            xlabel('probability (men/women)');
            ylabel('# inst');
        end
        xlim([0,1]);
        ylim([0,c]);
    end
end
if saveit==1
    saveas(handle,sprintf('%s/(16)no of inst for each probability, with radius=0.4.pdf', dirname));
end
hold off

% saving
if (saveit==1)
    save(sprintf('%s/data.mat',dirname), 'dataplot');
end
end