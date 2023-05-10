clear;
check = [];
for n = 50:50:250
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
  f_res = zeros(length(file_list), alg_len);
  f_idx = zeros(length(file_list), alg_len);
  act_fc = n / 5;
  for i = 1:length(file_list)
    res = load(['./result_fs/' file_list(i).name]);
    res = res.res;
    for j = 1:alg_len
      s_res(i, j) = min(res(j).S(:, act_fc));
      r_res(i, j) = min(res(j).R(:, act_fc));
      e_res(i, j) = min(res(j).E(:, act_fc));
      f_res(i, j) = min(res(j).F(:, act_fc));
    end
    % check how many times the res(:,end) is best
    s_idx(i, :) = s_res(i, :) == min(s_res(i, :));
    e_idx(i, :) = e_res(i, :) == min(e_res(i, :));
    r_idx(i, :) = r_res(i, :) == min(r_res(i, :));
    f_idx(i, :) = f_res(i, :) == min(f_res(i, :));
  end
  t_idx = s_idx + e_idx + r_idx + f_idx;
  per = sum(t_idx(:, end));
  check(end+1, :) = [n, per];
end


