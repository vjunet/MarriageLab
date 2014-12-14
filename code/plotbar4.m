function[]=plotbar4(saveit,dataplot)

 if saveit==1
        dirname = sprintf('data/%s',datestr(now,'yyyy_mm_dd_HH_MM_SS'));
      
        mkdir(dirname);
 end
tmax=11;
t = 2.^(1:tmax);
for i=1:tmax
    dataplot(i,5,2)=dataplot(i,5,2)/t(i);
end
hold on
handle=figure(1);
bar(1:tmax,dataplot(:,5,2));
xlabel('input size 10^x');
ylabel('# singles/size');
title(sprintf('No of singles divided by the corresponding size for random radius'));
hold off
if saveit==1
    saveas(handle,sprintf('%s/No of singles divided by the corresponding size for random radius.pdf', dirname));
end

if (saveit==1)
    save(sprintf('%s/data.mat',dirname));
end
end