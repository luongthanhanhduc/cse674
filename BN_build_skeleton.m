function [H, U] = BN_build_skeleton(X, w_size)
% Input:
%    X: n by d matrix, each row is a sample
%    w_size: bound on the size of witness set
%    chi: threshold on chi_square test
% Output:
%    H: adjacency matrix
%    U: d by d by w_size matrix, U(ii,jj,:) is the witness of H(ii,jj)

[~, d] = size(X);
H = ones(d);
U = zeros(d,d,w_size);
if w_size > d-2
    w_size = d-2;
end

for ii = 1:(d-1)
    for jj = (ii+1):d
        wit = zeros(1,d-2);
        ll = 1;
        for kk = 1:d
            if kk ~= ii && kk ~=jj
                wit(ll) = kk;
                ll  = ll + 1;
            end
        end
        flag = 0;
        for wit_size = 1:w_size
            wit_temp = nchoosek(wit,wit_size);
            for ll = 1:size(wit_temp,1)
                accept = chi_square(X(:,ii), X(:,jj), X(:,wit_temp(ll,:)));
                if (accept == 1)
                    H(ii,jj) = 0;
                    H(jj,ii) = 0;
                    U(ii,jj,1:size(wit_temp,2)) = wit_temp(ll,:);
                    flag = 1;
                    break
                end
            end
            if flag == 1
                break;
            end
        end
    end
end
for i = 1 : d
    H(i, i) = 0;
end

end