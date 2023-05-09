% get result of feature selction
clear;
exp_dir = './result/';
data_dir = './data/';
output_dir = './result_fs/';
if ~exist(output_dir, 'dir')
    mkdir(output_dir);
end
list = dir(sprintf('%s*.mat', exp_dir));

rep_size = 50;
max_fs_size = 50;

for k = 1:length(list)
    file_name = list(k).name;
    data_name = replace(file_name, '_exp', '');
    load(sprintf('%s%s',data_dir, data_name));
    load(file_name);
    X = fea;
    Y = gnd;
    [~, col] = size(X);
    max_col = min(max_fs_size, col);
    fs_size = 5:5:max_col;
    res = struct('alg', {}, 'S', {}, 'S_std', {}, 'E', {}, 'E_std', {},  'R', {}, 'R_std', {});
    for alg_idx = 1:length(param_struct)
        alg = param_struct(alg_idx).alg;
        param = param_struct(alg_idx).param;
        s_table = zeros(length(param), length(fs_size));
        s_std_table = zeros(length(param), length(fs_size));
        e_table = zeros(length(param), length(fs_size));
        e_std_table = zeros(length(param), length(fs_size));
        r_table = zeros(length(param), length(fs_size));
        r_std_table = zeros(length(param), length(fs_size));
        for param_idx = 1:length(param)
            fs_list = param_struct(alg_idx).fea;
            fea = fs_list(param_idx,:);
            parfor fs_idx = 1:length(fs_size)
                fs = fs_size(fs_idx);
                X_fs = X(:, fea(1:fs));
                [m_res, s_res] = kmeans_rng(X_fs, Y, rep_size);
                s_table(param_idx, fs_idx) = m_res(1,1);
                s_std_table(param_idx, fs_idx) = s_res(1,1);
                e_table(param_idx, fs_idx) = m_res(1,2);
                e_std_table(param_idx, fs_idx) = s_res(1,2);
                r_table(param_idx, fs_idx) = m_res(1,3);
                r_std_table(param_idx, fs_idx) = s_res(1,3);
            end
        end
        res(alg_idx).alg = alg;
        res(alg_idx).S = s_table;
        res(alg_idx).S_std = s_std_table;
        res(alg_idx).E = e_table;
        res(alg_idx).E_std = e_std_table;
        res(alg_idx).R = r_table;
        res(alg_idx).R_std = r_std_table;
    end
    save_name = replace(file_name, '_exp', '_res');
    save_dir = sprintf('%s%s', output_dir, save_name);
    save(save_dir, 'res');
end
