function [accept] = chi_square(x1, x2, x3)
% reference: https://onlinecourses.science.psu.edu/stat504/node/112
%
% Input: 
%   x1: n by 1 column vecter
%   x2: n by 1 column vector
%   x3: n by d matrix, d >= 1.
% Output:
%   chi: chi_square text value of x1 and x2 conditioned on x3.

% Find all the possible values of x1 and x2
x1_all = remove_minus1(unique(x1));
x2_all = remove_minus1(unique(x2));

[d1, ~] = size(x1_all);
[d2, ~] = size(x2_all);

% Find all the possible values of x3
[n d] = size(x3);
x3_val = cell(d,1);
for ii = 1:d
    x3_val{ii} = remove_minus1(unique(x3(:,ii)));
end

d3 = 1;
interval = ones(1, d);
repeat = ones(1,d);
for ii = d:-1:2
    d3 = d3*size(x3_val{ii},1);
    interval(ii-1) = interval(ii) * size(x3_val{ii},1);
end
d3 = d3*size(x3_val{1},1);
for ii = 2:d
    repeat(ii) = repeat(ii-1)*size(x3_val{ii-1},1);
end

x3_all = zeros(d3, d);
for ii = 1:d
    for jj = 1:repeat(ii)
        for kk = 1:size(x3_val{ii},1)
            for ll = 1:interval(ii)
                x3_all( (jj-1)*d3/repeat(ii) + (kk-1)*interval(ii) + ll, ii) = x3_val{ii}(kk);
            end
        end
    end
end

degree_of_freedom = (length(x1_all) -1) * (length(x2_all) - 1);
accept = 1;

% Compute chi_square test
for ii = 1:d3
    % Count no. occurance of x3_all(ii,:)
    n3 = cnt_occurance(x3, x3_all(ii,:));
    chi = 0;
    if n3 == 0
        continue;
    end
    for jj = 1:d1
        % Count no. occurance of x1_all(jj) together with x3_all(ii,:)
        n13 = cnt_occurance([x1 x3], [x1_all(jj) x3_all(ii,:)]);
        if n13 == 0
            continue;
        end
        for kk = 1:d2
            % Count no. occurance of x2_all(kk) together with x3_all(ii,:)
            n23 = cnt_occurance([x2 x3], [x2_all(kk) x3_all(ii,:)]);
            n123 = cnt_occurance([x1 x2 x3], [x1_all(jj) x2_all(kk) x3_all(ii,:)]);
            if n23 == 0 || n123 == 0
                continue;
            end
            E123 = n13*n23/n3;
            chi = chi + (n123 - E123)^2/E123;
        end
    end
    p_value = 1 - chi2cdf(chi, degree_of_freedom);
    if (p_value < 0.05)
        accept = 0;
        break;
    end
end
end