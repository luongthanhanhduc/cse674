function [ vals_all ] = construct_all_vals(X)
%CONSTRUCT_ALL_VALS Summary of this function goes here
%   Detailed explanation goes here
[n, d] = size(X);
vals_all = cell(1,d);
for i = 1 : d
    vals_all{i} = remove_minus1(unique(X(:, i)));
end

end

