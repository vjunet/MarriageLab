while he<=n
    she = engaged(he,2);
    % make sure that the man has a partner i. e. she is not 0
    % otherwise continue because nothing to check
    ...
    hisindex = find(f(she,:)==he,1);
    herindex = find(m(he,:)==she,1);
    helikesbetter = m(he,1:herindex);
    shelikesbetter = f(she,1:hisindex);
    % check for her
    for i=1:size(shelikesbetter)
        guy = shelikesbetter(i);
        guysgirl = engaged(guy,2);
        guylikes = m(guy,:);
        if (find(guylikes==she,1)<find(guylikes==guysgirl,1))
            stable = false;
        end
    end
    % check for him
    ...
    he=he+1;
end



