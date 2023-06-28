clear;

data_dir = './data/';
res_dir = './result/';

% Get the list of data files (*.mat)
data_list = dir([data_dir, '*.mat']);
data_list = {data_list.name};

res_list = dir([res_dir, '*.mat']);
res_list = {res_list.name};

% Loop through each data file and load the data
res_mat = struct('dat_name', {}, 'acc', {}, 'acc_std', {}, 'nmi', {}, 'nmi_std', {});
for k = 1:length(data_list)
    load(data_list{k});
    file_name = data_list{k}(1:end-4);
    % Do something with the data
    res_mat(k).dat_name = file_name;
    alg_size = length(res);
    acc_mat = zeros(alg_size, 2);
    acc_std_mat = zeros(alg_size, 2);
    nmi_mat = zeros(alg_size, 2);
    nmi_std_mat = zeros(alg_size, 2);
    for i = 1:alg_size
        target_mat = res(i).acc;
        [max_val, max_ind] = max(target_mat(:));
        [max_row, max_col] = ind2sub(size(target_mat), max_ind);
        acc_mat(i, 1) = max_val;
        acc_std_mat(i, 1) = res(i).acc_std(max_row, max_col);

        [min_val, min_ind] = min(target_mat(:));
        [min_row, min_col] = ind2sub(size(target_mat), min_ind);
        acc_mat(i, 2) = min_val;
        acc_std_mat(i, 2) = res(i).acc_std(min_row, min_col);

        target_mat = res(i).nmi;
        [max_val, max_ind] = max(target_mat(:));
        [max_row, max_col] = ind2sub(size(target_mat), max_ind);
        nmi_mat(i, 1) = max_val;
        nmi_std_mat(i, 1) = res(i).nmi_std(max_row, max_col);

        [min_val, min_ind] = min(target_mat(:));
        [min_row, min_col] = ind2sub(size(target_mat), min_ind);
        nmi_mat(i, 2) = min_val;
        nmi_std_mat(i, 2) = res(i).nmi_std(min_row, min_col);
    end
    res_mat(k).acc = acc_mat;
    res_mat(k).acc_std = acc_std_mat;
    res_mat(k).nmi = nmi_mat;
    res_mat(k).nmi_std = nmi_std_mat;
end

save('total_res.mat', 'res_mat');
