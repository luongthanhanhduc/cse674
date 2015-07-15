function mean_val = BN_mean(BN_params, K)

d = size(K,1);
mean_val = zeros(1,d);
i = 0;
for i1 = 1:size(BN_params{1},2)
    for i2 = 1:size(BN_params{2},2)
        for i3 = 1:size(BN_params{3},2)
            for i4 = 1:size(BN_params{4},2)
                for i5 = 1:size(BN_params{5},2)
                    for i6 = 1:size(BN_params{6},2)
                        for i7 = 1:size(BN_params{7},2)
                            for i8 = 1:size(BN_params{8},2)
                                for i9 = 1:size(BN_params{9},2)
                                    for i10 = 1:size(BN_params{10},2)
                                        for i11 = 1:size(BN_params{11},2)
                                            for i12 = 1:size(BN_params{12},2)
                                                i = i+1
                                                x = [i1,i2,i3,i4,i5,i6,i7,i8,i9,i10,i11,i12];
                                                prob = BN_prob(K, BN_params, x);
                                                mean_val = mean_val + prob*(x-1);
                                            end
                                        end
                                    end
                                end
                            end
                        end
                    end
                end
            end
        end
    end
end


end

function [prob] = BN_prob(BN_structure, BN_params, x_index)
prob = 1;
d = length(x_index);

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
            repeat = repeat * size(BN_params{parent_set(k)},2);
        end
        index = index + (parent_val - 1) * repeat;
    end
    prob = prob * BN_params{i}(index, x_index(i));
end

end

