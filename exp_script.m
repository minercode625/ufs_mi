clear;
load exp_setting.mat
output_dir = './result/';
if ~exist(output_dir, 'dir')
    mkdir(output_dir);
end
for k = 1:length(file_list)
    load exp_setting.mat
    fprintf('%d Start\n', k);
    load(file_list{k})
    for m = 1:length(param_struct)
        if size(fea, 2) < max_fea
            param_struct(m).fea = zeros(size(param_struct(m).param, 1), size(fea, 2));
        end
        alg = param_struct(m).alg;
        temp_param = param_struct(m).param;
        temp_fea = param_struct(m).fea;
        temp_time = param_struct(m).time;
        fea = normalize(fea);
        parfor n = 1:length(temp_param)
           tic
           idx =  ufs_alg(alg, fea, gnd, max_fea, temp_param(n,:));
           temp_fea(n, :) = idx;
           temp_time(n,1) = toc;
        end
        param_struct(m).fea = temp_fea;
        param_struct(m).time = temp_time;
        fprintf('%s finish\n', alg);
        file_name = file_list{k};
        file_name = replace(file_name, '.mat', '_exp.mat'); 
        save_dir = strcat(output_dir, file_name);
        save(save_dir, 'param_struct');
    end
    fprintf('%d finish\n', k);
end
!git add .
!git commit -m "results"
!git push origin master
