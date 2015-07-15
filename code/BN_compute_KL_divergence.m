function KL = BN_compute_KL_divergence(G1, params1, G2, params2, X, val_all)
%COMPUTE_KL_DIVERGENCE Summary of this function goes here
%   Detailed explanation goes here
KL = 0;
[n, d] = size(X);
count = 0;
for i = 1 : n
    % compute the join probability of X(i, :)
    if (check_minus1(X(i, :)) == 0)
        join_prob1 = BN_join_prob(G1, params1, val_all, X(i, :));
        join_prob2 = BN_join_prob(G2, params2, val_all, X(i, :));
        if (join_prob1 == 0)
            log_join_prob1 = 0;
        else
            log_join_prob1 = log(join_prob1);
        end
        if (join_prob2 == 0)
            log_join_prob2 = 0;
        else
            log_join_prob2 = log(join_prob2);
        end
        KL = KL + log_join_prob2 - log_join_prob1;
        count = count + 1;
        
    end
end

KL = KL / count;
KL = -KL;

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