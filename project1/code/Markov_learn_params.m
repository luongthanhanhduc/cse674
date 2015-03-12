function [theta] = Markov_learn_params(X, M)
[n, d] = size(X);
num_val = zeros(1,d);
val_all = cell(1,d);
for ii = 1:d
    val_all{ii} = remove_minus1(unique(X(:,ii)));
    num_val(ii) = size(val_all{ii},1);
end

% compute size of theta
size_theta = d; % singleton clique
% clique of 2 nodes
index2 = [];
for i = 1 : d
    for j = i+1 : d
        if (M(i, j) ~= 0)
            size_theta = size_theta + 1;
            index2 = [index2; i, j, size_theta];
        end
    end
end
% clique of 3 nodes
index3 = [];
for i = 1 : d
    for j = 1 : d
        if (M(i, j) ~= 0)
            for k = 1 : d
                if ((k ~= i) && (k ~= j) && (M(i, k) ~= 0) && (M(j, k) ~= 0)) 
                    size_theta = size_theta + 1;
                    index3 = [index3; i, j, k, size_theta];
                end
            end
        end
    end
end
% initialize theta
theta = cell(size_theta, 1);
% initialize each entries in each cell of theta
% clique of size 1
for i = 1 : d
    theta{i} = ones(num_val(i), 1);
end
% clique of size 2
for i = 1 : size(index2, 1)
    theta{d + i} = ones(num_val(index2(i, 1)) * num_val(index2(i, 2)), 1);
end
% clique of size 3
for i = 1 : size(index3, 1)
    theta{d + size(index2, 1) + i} = ones(num_val(index3(i, 1)) * num_val(index3(i, 2)) * num_val(index3(i, 3)), 1);
end

n_sample = 10;
step = 1;
n_iter = 1000;
for iter = 1 : n_iter
    iter
    samples = Markov_Gibbs(M, theta, val_all, index2, index3, n_sample);
    lhs = Markov_expected_value_feature(theta, M, X, val_all, index2, index3);
    rhs = Markov_expected_value_feature(theta, M, samples, val_all, index2, index3);
    theta = subtract(theta, multiply(subtract(lhs, rhs), step));
end

end

function ret = subtract(a, b)
[size_theta, temp] = size(a);
ret = cell(size_theta, 1);
for i = 1 : size_theta
    ret{i} = zeros(size(a{i}));
    ret{i} = a{i} - b{i};
end

end

function ret = multiply(a, c)
[size_theta, temp] = size(a);
ret = cell(size_theta, 1);
for i = 1 : size_theta
    ret{i} = zeros(size(a{i}));
    ret{i} = a{i} * c;
end

end