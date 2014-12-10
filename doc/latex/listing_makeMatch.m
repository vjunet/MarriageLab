function [ engaged, stable ] = makeMatch( m, f )
%makeMatch finds engagements for preferences according to Gale-Shapley algorithm
...
freemen = [(1:n)',ones(n,1)];
engaged = zeros(n,2);
while ~isempty(find(freemen(:,2)==1,1))
    theman = find(freemen(:,2)==1,1);
    thegirl = m(theman,1);
    index = find(engaged(:,2)==thegirl,1);
    if(isempty(index) )
        engaged(theman,1) = theman;
        engaged(theman,2) = thegirl;
        freemen(theman,2) = 0;
    else
        fiance = engaged(index,1);
        girlprefers = f(thegirl,:);
        if(find(girlprefers==theman,1)<find(girlprefers==fiance,1))
            engaged(theman,1) = theman;
            engaged(theman,2) = thegirl;
            engaged(fiance,1) = 0;
            engaged(fiance,2) = 0;
            freemen(theman,2) = 0;
            freemen(fiance,2) = 1;
        else
            m(theman,:) = [m(theman,2:n) 0];
        end
    end
end
stable = checkEngagements(engaged,m,f);
...
end


