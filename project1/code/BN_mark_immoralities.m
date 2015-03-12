function [ K ] = BN_mark_immoralities(S, U)
% Input:
%    S: skeleton, adjacency matrix of size d x d
%    U: Witness, 3 dimensional matrix of size d x d x w_size
% Output:
%    K: skeleton with orientation for each immortalities
[d, ~] = size(S);
[~, ~, w_size] = size(U);
K = S;
for i = 1 : d
    for j = 1 : d
        if ((i ~= j) && (K(i, j) ~= 0))
            for k = 1 : d
                if ((k ~= j) && (k ~= i) && (K(j, k) ~= 0))
                    % i -- j -- k is a potential immortality
                    for l = 1 : w_size
                        if (U(i, k, l) ~= j) 
                            K(j, i) = 0;
                            K(j, k) = 0;
                        end
                    end
                end
            end
        end
    end
end

end

