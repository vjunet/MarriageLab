function [ engaged, output ] = makeMatch( m, f, changerate, p )
%makeMatch finds engagements for preferences according to Gale-Shapley algorithm
%   
%   men an women encoded as integers from 1 to n
%
%   input:
%   m: preference matrix of the men. Each row corresponds to a man and
%   the elements are the women listed according to his preferences.
%   f: preference matrix of the women. Each row corresponds to a woman and
%   the elements are the men listed according to her preferences.
%   changerate: rate at which preference changes are performed, e. g. if
%   changerate=0.2 then only in 20% of iterations preferences are changed
%   p: change preferences for men (p=1) / women (p=0.5) / both (p=0.5) 
%   
%   dimensions must be correct, m=nxn, f=nxn.
%
%   returns:
%   engaged: nx2 Matrix containing matches
%   output: output data --> 
%   output(1,1): number of instabilities
%   output(1,2): number of singles
%   output(1,3): number of dumps
%   output(1,4): optimality index

% optional test prints
global verbosity
vprintf('mens preferences:\n');
if verbosity~=0 disp(m); end
vprintf('womens preferences:\n')
if verbosity~=0 disp(f); end
% assign local variables
initialm = m;
initialf = f;
n = size(m,1);
n2 = size(f,1);
% make sure dimensions agree
assert(n == size(m,2));
assert(n==n2);
if nargin > 2
    assert(nargin==4);
    assert(changerate<=1);
    assert(changerate>=0);
    assert(~isempty(find(p==[0,1,0.5],1)));
end
% more local variables
freemen = [(1:n)',ones(n,1)]; % column 1= men; column 2= 1 -> man is free, 0 -> man isn't free
engaged = zeros(n,2);% column 1= men; column 2= women
dumped=0; % no of dumps
acceptrate = 0.75; % rate at which unknown nodes are accepted
% main loop
while ~isempty(find(freemen(:,2)==1,1)) % iterate as long as there are free men
    % preference changes
    if nargin > 2 % only if changerate and p are given
        if rand < changerate % change prefs?
            node = randi(n); % node whose prefs to change
            if rand < p % change for men or women
                pref = nonzeros(m(node,:))';
                len = size(pref,2);
                if len>1
                    k = randi([2,len]); % where in pref to change
                    girl1 = pref(k); % the girl to swap
                    i1 = find(initialm(node,:)==girl1,1); % index of girl1 in initialm
                    girl2 = m(node, k-1); % girl to be swapped with
                    i2 = find(initialm(node,:)==girl2,1); % index of girl2 in initialm
                    initialm(node, i2) = girl1;
                    initialm(node, i1) = girl2;
                    m(node, i1) = girl2;
                    m(node, i1-1) = girl1;
                end
            else
                pref = nonzeros(f(node,:))';
                len = size(pref,2);
                if len>1
                    k = randi([2,len]); % where in pref to change
                    man1 = pref(k); % the man to swap
                    i1 = find(initialf(node,:)==man1,1); % index of man1 in initialf
                    man2 = f(node, k-1); % man to be swapped with
                    i2 = find(initialf(node,:)==man2,1); % index of man2 in initialf
                    initialf(node, i2) = man1;
                    initialf(node, i1) = man2;
                    f(node, i1) = man2;
                    f(node, i1-1) = man1;
                end
            end %if_2
            vprintf('preferences changed\n');
        end %if_1
    end
    % +++
    theman = find(freemen(:,2)==1,1); % the first man free on the list
    thegirl = m(theman,1); % his first choice
        if thegirl==0; % theman doesn't know any free girls who want him, he'll be alone :(
            freemen(theman,2)=0;
            engaged(theman,:)=0;
        else
            index = find(engaged(:,2)==thegirl,1); % index of possible fiance of his first choice 
            if(isempty(index) ) % thegirl is free -> theman will be engaged to thegirl
                if isempty(find(f(thegirl,:)==theman,1))
                    vprintf('man %d proposed to women %d, she does not know him\n', theman, thegirl);
                    if rand>acceptrate % man accepts with a certain rate
                        engaged(theman,1) = theman; % make new engagement
                        engaged(theman,2) = thegirl;
                        vprintf('she accepts\nman %d is engaged to girl %d\n', theman, thegirl);
                        freemen(theman,2) = 0; % man is not free anymore
                        f(thegirl,:) = [theman, f(thegirl,1:n-1)]; % update preferences
                        initialf(thegirl,:) = [theman, initialf(thegirl,1:n-1)]; % also in initial matrix (will be used for checking)
                    else
                        vprintf('she declines\n');
                        m(theman,:) = [m(theman,2:n) 0]; % make pref list of theman smaller
                    end % if_4
                else
                    engaged(theman,1) = theman; % make new engagement
                    engaged(theman,2) = thegirl;
                    vprintf('man %d is engaged to girl %d\n', theman, thegirl);
                    freemen(theman,2) = 0; % man is not free anymore
                end % if_3
            else % thegirl is already engaged -> check if thegirl prefers theman to her fiance
                fiance = engaged(index,1); % her fiance
                girlprefers = f(thegirl,:); % pref list of thegirl
                howgirllikestheman=find(girlprefers==theman,1); % themans index on thegirls preferences list
                howgirllikesfiance=find(girlprefers==fiance,1); % fiances index on thegirls preferences list
                if(isempty(howgirllikestheman)) % thegirl doesn't know theman -> thegirl accepts with a certain rate
                    if rand > 0.75
                        % thegirl prefers theman -> update pref list
                        f(thegirl,:) = [f(thegirl,1:howgirllikesfiance), theman, f(thegirl,howgirllikesfiance+1:n-1)];
                        initialf(thegirl,:) = [initialf(thegirl,1:howgirllikesfiance), theman, initialf(thegirl,howgirllikesfiance+1:n-1)]; % also initial
                    end % if_4
                end % if_3
                if(find(girlprefers==theman,1)<find(girlprefers==fiance,1)) % thegirl prefers theman ->change engagement
                    engaged(theman,1) = theman; % change fiance of the girl
                    engaged(theman,2) = thegirl;
                    engaged(fiance,1) = 0; % fiance is free again
                    engaged(fiance,2) = 0;
                    vprintf('girl %d dumped man %d for man %d\n', thegirl, fiance, theman);
                    dumped=dumped+1;
                    freemen(theman,2) = 0;
                    freemen(fiance,2) = 1;
                else
                    m(theman,:) = [m(theman,2:n) 0]; % thegirl prefers her fiance -> take thegirl out of themans preference list
                end % if_3
            end % if_2
        end % if_1
end % while
% result printing (suppressed if verbositiy set to 0)
if dumped==1
    vprintf('\n%d man has been dumped for another\n\n', dumped);
else
    vprintf('\n%d men have been dumped for others\n\n', dumped);
end % if
single = size(find(engaged(:,2)==0),1); % number of single nodes
if single==1
    vprintf('There is %d single man/woman\n\n', single);
else
    vprintf('There are %d single men/women\n\n', single);
end % if
[stable, counter] = checkEngagements(engaged,initialm,initialf); % check the engagements
if (stable)
    vprintf('marriages are stable\n');
else
    vprintf('marriages are unstable\n');
    if counter==1
        vprintf('there is %d unstable mariage\n', counter);
    else
       vprintf('there are %d unstable mariages\n', counter); 
    end % if_2
end % if
% calculate optimality index
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
% set output
output = zeros(1,4);
output(1,1) = counter;
output(1,2) = single;
output(1,3) = dumped;
output(1,4) = opt;
end
