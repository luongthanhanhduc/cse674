function [BN_para] = BN_parameters(X, BN, vals_all)
% Input:
%    X: input data, n by d matrix.
%    BN: Bayesian Network, d by d 0-1 matrix.
% Output:
%    BN_para: Bayesian Network parameter, one matrix for each node who has
%             parents.

[n d] = size(X);
for ii = 1:d
    BN(ii,ii) = 0;
end
vals = zeros(1,d);

%vals_all = cell(1,d);
for ii = 1:d
%   vals_all{ii} = remove_minus1(unique(X(:,ii)));
   vals(ii) = size(vals_all{ii},1);
end

parents = sum(BN);
% % Get maximum no. of parents one node can have.
% pa_size = max(parents);
% Get the no. of nodes who don't have a parent
% roots = sum(bsxfun(@eq, parents, 0));
BN_para = cell(1,d);

for ii = 1:d
    % Create a table for node ii if it doesn't have parents
    if parents(ii) == 0
        table = zeros(1, vals(ii));
        su = 0;
        for jj = 1: vals(ii)
            nii = cnt_occurance(X(:,ii),vals_all{ii}(jj));
            su = su + nii;
            table(jj) = nii;
        end
        table = table/su;
        BN_para{ii} = table;
        continue;
    end
    
    % Create a table for node ii if it has parents
    % Compute the size of the table
    pa = find(BN(:,ii) == 1);
    cnt_pa = sum(BN(:,ii));
    table_size = 1;
    for jj = 1:size(pa,1)
        table_size = table_size * vals(pa(jj));
    end
    table = zeros(table_size, vals(ii));
    
    % Create a table for all possible parents combination
    interval = ones(size(pa,1),1);
    repeat = ones(cnt_pa,1);
    for jj = 2:size(pa,1)
        repeat(jj) = repeat(jj-1)*vals(pa(jj-1));
    end
    for jj = (cnt_pa-1):-1:1
        interval(jj) = interval(jj+1)*vals(pa(jj+1));
    end
    table_y = zeros(table_size, cnt_pa);
    for jj = 1:cnt_pa
        for kk = 1:repeat(jj)
            for ll = 1:vals(pa(jj))
                for mm = 1:interval(jj)
                    table_y((kk-1)*table_size/repeat(jj) + (ll-1)*interval(jj) + mm,jj) = vals_all{pa(jj)}(ll);
                end
            end
        end
    end
    
    % Fill in the table
    for jj = 1:table_size
        npa = cnt_occurance(X(:,pa), table_y(jj,:));
        if npa == 0
            table(jj,:) = zeros(1,vals(ii));
            continue;
        end
        for kk = 1:vals(ii)
            npax = cnt_occurance(X(:,[pa; ii]), [table_y(jj,:) vals_all{ii}(kk)]);
            table(jj,kk) = npax/npa;
        end
    end
    BN_para{ii} = table;
end

end

