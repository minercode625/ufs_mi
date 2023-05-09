clear;
check = [];
for n = 5:5:50
  file_list = dir('./result_fs/*.mat');
  res = load(['./result_fs/' file_list(1).name]);
  res = res.res;
  alg_len = length(res);
  s_res = zeros(length(file_list), alg_len);
  s_idx = zeros(length(file_list), alg_len);
  e_res = zeros(length(file_list), alg_len);
  e_idx = zeros(length(file_list), alg_len);
  r_res = zeros(length(file_list), alg_len);
  r_idx = zeros(length(file_list), alg_len);
  act_fc = n / 5;
  for i = 1:length(file_list)
    res = load(['./result_fs/' file_list(i).name]);
    res = res.res;
    for j = 1:alg_len
      s_res(i, j) = max(res(j).S(:, act_fc));
      r_res(i, j) = max(res(j).R(:, act_fc));
      e_res(i, j) = max(res(j).E(:, act_fc));
    end
    [~ , s_idx(i,:)] = sort(s_res(i,:));
    [~ , e_idx(i,:)] = sort(e_res(i,:));
    [~ , r_idx(i,:)] = sort(r_res(i,:));
  end
  t_idx = s_idx + e_idx + r_idx;
  per = sum(t_idx(:, end));
  check(end+1, :) = [n, per];
end


