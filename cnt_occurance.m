function cnt = cnt_occurance( A, a)
% Count the occurance of a in A.
% Input:
%    A: m by n matrix
%    a: 1 by n vector
% Output:
%    cnt: no. of rows in A that is the same with a

[mA nA] = size(A);
[ma na] = size(a);

if ma == 1
    if na == mA
        A = A';
    elseif na ~= nA
        printf('The dimension of the vector should agree with the dimension of the matrix');
        exit(-1);
    end
elseif na == 1
    a = a'
    if ma == mA
        A = A';
    elseif ma ~= nA
        printf('The dimension of the vector should agree with the dimension of the matrix');
        exit(-1);
    end
else
    printf('The second variable should be a vector!');
    exit(-1);
end
[mA nA] = size(A);
match = bsxfun(@eq, A, a);
col = sum(match,2);
cnt = size(find(col == nA),1);
end

