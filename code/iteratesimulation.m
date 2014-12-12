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



% saving
if (saveit==1)
    save(sprintf('%s/data.mat',dirname),'data','dataplot','seed');
end

end