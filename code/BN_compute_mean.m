function [mean_value] = BN_compute_mean(BN_structure, BN_params, val_all, X)
[n, d] = size(X);
mean_value = zeros(d, 1);
for i = 1 : d
    mean_value(i) = mean(change99(remove_minus1(X(:, i)), val_all{i}));
end

end

function new_val = change99(col_val, all_val)
max_val = -100;
for i = 1 : length(all_val)
    if (all_val(i) > max_val) && (all_val(i) ~= 99)
        max_val = all_val(i);
    end
end
new_val = col_val;
for i = 1 : length(col_val)
    if (col_val(i) == 99)
        new_val(i) = max_val + 1;
    end
end
end


