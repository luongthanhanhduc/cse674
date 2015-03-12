function [samples] = BN_ancestral_sample(BN, BN_para, vals_all, cnt)
% Input:
%    BN: Bayesian Network, d by d matrix
%    BN_para: Bayesian Network parameter, d array cells, BN_para{ii} is a
%             matrix
%    vals_all: d array cells, vals_all{ii} contains the possible values for
%              attribute ii.
%    cnt: no. of samples needed
% Output:
%    samples: cnt by d matrix.

[d nouse] = size(BN);
samples = -100 * ones(cnt,d);
pa = sum(BN);
vals = zeros(1,d);
for ii = 1:d
    vals(ii) = max(size(vals_all{ii}));
end

for ii = 1:cnt
    roots = find(pa == 0);
    available = ones(1,d);
    available(roots) = 0;
    next = [];
    flag = 1;
    
    % Use tempv to record the indices
    tempv = zeros(1,d);

    % Sample for roots
    for jj = 1:max(size(roots))
        tempv(roots(jj)) = randomsample(BN_para{roots(jj)});
        samples(ii,roots(jj)) = vals_all{roots(jj)}(tempv(roots(jj)));
    end
    
    % BFS
    while flag
        % find all children of roots
        for jj = 1:max(size(roots))
            next = [next find(BN(roots(jj),:) == 1)];
        end
        next = unique(next);
        % Sample by BN
        newnext = [];
        for jj = 1:max(size(next))
            parent = find(BN(:,next(jj)) == 1);
            % Check whether all the parents are sampled
            flag1 = 0;
            for kk = 1:max(size(parent))
                if samples(ii, parent(kk)) == -100
                    flag1 = 1;
                    break;
                end
            end
            if flag1 == 1
                continue;
            end
            
            % Get the corresponding row from table.
            row = tempv(parent(1)) - 1;
            for kk = 2:max(size(parent))
                %row = row * vals(parent(kk)) + (parent(kk)-1);
                row = row * vals(parent(kk)) + (tempv(parent(kk))-1);

            end
            
            row = row + 1;
            
            % Generate the index
            tempv(next(jj)) = randomsample(BN_para{next(jj)}(row,:));
            samples(ii,next(jj)) = vals_all{next(jj)}(tempv(next(jj)));
            
            available(next(jj)) = 0;
            newnext = [newnext next(jj)];
        end
        roots = newnext;
        if sum(available) == 0
            flag = 0;
        end
    end
end

end


