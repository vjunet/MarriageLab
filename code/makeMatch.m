function [ engaged ] = makeMatch( m, f )
%makeMatch finds engagements for preferences according to Gale-Shapley algorithm
%   men an women encoded as integers from 1 to n
%   m ==> preference matrix of the men. Each row corresponds to a man and
%   the elements are the women listed according to his preferences.
%   f ==> preference matrix of the women. Each row corresponds to a woman and
%   the elements are the men listed according to her preferences.
%   Dimensions must be correct, m=nxn, f=nxn.
%   result is nx2 Matrix containing matches
disp('mens preferences:')
disp(m);
disp('womens preferences:')
disp(f);
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
                engaged(theman,1) = theman;%make new engagement
                engaged(theman,2) = thegirl;
                fprintf('man %d is engaged to girl %d\n', theman, thegirl);
                freemen(theman,2) = 0;%man is not free anymore
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
                    end %if_2
                end %if_1
                if(find(girlprefers==theman,1)<find(girlprefers==fiance,1)) %"thegirl" prefers "theman" ==> change engagement
                    engaged(theman,1) = theman;%change fiance of the girl
                    engaged(theman,2) = thegirl;
                    engaged(fiance,1) = 0;%fiance is free again
                    engaged(fiance,2) = 0;
                    fprintf('girl %d dumped man %d for man %d\n', thegirl, fiance, theman);
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
    fprintf('\n%d man has been dumped for another\n\n', dumped);
else
    fprintf('\n%d men have been dumped for others\n\n', dumped);
end %if
single = size(find(engaged(:,2)==0),1);   %number of single men/women
if single==1
    fprintf('There is %d single man/woman\n\n', single);
else
    fprintf('There are %d single men/women\n\n', single);
end %if
[stable, counter] = checkEngagements(engaged,m,f);%check the engagements
if (stable)
    disp('marriages are stable');
else
    fprintf('marriages are unstable\n');
    if counter==1
        fprintf('there is %d unstable mariage', counter);
    else
       fprintf('there are %d unstable mariages', counter); 
    end %if
end
