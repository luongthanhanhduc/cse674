function [min_sample, min_score] = BN_common_writing(structure, params, val_all, X, mean_sample)
min_score = 10000;
[n, d] = size(X);
for i = 1 : n
    if (check_minus1(X(i, :)) == 0)
        score = 0;
        for j = 1 : d
            score = score + (abs(X(i, j) - mean_sample(j)) / max(val_all{j}));
        end
        score = score / d;
        if (score < min_score)
            min_score = score;
            min_sample = X(i, :);
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
