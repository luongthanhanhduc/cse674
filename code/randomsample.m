function [x] = randomsample(p)
% Input: 
%    p: a row vector, sum(p) = 1.
% Output:
%    x: a random sample(more like an index).

r = rand(1);
sum = 0;
x = 0;
for ii = 1:max(size(p))
    if r < sum+p(ii) && r > sum
        x = x+1;
        break;
    else
        sum = sum + p(ii);
        x = x+1;
    end
end

end