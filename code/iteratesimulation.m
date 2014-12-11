function [data, dataplot] = iteratesimulation(saveit, n)
    global verbosity
    verbosity=0;
    
    %!!!tmax, m, p, t, pmax must correspond to simulation2!!!
    assert(~isempty(find(saveit==[0,1],1)));
    seed = rng;
    tmax=11;
    m=12; %number of makeMatch called in simulation2
    p = 0.0:0.25:1.0;
    pmax=size(p,2);
    t = 2.^(1:tmax);
    data = zeros(tmax,m*pmax,4,n);
    dataplot=zeros(tmax,m*pmax,4);
    if saveit==1
        dirname = sprintf('data/%s',datestr(now,'yyyy_mm_dd_HH_MM_SS'));
        mkdir(dirname);
    end
    for i=1:n
        data(:,:,:,i)=simulation2(0);
        dataplot=dataplot+data(:,:,:,i);
        fprintf('iteration %d is done\n', i);
    end
    dataplot=dataplot/(n*1.);
    
% plot no of unstability for each probability, with change preferences for
% men, with random radius
hold on
handle = figure(1);
for i=1:3*tmax
    subplot(3,tmax,i);
    if i<=tmax
        bar(p,dataplot(i,1:pmax,1));
        if i==1
            xlabel('probability (man)');
            ylabel('# instabilities');
        end
        ylim([0,10]);
        xlim([0,1]);
        title(sprintf('input size %1.0f',t(i)));
    end
    
    if i<=2*tmax && i>tmax
        bar(p,dataplot(i-tmax,pmax+1:2*pmax,1));
        if i==tmax+1
            xlabel('probability (women)');
            ylabel('# instabilities');
        end
        ylim([0,10]);
        xlim([0,1]);
    end
    
    if i>2*tmax
        bar(p,dataplot(i-2*tmax,2*pmax+1:3*pmax,1));
        if i==2*tmax+1
            xlabel('probability (men/women)');
            ylabel('# instabilities');
        end
        ylim([0,10]);
        xlim([0,1]);
    end

    
end
if saveit==1
    saveas(handle,sprintf('%s/(1)instability with random radius.pdf', dirname));
end
hold off

% plot no of unstability for each probability, with change preferences for
% men, with constant radius=0.1
hold on
handle = figure(2);
for i=1:3*tmax
    subplot(3,tmax,i);
    if i<=tmax
        bar(p,dataplot(i,3*pmax+1:4*pmax,1));
        if i==1
            xlabel('probability (man)');
            ylabel('# instabilities');
        end
        ylim([0,10]);
        xlim([0,1]);
        title(sprintf('input size %1.0f',t(i)));
    end
    
    if i<=2*tmax && i>tmax
        bar(p,dataplot(i-tmax,4*pmax+1:5*pmax,1));
        if i==tmax+1
            xlabel('probability (women)');
            ylabel('# instabilities');
        end
        ylim([0,10]);
        xlim([0,1]);
    end
    
    if i>2*tmax
        bar(p,dataplot(i-2*tmax,5*pmax+1:6*pmax,1));
        if i==2*tmax+1
            xlabel('probability (men/women)');
            ylabel('# instabilities');
        end
        ylim([0,10]);
        xlim([0,1]);
    end
end
if saveit==1
    saveas(handle,sprintf('%s/(2)instability with constant radius=0.1.pdf', dirname));
end
hold off

% plot no of unstability for each probability, with change preferences for
% men, with constant radius=0.25
hold on
handle = figure(3);
for i=1:3*tmax
    subplot(3,tmax,i);
    if i<=tmax
        bar(p,dataplot(i,6*pmax+1:7*pmax,1));
        if i==1
            xlabel('probability (man)');
            ylabel('# instabilities');
        end
        ylim([0,10]);
        xlim([0,1]);
        title(sprintf('input size %1.0f',t(i)));
    end
    
    if i<=2*tmax && i>tmax
        bar(p,dataplot(i-tmax,7*pmax+1:8*pmax,1));
        if i==tmax+1
            xlabel('probability (women)');
            ylabel('# instabilities');
        end
        ylim([0,10]);
        xlim([0,1]);
    end
    
    if i>2*tmax
        bar(p,dataplot(i-2*tmax,8*pmax+1:9*pmax,1));
        if i==2*tmax+1
            xlabel('probability (men/women)');
            ylabel('# instabilities');
        end
        ylim([0,10]);
        xlim([0,1]);
    end
end
if saveit==1
    saveas(handle,sprintf('%s/(3)instability with constant radius=0.25.pdf', dirname));
end
hold off


% plot no of unstability for each probability, with change preferences for
% men, with constant radius=0.4
hold on
handle = figure(4);
for i=1:3*tmax
    subplot(3,tmax,i);
    if i<=tmax
        bar(p,dataplot(i,9*pmax+1:10*pmax,1));
        if i==1
            xlabel('probability (man)');
            ylabel('# instabilities');
        end
        ylim([0,10]);
        xlim([0,1]);
        title(sprintf('input size %1.0f',t(i)));
    end
    
    if i<=2*tmax && i>tmax
        bar(p,dataplot(i-tmax,10*pmax+1:11*pmax,1));
        if i==tmax+1
            xlabel('probability (women)');
            ylabel('# instabilities');
        end
        ylim([0,10]);
        xlim([0,1]);
    end
    
    if i>2*tmax
        bar(p,dataplot(i-2*tmax,11*pmax+1:12*pmax,1));
        if i==2*tmax+1
            xlabel('probability (men/women)');
            ylabel('# instabilities');
        end
        ylim([0,10]);
        xlim([0,1]);
    end
end

if saveit==1
    saveas(handle,sprintf('%s/(4)instability with constant radius=0.4.pdf', dirname));
end
hold off


    
% plot no of dumps for each probability, with change preferences for
% men, with random radius
hold on
handle = figure(5);
for i=1:3*tmax
    subplot(3,tmax,i);
    if i<=tmax
        bar(p,dataplot(i,1:pmax,3));
        if i==1
            xlabel('probability (man)');
            ylabel('# dumps');
        end
        xlim([0,1]);
        title(sprintf('input size %1.0f',t(i)));
    end
    
    if i<=2*tmax && i>tmax
        bar(p,dataplot(i-tmax,pmax+1:2*pmax,3));
        if i==tmax+1
            xlabel('probability (women)');
            ylabel('# dumps');
        end
        xlim([0,1]);
    end
    
    if i>2*tmax
        bar(p,dataplot(i-2*tmax,2*pmax+1:3*pmax,3));
        if i==2*tmax+1
            xlabel('probability (men/women)');
            ylabel('# dumps');
        end
        xlim([0,1]);
    end

    
end
if saveit==1
    saveas(handle,sprintf('%s/(5)dumps with random radius.pdf', dirname));
end
hold off

% plot no of dumps for each probability, with change preferences for
% men, with constant radius=0.1
hold on
handle = figure(6);
for i=1:3*tmax
    subplot(3,tmax,i);
    if i<=tmax
        bar(p,dataplot(i,3*pmax+1:4*pmax,3));
        if i==1
            xlabel('probability (man)');
            ylabel('# dumps');
        end
        xlim([0,1]);
        title(sprintf('input size %1.0f',t(i)));
    end
    
    if i<=2*tmax && i>tmax
        bar(p,dataplot(i-tmax,4*pmax+1:5*pmax,3));
        if i==tmax+1
            xlabel('probability (women)');
            ylabel('# dumps');
        end
        xlim([0,1]);
    end
    
    if i>2*tmax
        bar(p,dataplot(i-2*tmax,5*pmax+1:6*pmax,3));
        if i==2*tmax+1
            xlabel('probability (men/women)');
            ylabel('# dumps');
        end
        xlim([0,1]);
    end
end
if saveit==1
    saveas(handle,sprintf('%s/(6)dumps with constant radius=0.1.pdf', dirname));
end
hold off

% plot no of dumps for each probability, with change preferences for
% men, with constant radius=0.25
hold on
handle = figure(7);
for i=1:3*tmax
    subplot(3,tmax,i);
    if i<=tmax
        bar(p,dataplot(i,6*pmax+1:7*pmax,3));
        if i==1
            xlabel('probability (man)');
            ylabel('# dumps');
        end
        xlim([0,1]);
        title(sprintf('input size %1.0f',t(i)));
    end
    
    if i<=2*tmax && i>tmax
        bar(p,dataplot(i-tmax,7*pmax+1:8*pmax,3));
        if i==tmax+1
            xlabel('probability (women)');
            ylabel('# dumps');
        end
        xlim([0,1]);
    end
    
    if i>2*tmax
        bar(p,dataplot(i-2*tmax,8*pmax+1:9*pmax,3));
        if i==2*tmax+1
            xlabel('probability (men/women)');
            ylabel('# dumps');
        end
        xlim([0,1]);
    end
end
if saveit==1
    saveas(handle,sprintf('%s/(7)dumps with constant radius=0.25.pdf', dirname));
end
hold off


% plot no of dumps for each probability, with change preferences for
% men, with constant radius=0.4
hold on
handle = figure(8);
for i=1:3*tmax
    subplot(3,tmax,i);
    if i<=tmax
        bar(p,dataplot(i,9*pmax+1:10*pmax,3));
        if i==1
            xlabel('probability (man)');
            ylabel('# dumps');
        end
        xlim([0,1]);
        title(sprintf('input size %1.0f',t(i)));
    end
    
    if i<=2*tmax && i>tmax
        bar(p,dataplot(i-tmax,10*pmax+1:11*pmax,3));
        if i==tmax+1
            xlabel('probability (women)');
            ylabel('# dumps');
        end
        xlim([0,1]);
    end
    
    if i>2*tmax
        bar(p,dataplot(i-2*tmax,11*pmax+1:12*pmax,3));
        if i==2*tmax+1
            xlabel('probability (men/women)');
            ylabel('# dumps');
        end
        xlim([0,1]);
    end
end

if saveit==1
    saveas(handle,sprintf('%s/(8)dumps with constant radius=0.4.pdf', dirname));
end
hold off

% plot no of single men/women for each probability, with change preferences for
% men, with random radius
hold on
handle = figure(9);
for i=1:3*tmax
    subplot(3,tmax,i);
    if i<=tmax
        bar(p,dataplot(i,1:pmax,2));
        if i==1
            xlabel('probability (man)');
            ylabel('# singles');
        end
        xlim([0,1]);
        title(sprintf('input size %1.0f',t(i)));
    end
    
    if i<=2*tmax && i>tmax
        bar(p,dataplot(i-tmax,pmax+1:2*pmax,2));
        if i==tmax+1
            xlabel('probability (women)');
            ylabel('# singles');
        end
        xlim([0,1]);
    end
    
    if i>2*tmax
        bar(p,dataplot(i-2*tmax,2*pmax+1:3*pmax,2));
        if i==2*tmax+1
            xlabel('probability (men/women)');
            ylabel('# singles');
        end
        xlim([0,1]);
    end

    
end
if saveit==1
    saveas(handle,sprintf('%s/(9) singles with random radius.pdf', dirname));
end
hold off

% plot no of single for each probability, with change preferences for
% men, with constant radius=0.1
hold on
handle = figure(10);
for i=1:3*tmax
    subplot(3,tmax,i);
    if i<=tmax
        bar(p,dataplot(i,3*pmax+1:4*pmax,2));
        if i==1
            xlabel('probability (man)');
            ylabel('# singles');
        end
        xlim([0,1]);
        title(sprintf('input size %1.0f',t(i)));
    end
    
    if i<=2*tmax && i>tmax
        bar(p,dataplot(i-tmax,4*pmax+1:5*pmax,2));
        if i==tmax+1
            xlabel('probability (women)');
            ylabel('# singles');
        end
        xlim([0,1]);
    end
    
    if i>2*tmax
        bar(p,dataplot(i-2*tmax,5*pmax+1:6*pmax,2));
        if i==2*tmax+1
            xlabel('probability (men/women)');
            ylabel('# singles');
        end
        xlim([0,1]);
    end
end
if saveit==1
    saveas(handle,sprintf('%s/(10)singles with constant radius=0.1.pdf', dirname));
end
hold off

% plot no of single for each probability, with change preferences for
% men, with constant radius=0.25
hold on
handle = figure(11);
for i=1:3*tmax
    subplot(3,tmax,i);
    if i<=tmax
        bar(p,dataplot(i,6*pmax+1:7*pmax,2));
        if i==1
            xlabel('probability (man)');
            ylabel('# singles');
        end
        xlim([0,1]);
        title(sprintf('input size %1.0f',t(i)));
    end
    
    if i<=2*tmax && i>tmax
        bar(p,dataplot(i-tmax,7*pmax+1:8*pmax,2));
        if i==tmax+1
            xlabel('probability (women)');
            ylabel('# singles');
        end
        xlim([0,1]);
    end
    
    if i>2*tmax
        bar(p,dataplot(i-2*tmax,8*pmax+1:9*pmax,2));
        if i==2*tmax+1
            xlabel('probability (men/women)');
            ylabel('# singles');
        end
        xlim([0,1]);
    end
end
if saveit==1
    saveas(handle,sprintf('%s/(11)singles with constant radius=0.25.pdf', dirname));
end
hold off


% plot no of single for each probability, with change preferences for
% men, with constant radius=0.4
hold on
handle = figure(12);
for i=1:3*tmax
    subplot(3,tmax,i);
    if i<=tmax
        bar(p,dataplot(i,9*pmax+1:10*pmax,2));
        if i==1
            xlabel('probability (man)');
            ylabel('# singles');
        end
        xlim([0,1]);
        title(sprintf('input size %1.0f',t(i)));
    end
    
    if i<=2*tmax && i>tmax
        bar(p,dataplot(i-tmax,10*pmax+1:11*pmax,2));
        if i==tmax+1
            xlabel('probability (women)');
            ylabel('# singles');
        end
        xlim([0,1]);
    end
    
    if i>2*tmax
        bar(p,dataplot(i-2*tmax,11*pmax+1:12*pmax,2));
        if i==2*tmax+1
            xlabel('probability (men/women)');
            ylabel('# singles');
        end
        xlim([0,1]);
    end
end

if saveit==1
    saveas(handle,sprintf('%s/(12)singles with constant radius=0.4.pdf', dirname));
end
hold off

%plot no of single over no of person with  random radius
hold on
handle = figure(13);    
for i=1:3*pmax
    subplot(3,pmax,i);
    if i<=pmax
        bar(1:tmax,dataplot(:,i,2));
        xlabel('input size 10^x');
        ylabel('# singles');
        title(sprintf('probability (man) %1.3f %', p(i)));
    end
    
    if i<=2*pmax && i>pmax
        bar(1:tmax,dataplot(:,i,2));
        xlabel('input size 10^x');
        ylabel('# singles');
        title(sprintf('probability (women) %1.3f %', p(i-pmax)));
    end
    
    if i>2*pmax
        bar(1:tmax,dataplot(:,i,2));
        xlabel('input size 10^x');
        ylabel('# singles');
        title(sprintf('probability (man/women) %1.3f %', p(i-2*pmax)));
    end

end

if saveit==1
    saveas(handle,sprintf('%s/(13)singles over person with random radius.pdf', dirname));
end
hold off



%plot no of single over no of person with radius=0.1
hold on
handle = figure(14);    
for i=1:3*pmax
    subplot(3,pmax,i);
    if i<=pmax
        bar(1:tmax,dataplot(:,3*pmax+i,2));
        xlabel('input size 10^x');
        ylabel('# singles');
        title(sprintf('probability (man) %1.3f %', p(i)));
    end
    
    if i<=2*pmax && i>pmax
        bar(1:tmax,dataplot(:,3*pmax+i,2));
        xlabel('input size 10^x');
        ylabel('# singles');
        title(sprintf('probability (women) %1.3f %', p(i-pmax)));
    end
    
    if i>2*pmax
        bar(1:tmax,dataplot(:,3*pmax+i,2));
        xlabel('input size 10^x');
        ylabel('# singles');
        title(sprintf('probability (man/women) %1.3f %', p(i-2*pmax)));
    end

end

if saveit==1
    saveas(handle,sprintf('%s/(14)singles over person with radius=0.1.pdf', dirname));
end
hold off



%plot no of single over no of person with radius=0.25
hold on
handle = figure(15);    
for i=1:3*pmax
    subplot(3,pmax,i);
    if i<=pmax
        bar(1:tmax,dataplot(:,6*pmax+i,2));
        xlabel('input size 10^x');
        ylabel('# singles');
        title(sprintf('probability (man) %1.3f %', p(i)));
    end
    
    if i<=2*pmax && i>pmax
        bar(1:tmax,dataplot(:,6*pmax+i,2));
        xlabel('input size 10^x');
        ylabel('# singles');
        title(sprintf('probability (women) %1.3f %', p(i-pmax)));
    end
    
    if i>2*pmax
        bar(1:tmax,dataplot(:,6*pmax+i,2));
        xlabel('input size 10^x');
        ylabel('# singles');
        title(sprintf('probability (man/women) %1.3f %', p(i-2*pmax)));
    end

end

if saveit==1
    saveas(handle,sprintf('%s/(15)singles over person with radius=0.25.pdf', dirname));
end
hold off

%plot no of single over no of person with radius=0.4
hold on
handle = figure(16);    
for i=1:3*pmax
    subplot(3,pmax,i);
    if i<=pmax
        bar(1:tmax,dataplot(:,9*pmax+i,2));
        xlabel('input size 10^x');
        ylabel('# singles');
        title(sprintf('probability (man) %1.3f %', p(i)));
    end
    
    if i<=2*pmax && i>pmax
        bar(1:tmax,dataplot(:,9*pmax+i,2));
        xlabel('input size 10^x');
        ylabel('# singles');
        title(sprintf('probability (women) %1.3f %', p(i-pmax)));
    end
    
    if i>2*pmax
        bar(1:tmax,dataplot(:,9*pmax+i,2));
        xlabel('input size 10^x');
        ylabel('# singles');
        title(sprintf('probability (men/women) %1.3f %', p(i-2*pmax)));
    end

end

if saveit==1
    saveas(handle,sprintf('%s/(16)singles over person with radius=0.4.pdf', dirname));
end
hold off



% saving
if (saveit==1)
    save(sprintf('%s/data.mat',dirname),'data','dataplot','seed');
end

end