clearvars;
clc;

load('data.mat');

X = handprint{1};
[M, U] = BN_build_skeleton(X, 2);

theta = Markov_learn_params(X, M);



