function [ stable,counter ] = checkEngagements( engaged, m, f )
%checkEngagements checks whether a set of engagements is stable
%   dimensions must be correct, m=nxn, f=nxn, engaged=nx2
%   men an women encoded as integers from 1 to n
%   returns:
%   stable: true for stable engagements, false otherwise
%   counter: the number of unstable mariages

n = size(m,1);%input size

%invert the engaged matrix such that the new matrix has the index of the
%women on the column one and those of their respective husband in row two
invengaged=zeros(n,2);
copy = engaged(:,[2,1]);
i=1;
while i~=n+1
    index=copy(i,1);
    while index==0 && i~=n%find first index that is nonzero
        i=i+1;
        index=copy(i,1);
    end %while
    if index==0 && i==n
        break;
    end %if
    invengaged(index,:)=copy(i,:);
    i=i+1;
end %while

%main loop
stable=true;
he=1;
counter=0;
while he<=n
    she = engaged(he,2); %she is engaged to he
    while she==0 && he~=n   %he is not engaged, so there is no instability ==> check the next man
        he = he+1;
        she = engaged(he,2);
    end %while
    if she==0 % ==> he=n is not engaged ==> nothing to check.
        break;
    end %if
    
    hisindex = find(f(she,:)==he,1);
    herindex = find(m(he,:)==she,1);
    helikesbetter = m(he,1:herindex);
    shelikesbetter = f(she,1:hisindex);
    
    if ~isempty(shelikesbetter) %there is no one on earth she likes better
        for i=1:size(shelikesbetter) %Loop to check if there is unstability for the girl
            guy = shelikesbetter(i); %all the guys she likes better
            guysgirl = engaged(guy,2); %the guy she is engaged to           
            if guysgirl == 0 && ~isempty(find(m(guy,:)== she,1)) %if this guy isn't engaged, then she could be with him ==> unstable, unless he doesn't know her.
               stable = false;
               counter=counter+1;
               fprintf('man %d and woman %d like each other better\n', guy, she);
            else
                guylikes = m(guy,:);   %the ordered preferences of guy
                if (find(guylikes==she,1)<find(guylikes==guysgirl,1)) %if guy also likes she better than his wife ==> unstable
                    stable = false;
                    counter=counter+1;
                    fprintf('man %d and woman %d like each other better\n', guy, she);
                end %if_3
            end %if_2
        end %for
    end %if_1
    
    %now the other way round
    if ~isempty(shelikesbetter) %there is no one on earth he likes better
        for i=1:size(helikesbetter) %Loop to check if there is unstability for the man
            girl = helikesbetter(i); %all the girls he likes better
            girlsguy = invengaged(girl,2); %the girl he is engaged to
            if girlsguy == 0   %if this girl isn't engaged, then she could be with her ==> unstable
                stable=false;
                fprintf('man %d and woman %d like each other better\n', he, girl);
            else
                girllikes = f(girl,:);   %the ordered preferences of girl
                if (find(girllikes==he,1)<find(girllikes==girlsguy,1))  %if guy also likes she better than his wife ==> unstable
                    stable = false;
                    fprintf('man %d and woman %d like each other better\n', he, girl);
                end %if_3
            end %if_2
        end %for
    end %if_1
    
    he=he+1;  %go to the next man
end %while
end