function expected_val = Markov_expected_value_feature(theta, M, X, val_all, index2, index3)
[n, d] = size(X);
[size_theta, temp] = size(theta);
expected_val = cell(size_theta, 1);
for i = 1 : size_theta
    expected_val{i} = zeros(size(theta{i}));
end

for i = 1 : n
    data = X(i, :);
    % clique of size 1
    for j = 1 : d
        if (data(j) == -1)
            continue;
        end
        ind = -1;
        for k = 1 : length(val_all{j})
            if (data(j) == val_all{j}(k))
                ind = k;
            end
        end
        expected_val{j}(ind) = expected_val{j}(ind) + 1;
    end
    % clique of size 2
    for j = 1 : size(index2, 1)
        var1 = index2(j, 1);
        var2 = index2(j, 2);
        if ((data(var1) == -1) || (data(var2) == -1)) 
            continue;
        end
        ind1 = -1;
        for k = 1 : length(val_all{var1})
            if (data(var1) == val_all{var1}(k))
                ind1 = k;
            end
        end
        ind2 = -1;
        for k = 1 : length(val_all{var2})
            if (data(var2) == val_all{var2}(k))
                ind2 = k;
            end
        end
        row_index = (ind1 - 1) * length(val_all{var2}) + ind2;
        expected_val{j + d}(row_index) = expected_val{j + d}(row_index) + 1;
    end
    % clique of size 3
    for j = 1 : size(index3, 1)
        var1 = index3(j, 1);
        var2 = index3(j, 2);
        var3 = index3(j, 3);
        if ((data(var1) == -1) || (data(var2) == -1) || (data(var3) == -1)) 
            continue;
        end
        ind1 = -1;
        for k = 1 : length(val_all{var1})
            if (data(var1) == val_all{var1}(k))
                ind1 = k;
            end
        end
        ind2 = -1;
        for k = 1 : length(val_all{var2})
            if (data(var2) == val_all{var2}(k))
                ind2 = k;
            end
        end
        ind3 = -1;
        for k = 1 : length(val_all{var3})
            if (data(var3) == val_all{var3}(k))
                ind3 = k;
            end
        end
        row_index = (ind1 - 1) * length(val_all{var2}) * length(val_all{var3}) + (ind2 - 1) * length(val_all{var3}) + ind3;
        expected_val{size(index2, 1) + j + d}(row_index) = expected_val{size(index2, 1) + j + d}(row_index) + 1;
    end
    
end

for i = 1 : size_theta
    for j = 1 : size(expected_val{i}, 1)
        expected_val{i}(j) = expected_val{i}(j) / sum(expected_val{i});
    end
end

end

