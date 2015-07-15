function new_v = remove_minus1(v)
    new_v = [];
    for i = 1 : size(v, 1)
        if (v(i) ~= -1)
            new_v = [new_v; v(i)];
        end
    end
end