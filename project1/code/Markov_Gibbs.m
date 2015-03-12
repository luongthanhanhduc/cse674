function samples = Markov_Gibbs(M, theta, val_all, index2, index3, n_sample)
[d, temp] = size(M);
samples = -1 * ones(n_sample, d);

for i = 1 : d
    samples(1, i) = val_all{i}(1);
end
for i = 2 : n_sample
    for j = 1 : d
        cur_sample = samples(i-1, :);
        temp = zeros(length(val_all{j}), 1);
        prob = zeros(length(val_all{j}), 1);
        for k = 1 : length(val_all{j})
            cur_sample(j) = val_all{j}(k);
            feature = compute_feature(theta, cur_sample, val_all, index2, index3);
            temp(k) = sum_feature(theta, feature);
        end
        for k = 1 : length(val_all{j})
            prob(k) = exp(temp(k) - logsumexp(temp));
        end
        ind = randomsample(prob);
        samples(i, j) = val_all{j}(ind);
    end
end

end

function val = sum_feature(theta, feature)
val = 0;
[size_theta, temp] = size(theta);
for i = 1 : size_theta
    val = val + sum(feature{i} .* theta{i});
end

end

function feature = compute_feature(theta, sample, val_all, index2, index3)
d = length(sample);
size_theta = size(theta, 1);

feature = cell(size_theta, 1);
for i = 1 : size_theta
    feature{i} = zeros(size(theta{i}));
end

% clique of size 1
for j = 1 : d
    ind = -1;
    for k = 1 : length(val_all{j})
        if (sample(j) == val_all{j}(k))
            ind = k;
            break;
        end
    end
    feature{j}(ind) = 1;
end
% clique of size 2
for j = 1 : size(index2, 1)
    var1 = index2(j, 1);
    var2 = index2(j, 2);
    ind1 = -1;
    for k = 1 : length(val_all{var1})
        if (sample(var1) == val_all{var1}(k))
            ind1 = k;
            break;
        end
    end
    ind2 = -1;
    for k = 1 : length(val_all{var2})
        if (sample(var2) == val_all{var2}(k))
            ind2 = k;
            break;
        end
    end
    row_index = (ind1 - 1) * length(val_all{var2}) + ind2;
    feature{j + d}(row_index) = 1;
end
% clique of size 3
for j = 1 : size(index3, 1)
    var1 = index3(j, 1);
    var2 = index3(j, 2);
    var3 = index3(j, 3);
    ind1 = -1;
    for k = 1 : length(val_all{var1})
        if (sample(var1) == val_all{var1}(k))
            ind1 = k;
            break;
        end
    end
    ind2 = -1;
    for k = 1 : length(val_all{var2})
        if (sample(var2) == val_all{var2}(k))
            ind2 = k;
            break;
        end
    end
    ind3 = -1;
    for k = 1 : length(val_all{var3})
        if (sample(var3) == val_all{var3}(k))
            ind3 = k;
            break;
        end
    end
    row_index = (ind1 - 1) * length(val_all{var2}) * length(val_all{var3}) + (ind2 - 1) * length(val_all{var3}) + ind3;
    feature{size(index2, 1) + j + d}(row_index) = 1;
end

end