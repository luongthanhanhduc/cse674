function [adjmatrix] = BN_add_direction_PDAG(adjmatrix)
%ADD_DIRECTION_PDAG Summary of this function goes here
%   Detailed explanation goes here
[d, temp] = size(adjmatrix);
for i = 1 : d
    for j = i + 1 : d
        if (adjmatrix(i, j) ~= 0) && (adjmatrix(j, i) ~= 0)
            adjmatrix(j, i) = 0;
        end
    end
end

end

