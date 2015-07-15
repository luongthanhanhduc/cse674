function [prob] = BN_join_prob(BN_structure, BN_params, val_all, x)
prob = 1;
d = length(x);
x_index = -1 * ones(size(x));
for i = 1 : d
    x_index(i) = val2index(x(i), val_all{i});
end

for i = 1 : d
    % generate the parent set
    parent_set = [];
    for j = 1 : d
        if (BN_structure(j, i) ~= 0)
            parent_set = [parent_set, j];
        end
    end
    % compute the row index of the CPD
    index = 1;
    for j = 1 : length(parent_set)
        parent_val = x_index(parent_set(j));
        repeat = 1;
        for k = j + 1 : length(parent_set)
            repeat = repeat * length(val_all{parent_set(k)});
        end
        index = index + (parent_val - 1) * repeat;
    end
    prob = prob * BN_params{i}(index, x_index(i));
end

end

function index = val2index(value, val_all)
index = -1;
for i = 1 : length(val_all)
    if (value == val_all(i))
        index = i;
        break;
    end
end
end
