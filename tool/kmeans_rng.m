function [m_res, s_res] = kmeans_rng(X, Y, trial, X_origin)
rng(1);
cluster = length(unique(Y));
res = zeros(trial, 4);
for k = 1:trial
    pred = kmeans(X, cluster);
    res(k, 1) = c_sep(X, pred);
    res(k, 2) = ent(X);
    res(k, 3) = rep_ent(X);
    res(k, 4) = ffei(X, X_origin);
end
m_res = mean(res);
s_res = std(res);
end
