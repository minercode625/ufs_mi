% get result of feature selction
clear;

data_dir = './data/';
% list of data which name has '.mat'
data_list = dir([data_dir, '*.mat']);
data_list = {data_list.name};

fs_dir = './result/';
fs_list = dir([fs_dir, '*.mat']);
fs_list = {fs_list.name};

save_dir = './result_fs/';


rep_size = 50;
max_fs_size = 300;

for k = 9:length(data_list)
    k
    load(data_list{k});
    data_name = data_list{k}(1:end-4);
    load(strcat(data_name, '_exp.mat'));
    [~, col] = size(fea);
    max_col = min(max_fs_size, col);
    fs_size = 50:50:max_col;
    res = struct('alg', {}, 'acc', {}, 'acc_std', {}, 'nmi', {}, 'nmi_std', {});
    parfor alg_idx = 1:length(param_struct)
        alg = param_struct(alg_idx).alg;
        param = param_struct(alg_idx).param;
        acc_table = zeros(length(param), length(fs_size));
        nmi_table = zeros(length(param), length(fs_size));
        for param_idx = 1:length(param)
            acc_std_table = zeros(length(param), length(fs_size));
            nmi_std_table = zeros(length(param), length(fs_size));
            fs_list = param_struct(alg_idx).fea;
            f_sel = fs_list(param_idx,:);
            for fs_idx = 1:length(fs_size)
                fs = fs_size(fs_idx);
                X_fs = fea(:, f_sel(1:fs));
                [acc, nmi] = kmeans_rng(X_fs, gnd, rep_size);
                acc_table(param_idx, fs_idx) = acc(1,1);
                acc_std_table(param_idx, fs_idx) = acc(1,2);
                nmi_table(param_idx, fs_idx) = nmi(1,1);
                nmi_std_table(param_idx, fs_idx) = nmi(1,2);
            end
        end
        res(alg_idx).alg = alg;
        res(alg_idx).acc = acc_table;
        res(alg_idx).acc_std = acc_std_table;
        res(alg_idx).nmi = nmi_table;
        res(alg_idx).nmi_std = nmi_std_table;
    end
    save_name = strcat(save_dir, data_name, '_fs.mat');
    save(save_name, 'res');
end
