function [entropy] = BN_compute_entropy(BN_structure, BN_params, val_all, X)
[n, d] = size(X);
entropy = 0;
count = 0;
for i = 1 : n
    % compute the join probability of X(i, :)
    if (check_minus1(X(i, :)) == 0)
        join_prob = BN_join_prob(BN_structure, BN_params, val_all, X(i, :));
        if (join_prob ~= 0)
            entropy = entropy + log(join_prob);
            count = count + 1;
        end
    end
end

entropy = - entropy / count;

end

function yes = check_minus1(x)
yes = 0;
for i = 1 : max(size(x))
    if (x(i) == -1)
        yes = 1;
        break;
    end
end

end