function [adjmatrix] = build_Markov_graph(X)
%BUILD_MARKOV_GRAPH Summary of this function goes here
%   Detailed explanation goes here
[n, d] = size(X);
adjmatrix = zeros(d, d);
for x = 1 : d
    x
    for y = x + 1 : d
        y
        tic
        x1 = X(:, x);
        x2 = X(:, y);
        x3 = [];
        for i = 1 : d
            if ((i ~= x) && (i ~= y))
                x3 = [x3, X(:, i)];
            end
        end
        accept = chi_square(x1, x2, x3);
        if (accept == 1)
            adjmatrix(x, y) = 1;
        end
        toc
    end
end

end

