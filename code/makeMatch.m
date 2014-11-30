function [ engaged, output ] = makeMatch( m, f )
%makeMatch finds engagements for preferences according to Gale-Shapley algorithm
%   men an women encoded as integers from 1 to n
%   m ==> preference matrix of the men. Each row corresponds to a man and
%   the elements are the women listed according to his preferences.
%   f ==> preference matrix of the women. Each row corresponds to a woman and
%   the elements are the men listed according to her preferences.
%   Dimensions must be correct, m=nxn, f=nxn.
%   returns:
%   engaged: nx2 Matrix containing matches
%   output: output data --> 
%   output(1,1): number of instabilities
%   output(1,2): number of singles
%   output(1,3): number of dumps
%   output(1,4): optimality index
global verbosity
vprintf('mens preferences:');
if verbosity~=0 disp(m); end
vprintf('womens preferences:')
if verbosity~=0 disp(f); end
initialm = m;
initialf = f;
n = size(m,1);
n2 = size(f,1);
assert(n == size(m,2));
assert(n==n2);%make sure dimensions agree
freemen = [(1:n)',ones(n,1)]; %column 1= men; column 2: 1==>man is free, 0==>man isn't free
engaged = zeros(n,2);%column 1=men; column 2=women
dumped=0;%no of dumps
while ~isempty(find(freemen(:,2)==1,1))
    theman = find(freemen(:,2)==1,1); %the first man free on the list
    thegirl = m(theman,1);%his first choice
        if thegirl==0; %"theman" doesn't know any free girls who want him, he'll be alone :(
            freemen(theman,2)=0;
            engaged(theman,:)=0;
        else
            index = find(engaged(:,2)==thegirl,1);%index of possible fiance of his first choice 
            if(isempty(index) ) %"thegirl" is free ==> "theman" will be engaged to "thegirl".
                if isempty(find(f(thegirl,:)==theman,1))
                    vprintf('man %d proposed to women %d, she does not know him\n', theman, thegirl);
                    if rand>0.5
                        engaged(theman,1) = theman;%make new engagement
                        engaged(theman,2) = thegirl;
                        vprintf('she accepts\nman %d is engaged to girl %d\n', theman, thegirl);
                        freemen(theman,2) = 0;%man is not free anymore
                        f(thegirl,:) = [theman, f(thegirl,1:n-1)];
                        initialf(thegirl,:) = [theman, initialf(thegirl,1:n-1)];
                    else
                        vprintf('she declines\n');
                        m(theman,:) = [m(theman,2:n) 0];
                    end
                else
                    engaged(theman,1) = theman;%make new engagement
                    engaged(theman,2) = thegirl;
                    vprintf('man %d is engaged to girl %d\n', theman, thegirl);
                    freemen(theman,2) = 0;%man is not free anymore
                end
            else %"thegirl" is already engaged ==> check if "thegirl" prefers "theman" to her "fiance"
                fiance = engaged(index,1);%fiance of first choice
                girlprefers = f(thegirl,:);
                howgirllikestheman=find(girlprefers==theman,1); %"theman"'s number on "thegirl" preferences list
                howgirllikesfiance=find(girlprefers==fiance,1); %"fiance"'s number on "thegirl" preferences list
                if(isempty(howgirllikestheman)) %"thegirl" doesn't know "theman" ==> "thegirl" choose beetwen "theman" and her "fiance" (the choice is random, with a bigger chance for the fiance)
                    if rand > 0.75
                        %"thegirl" prefers "theman" ==> actualize
                        %preference list of "the girl"
                        f(thegirl,:) = [f(thegirl,1:howgirllikesfiance), theman, f(thegirl,howgirllikesfiance+1:n-1)];
                        initialf(thegirl,:) = [initialf(thegirl,1:howgirllikesfiance), theman, initialf(thegirl,howgirllikesfiance+1:n-1)];
                    end %if_2
                end %if_1
                if(find(girlprefers==theman,1)<find(girlprefers==fiance,1)) %"thegirl" prefers "theman" ==> change engagement
                    engaged(theman,1) = theman;%change fiance of the girl
                    engaged(theman,2) = thegirl;
                    engaged(fiance,1) = 0;%fiance is free again
                    engaged(fiance,2) = 0;
                    vprintf('girl %d dumped man %d for man %d\n', thegirl, fiance, theman);
                    dumped=dumped+1;
                    freemen(theman,2) = 0;
                    freemen(fiance,2) = 1;
                else
                    m(theman,:) = [m(theman,2:n) 0];%"thegirl" prefers her fiance ==> take "thegirl" out of "theman"'s preference list
                end %if_3
            end %if_2
        end %if_1
end %while

if dumped==1
    vprintf('\n%d man has been dumped for another\n\n', dumped);
else
    vprintf('\n%d men have been dumped for others\n\n', dumped);
end %if
single = size(find(engaged(:,2)==0),1);   %number of single men/women
if single==1
    vprintf('There is %d single man/woman\n\n', single);
else
    vprintf('There are %d single men/women\n\n', single);
end %if
[stable, counter] = checkEngagements(engaged,initialm,initialf);%check the engagements
if (stable)
    vprintf('marriages are stable');
else
    vprintf('marriages are unstable\n');
    if counter==1
        vprintf('there is %d unstable mariage\n', counter);
    else
       vprintf('there are %d unstable mariages\n', counter); 
    end %if
end
%optimality index
opt = 0;
for i = 1:n
    he = i;
    she = engaged(he,2);
    if she~=0
        hisindex = find(initialf(she,:)==he,1);
        herindex = find(initialm(he,:)==she,1);
    else
        hisindex = n;
        herindex = n;
    end
    opt = opt + hisindex + herindex;
end
opt = opt/(2*n*n);
vprintf('optimality index is %1.2f\n',opt);
output = zeros(1,4);
output(1,1) = counter;
output(1,2) = single;
output(1,3) = dumped;
output(1,4) = opt;
end
