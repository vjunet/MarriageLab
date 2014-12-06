function [ stable,counter ] = checkEngagements( engaged, m, f )
%checkEngagements checks whether a set of engagements is stable
%   
%   men an women encoded as integers from 1 to n
%   
%   input:
%   engaged: engagement matrix
%   m,f: preference matrices
%
%   dimensions must be correct, m=nxn, f=nxn, engaged=nx2
%
%   returns:
%   stable: true for stable engagements, false otherwise
%   counter: the number of unstable mariages

n = size(m,1); % input size
% reverse the engaged matrix such that the new matrix has the index of the
% women on the column one and those of their respective husbands in row two
invengaged=zeros(n,2);
copy = engaged(:,[2,1]);
i=1;
while i~=n+1
    index=copy(i,1);
    while index==0 && i~=n % find first index that is nonzero
        i=i+1;
        index=copy(i,1);
    end % while
    if index==0 && i==n
        break;
    end % if
    invengaged(index,:)=copy(i,:);
    i=i+1;
end % while
% assign local variables
stable=true;
he=1;
counter=0;
inst = [0,0];
% main loop
while he<=n
    she = engaged(he,2); % she is engaged to he
    while (she==0 && he~=n) % he is not engaged, so there is no instability -> check the next man
        he = he+1;
        she = engaged(he,2);
    end % while
    if she==0 % -> he=n is not engaged, nothing to check.
        break;
    end %if
    % get indexes in pref lists
    hisindex = find(f(she,:)==he,1);
    herindex = find(m(he,:)==she,1);
    helikesbetter = m(he,1:herindex);
    shelikesbetter = f(she,1:hisindex);
    % check for her
    if ~isempty(shelikesbetter) % there is no one on earth she likes better
        for i=1:size(shelikesbetter) % loop to check if there is unstability for the girl
            guy = shelikesbetter(i); % all the guys she likes better
            guysgirl = engaged(guy,2); % the guy she is engaged to           
            if guysgirl == 0 && ~isempty(find(m(guy,:)== she,1)) % if this guy isn't engaged, then she could be with him -> unstable, unless he doesn't know her.
               stable = false;
               vprintf('man %d and woman %d like each other better\n', guy, she);
               inst = [guy,she;inst];
               
            else
                guylikes = m(guy,:); % the ordered preferences of guy
                if (find(guylikes==she,1)<find(guylikes==guysgirl,1)) % if guy also likes she better than his wife -> unstable
                    stable = false;
                    vprintf('man %d and woman %d like each other better\n', guy, she);
                    inst = [guy,she;inst];
                end % if_3
            end % if_2
        end % for
    end % if_1
    % now the other way round, check for him
    if ~isempty(helikesbetter) % there is no one on earth he likes better
        for i=1:size(helikesbetter) % loop to check if there is unstability for the man
            girl = helikesbetter(i); % all the girls he likes better
            girlsguy = invengaged(girl,2); % the girl he is engaged to
            if girlsguy == 0 && ~isempty(find(f(girl,:)== he,1))% if this girl isn't engaged, then she could be with her -> unstable
                stable = false;
                vprintf('man %d and woman %d like each other better\n', he, girl);
                inst = [he,girl;inst];
            else
                girllikes = f(girl,:);% the ordered preferences of girl
                if (find(girllikes==he,1)<find(girllikes==girlsguy,1)) % if guy also likes she better than his wife -> unstable
                    stable = false;
                    vprintf('man %d and woman %d like each other better\n', he, girl);
                    inst = [he,girl;inst];
                end % if_3
            end % if_2
        end % for
    end % if_1
    
    he=he+1; % go to the next man
end % while
% delete duplicate instabilities
inst = unique(inst, 'rows');
counter = size(inst,1)-1;
end