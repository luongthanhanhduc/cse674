clearvars;
clc;

load('data.mat');

all_data = cursive{1};
all_data = [all_data; cursive{2}];
all_data = [all_data; cursive{3}];

X = cursive{3};
val_all = construct_all_vals(all_data);
K = BN_build_PDAG(X, 2);
K = BN_add_direction_PDAG(K);

BN_params = BN_parameters(X, K, val_all);
n_sample = 10000;
ancestral_samples = BN_ancestral_sample(K, BN_params, val_all, n_sample);
gibbs_samples = BN_Gibbs(BN_params, K, val_all, n_sample);

data_mean = BN_compute_mean(K, BN_params, val_all, X);
gibbs_mean = BN_compute_mean(K, BN_params, val_all, gibbs_samples);
ancestral_mean = BN_compute_mean(K, BN_params, val_all, ancestral_samples);
mean_matrix = [data_mean, gibbs_mean, ancestral_mean]

data_entropy = BN_compute_entropy(K, BN_params, val_all, X);
gibbs_entropy = BN_compute_entropy(K, BN_params, val_all, gibbs_samples);
ancestral_entropy = BN_compute_entropy(K, BN_params, val_all, ancestral_samples);
entropy = [data_entropy, gibbs_entropy, ancestral_entropy]

save('BN_cursive3.mat', 'K', 'BN_params', 'mean_matrix', 'entropy');
csvwrite('BN_cursive3.csv', K);

% compute relative entropy
clearvars;
clc;
load('data.mat');

X = handprint{1};
X = [X; handprint{2}];
X = [X; handprint{3}];
X = [X; handprint{4}];
val_all = construct_all_vals(X);

structure = cell(5, 1);
params = cell(5, 1);
load('BN_handprint1.mat');
structure{1} = K;
params{1} = BN_params;
load('BN_handprint2.mat');
structure{2} = K;
params{2} = BN_params;
load('BN_handprint3.mat');
structure{3} = K;
params{3} = BN_params;
load('BN_handprint4.mat');
structure{4} = K;
params{4} = BN_params;
load('BN_handprint_all.mat');
structure{5} = K;
params{5} = BN_params;

KL = zeros(5, 5);
for i = 1 : 5
    for j = 1 : 5
        if (i ~= j)
            KL(i, j) = BN_compute_KL_divergence(structure{i}, params{i}, structure{j}, params{j}, X, val_all);
        end
    end
end
save('KL_handprint.mat', 'KL');

% identify rare writing in cursive data
clearvars;
clc;

load('data.mat');

all_data = cursive{1};
all_data = [all_data; cursive{2}];
all_data = [all_data; cursive{3}];
X = all_data;
val_all = construct_all_vals(all_data);
K = build_PDAG(X, 2);
K = add_direction_PDAG(K);

BN_params = BN_parameters(X, K, val_all);
[sample, index] = BN_rare_writing(K, BN_params, val_all, X);
BN_join_prob(K, BN_params, val_all, sample)
sample

% identify rare writing in handprint data
clearvars;
clc;

load('data.mat');

all_data = handprint{1};
all_data = [all_data; handprint{2}];
all_data = [all_data; handprint{3}];
all_data = [all_data; handprint{4}];
X = all_data;
val_all = construct_all_vals(all_data);
K = build_PDAG(X, 2);
K = add_direction_PDAG(K);

BN_params = BN_parameters(X, K, val_all);
[sample, index] = BN_rare_writing(K, BN_params, val_all, X);
BN_join_prob(K, BN_params, val_all, sample)
sample

% identify common writing in cursive data
clearvars;
clc;

load('data.mat');

all_data = cursive{1};
all_data = [all_data; cursive{2}];
all_data = [all_data; cursive{3}];
X = all_data;
val_all = construct_all_vals(all_data);
load('BN_cursive_all.mat');
[sample, score] = BN_common_writing(K, BN_params, val_all, X, mean_matrix(:, 1));
score
sample

% identify common writing in handprint data
clearvars;
clc;

load('data.mat');

all_data = handprint{1};
all_data = [all_data; handprint{2}];
all_data = [all_data; handprint{3}];
all_data = [all_data; handprint{4}];
X = all_data;
val_all = construct_all_vals(all_data);
load('BN_handprint_all.mat');
[sample, score] = BN_common_writing(K, BN_params, val_all, X, mean_matrix(:, 1));
score
sample


clearvars;
clc;
load('BN_handprint_all.mat')
csvwrite('BN_handprint_all.csv', mean_matrix);
