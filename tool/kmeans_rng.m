function [acc_res, nmi_res] = kmeans_rng(X, Y, trial)
rng(1);
cluster = length(unique(Y));
acc = zeros(trial, 1);
nmi = zeros(trial, 1);
for k = 1:trial
    pred = kmeans(X, cluster);
    res = evalClustering(Y, pred);
    acc(k, 1) = res.acc;
    nmi(k, 1) = res.nmi_max;
end
acc_res = zeros(1, 2);
nmi_res = zeros(1, 2);
acc_res(1, 1) = mean(acc);
acc_res(1, 2) = std(acc);
nmi_res(1, 1) = mean(nmi);
nmi_res(1, 2) = std(nmi);
end