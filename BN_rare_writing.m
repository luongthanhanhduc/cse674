function [min_sample, index] = BN_rare_writing(structure, params, val_all, X)
min_prob = 10000;
[n, d] = size(X);
for i = 1 : n
    if (check_minus1(X(i, :)) == 0)
        prob = BN_join_prob(structure, params, val_all, X(i, :));
        if (prob < min_prob)
            min_prob = prob;
            min_sample = X(i, :);
            index = i;
        end
    end
end

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