function K = BN_build_PDAG(X, w_size)
% Input:
%    X: n by d matrix, each row is a sample
%    w_size: bound on the size of witness set
%    chi: threshold on chi_square test
% Output:
%    new_K: PDAG of input data, d x d matrix
    [S, U] = BN_build_skeleton(X, w_size);
    display('Finish build skeleton');
    csvwrite('skeleton.csv', S);
    K = BN_mark_immoralities(S, U);
    display('Finish mark immoralities');
    csvwrite('im.csv', K);
    while(1)
        new_K = K;
        new_K = ruleR1(new_K);
        new_K = ruleR2(new_K);
        new_K = ruleR3(new_K);
        if (norm(new_K - K) < 1e-15)
            break;
        end
        K = new_K;
    end
end

% check rule R1
function new_R1 = ruleR1(K) 
[d, ~] = size(K);
for x = 1 : d
    for y = 1 : d
        if ((x ~= y) && (K(x, y) ~= 0) && (K(y, x) == 0))
            for z = 1 : d
                if ((z ~= y) && (z ~= x) && (K(y, z) ~= 0) && (K(z, y) ~= 0) && (K(x, z) == 0) && (K(z, x) == 0))
                    display('rule 1');
                    x
                    y
                    z
                    K(z, y) = 0;
                end
            end
        end
    end
end
new_R1 = K;
end


% check rule R2
function new_R2 = ruleR2(K) 
[d, ~] = size(K);
for x = 1 : d
    for y = 1 : d
        if ((x ~= y) && (K(x, y) ~= 0) && (K(y, x) == 0))
            for z = 1 : d
                if ((z ~= y) && (z ~= x) && (K(y, z) ~= 0) && (K(z, y) == 0) && (K(x, z) ~= 0) && (K(z, x) ~= 0))
                    display('rule 2');
                    x
                    y
                    z
                    K(z, x) = 0;
                end
            end
        end
    end
end
new_R2 = K;
end

% check rule R3
function new_R3 = ruleR3(K) 
[d, ~] = size(K);
for x = 1 : d
    for y1 = 1 : d
        if ((x ~= y1) && (K(x, y1) ~= 0) && (K(y1, x) ~= 0))
            for y2 = 1 : d
                if ((y2 ~= y1) && (y2 ~= x) && (K(y2, x) ~= 0) && (K(x, y2) ~= 0) && (K(y1, y2) == 0) && (K(y2, y1) == 0))
                    for z = 1 : d
                        if ((z ~= x) && (z ~= y1)  && (z ~= y2) && (K(x, z) ~= 0) && (K(z, x) ~= 0) && (K(z, y1) == 0) && (K(y1, z) ~= 0) && (K(z, y2) == 0) && (K(y2, z) ~= 0))
                            K(z, x) = 0;
                            display('rule 3');
                            x
                            y1
                            y2
                            z
                        end
                    end
                end
            end
        end
    end
end
new_R3 = K;
end