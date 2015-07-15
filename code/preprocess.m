clearvars;
clc;

folder = dir('*');
cursive = [];
handprint = [];
for (i = 3 : 5) 
    folder(i).name
    new_folder = dir(strcat('./', folder(i).name));
    for (j = 3 : size(new_folder))
        new_folder(j).name
        if (strcmp(new_folder(j).name, 'cursive') == 1)
            new_folder2 = dir(strcat('./', folder(i).name, '/', new_folder(j).name));
            
            for (l = 3 : size(new_folder2, 1)) 
                new_folder3 = dir(strcat('./', folder(i).name, '/', new_folder(j).name, '/', new_folder2(l).name));
                for (m = 3 : size(new_folder3, 1))          
                    strcat('./', folder(i).name, '/', new_folder(j).name, '/', new_folder2(l).name, '/', new_folder3(m).name)%, '/', files(k).name)
                    M = csvread(strcat('./', folder(i).name, '/', new_folder(j).name, '/', new_folder2(l).name, '/', new_folder3(m).name), 2, 3);
                    size(M)
                    cursive = [cursive; M];
                    %end
                end
            end
            
        elseif (strcmp(new_folder(j).name, 'handprint') == 1)
            new_folder2 = dir(strcat('./', folder(i).name, '/', new_folder(j).name));
            
            for (l = 3 : size(new_folder2, 1)) 
                new_folder3 = dir(strcat('./', folder(i).name, '/', new_folder(j).name, '/', new_folder2(l).name));
                for (m = 3 : size(new_folder3, 1))
                    strcat('./', folder(i).name, '/', new_folder(j).name, '/', new_folder2(l).name, '/', new_folder3(m).name)%, '/', files(k).name)
                    M = csvread(strcat('./', folder(i).name, '/', new_folder(j).name, '/', new_folder2(l).name, '/', new_folder3(m).name), 2, 3);
                    size(M)
                    handprint = [handprint; M];
                    %end
                end
            end
        end
    end
end

cursive = cursive(:, 1 : size(cursive, 2) - 1);
handprint = handprint(:, 1 : size(handprint, 2) - 1);

new_cursive = [];
new_handprint = [];
for (i = 1 : size(cursive, 1))
    row = cursive(i, :);
    flag = 0;
    for (j = 1 : size(row, 2))
        if (row(j) ~= 0)
            flag = 1;
        end
    end
    if (flag == 1) 
        new_cursive = [new_cursive; row];
    end
end

for (i = 1 : size(handprint, 1))
    row = handprint(i, :);
    flag = 0;
    for (j = 1 : size(row, 2))
        if (row(j) ~= 0)
            flag = 1;
        end
    end
    if (flag == 1) 
        new_handprint = [new_handprint; row];
    end
end
cursive = new_cursive;
handprint = new_handprint;
save('data.mat', 'cursive', 'handprint');