function [ stable ] = checkEngagements( engaged, m, f )
%checkEngagements checks whether a set of engagements is stable
%   dimensions must be correct, m=nxn, f=nxn, engaged=nx2
%   men an women encoded as integers from 1 to n
%   returns true for stable engagements, false otherwise
invengaged = sortrows(engaged,2);
invengaged = invengaged(:,[2 1]);
stable = true;
n = size(m,1);
for he=1:n
    she = engaged(he,2);
    hisindex = find(f(she,:)==he,1);
    herindex = find(m(he,:)==she,1);
    helikesbetter = m(he,1:herindex);
    shelikesbetter = f(she,1:hisindex);
    for i=1:size(helikesbetter)
        girl = helikesbetter(i);
        girlsguy = invengaged(girl,2);
        girllikes = f(girl,:);
        if (find(girllikes==he,1)<find(girllikes==girlsguy,1))
            stable = false;
            fprintf('man %d and woman %d like each other better\n', he, girl);
        end
    end
    for i=1:size(shelikesbetter)
        guy = shelikesbetter(i);
        guysgirl = engaged(guy,2);
        guylikes = m(guy,:);
        if (find(guylikes==she,1)<find(guylikes==guysgirl,1))
            stable = false;
            fprintf('man %d and woman %d like each other better\n', guy, she);
        end
    end
end
end

