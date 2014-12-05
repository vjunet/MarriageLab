%simulation

% simulate match making
% n is 2et, t from 1 to 6
% radius is either constant or random
%   when constant, in 0.1:0.05:0.5
% frequency

global verbosity
verbosity = 0;

tmax = 6;
t = 2.^(1:tmax);
r = 0.1:0.05:0.5;
data = zeros(tmax,10,4);

% radius random
for i=1:tmax
   n = t(i);
   [a,b] = generatePlane(n,2);
   [x,y] = makeMatch(a,b);
   data(i,10,:) = y;
end

% radius const
for i=1:tmax
    for j=1:9
        n = t(i);
        radius = r(j);
        [a,b] = generatePlane(n,1,radius);
        [x,y] = makeMatch(a,b);
        data(i,j,:) = y;
    end
end
% plot optimality index for each radius
hold on
figure(1);
col = hsv(10);
%set(groot,'defaultAxesLineStyleOrder',{'-*',':','o'});
for i=1:10
    plot(1:tmax,data(:,i,4),'color', col(i,:), 'marker', '*','linestyle','--');
    title('optimality index for for different radiuses');
    
end
arr = ['r','a','n','d','o','m',' ',' ',' ',' ',' ',' '];
xlabel('input size 2^x');
ylabel('optimality index');
legend([num2str(r','radius %1.3f');arr]);
hold off

% plot no of dumps for each radius
figure(2);
for i=1:10
    subplot(3,4,i);
    bar(1:tmax,data(:,i,3));
    xlabel('input size 2^x');
    ylabel('number of dumps');
    ylim([0,100]);
    if i~=10
        title(sprintf('plotting #dumps for radius %1.3f',r(i)));
    else
        title('plotting #dumps for radius random');
    end
    
end

disp(data);
