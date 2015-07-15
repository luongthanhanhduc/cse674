function [samples] = BN_Gibbs(BN_params, BN_structure, val_all, n_sample)
[d, ~] = size(BN_structure);
samples = zeros(n_sample, d);
samples(1, :) = ones(1, d);
for i = 2 : n_sample
    % randomly pick a feature to sample
    %feature = unidrnd(d);
    for feature = 1 : d
        % generate the parent set of selected feature
        parent_set = [];
        for j = 1 : d
            if (BN_structure(j, feature) ~= 0)
                parent_set = [parent_set, j];
            end
        end
        % get CPD from BN_params
        cpd = BN_params{feature};
        
        % get parents' values of the current selected feature
        parent_vals = zeros(1, length(parent_set));
        for j = 1 : length(parent_set)
            parent = parent_set(j);
            parent_vals(j) = samples(i - 1, parent);
        end

        % compute the row index of the CPD
        index = 1;
        for j = 1 : length(parent_set)
            parent_val = parent_vals(j);
            repeat = 1;
            for k = j + 1 : length(parent_set)
                repeat = repeat * length(val_all{parent_set(k)});
            end
            index = index + (parent_val - 1) * repeat;
        end
        % extract the row from CPD
        
        prob = cpd(index, :);

        % draw a random number between 0 and 1
        random = rand(1);
        curr_prob = prob(1);
        flag = 0;
        for j = 2 : length(prob)
            if (curr_prob > random) % when cumulative prob > random number, assign value for it
                samples(i, feature) = j-1;%val_all{feature}(j-1);
                flag = 1;
                break;
            end
            curr_prob = curr_prob + prob(j);
        end
        if (flag == 0) % assign the last value for feature
            samples(i, feature) = length(prob);
        end
    end
end
samples = look_up_from_index(samples, val_all);


end

function samples = look_up_from_index(index, val_all)
[n, d] = size(index);
samples = -100 * ones(size(index));
for i = 1 : n
    for j = 1 : d
        samples(i, j) = val_all{j}(index(i, j));
    end
end

end