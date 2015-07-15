clearvars;
clc;

load('~/matlab/data.mat');

folder = dir('./data/handprint/generation 4/');
handprint{4} = [];
for i = 3 : size(folder, 1)
    strcat('./data/handprint/generation 4/', folder(i).name)
    M = csvread(strcat('./data/handprint/generation 4/', folder(i).name), 2, 3);
    handprint{4} = [handprint{4}; M];
end

save('~/matlab/data.mat', 'cursive', 'handprint');


load('data.mat');
for i = 1 : 3
    cursive{i} = cursive{i}(:, 1 : size(cursive{i}, 2) - 1);
end

for i = 1 : 4
    handprint{i} = handprint{i}(:, 1 : size(handprint{i}, 2) - 1);
end

save('data.mat', 'cursive', 'handprint');