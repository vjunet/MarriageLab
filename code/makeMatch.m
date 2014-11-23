function [ engaged ] = makeMatch( m, f )
%makeMatch finds engagements for preferences according to Gale-Shapley algorithm
%   dimensions must be correct, m=nxn, f=nxn
%   men an women encoded as integers from 1 to n
%   result is nx2 Matrix containing matches
disp('mens preferences:')
disp(m);
disp('womens preferences:')
disp(f);
n = size(m,1);
n2 = size(f,1);
assert(n == size(m,2));
assert(n==n2);
freemen = [(1:n)',ones(n,1)];
engaged = zeros(n,2);%1=men, 2=women
while ~isempty(find(freemen(:,2)==1,1))
    theman = find(freemen(:,2)==1,1);
    thegirl = m(theman,1);%his first choice
    if (thegirl==0)
        freemen(theman,2)=0;%has no partner
        continue;
    end
    index = find(engaged(:,2)==thegirl,1);%index of possible fiance of his first choice 
    if(isempty(index) )
        engaged(theman,1) = theman;%make new engagement
        engaged(theman,2) = thegirl;
        fprintf('%d engaged to %d\n', theman, thegirl);
        freemen(theman,2) = 0;%man is not free anymore
    else
        fiance = engaged(index,1);%fiance of first choice
        girlprefers = f(thegirl,:);
        if(find(girlprefers==theman,1)<find(girlprefers==fiance,1))
            engaged(theman,1) = theman;%change fiance of the girl
            engaged(theman,2) = thegirl;
            engaged(fiance,1) = 0;%fiance is free again
            engaged(fiance,2) = 0;
            fprintf('%d dumped %d for %d\n', thegirl, fiance, theman);
            freemen(theman,2) = 0;
            freemen(fiance,2) = 1;
        else
            m(theman,:) = [m(theman,2:n) 0];%make preference list of the man smaller
        end
    end
end
stable = checkEngagements(engaged,m,f);%check the engagements
if (stable)
    disp('marriages are stable');
else
    disp('marriages are unstable');
end

