function idx = ufs_alg(name, X, Y, max_fea, param)
if max_fea > size(X, 2)
    m = size(X, 2);
else
    m = max_fea;
end
if size(Y, 2) > 1
    c_num = 2;
else
    c_num = length(unique(Y));
end
switch name
    case 'LS'
        idx = UFS_LS(X, m);
        idx = idx';
    case 'UDFS'
        idx = udfs(X, c_num);
        idx = idx(1, 1:m);
    case 'NDFS'
        idx = NDFS(X, 100, param(1, 1), 1, param(1, 2));
        idx = idx(1, 1:m);
    case 'MCFS'
        idx = MCFS_p(X, m);
    case 'MAX_VAR'
        idx = maxvar(X);
        idx = idx(1:m, 1);
        idx = idx';
    case 'CNAFS'
        [~, ~, idx, ~] = CNAFS(X', c_num, param(1, 1), param(1, 2), param(1, 3), param(1, 4));
        idx = idx(1:m, 1);
        idx = idx';
    case 'DUFS'
        idx = dufs();
        idx = idx(1:m, 1);
        idx = idx';
    case 'EGCFS'
        [~, idx, ~] = EGCFS_TNNLS(X', c_num, param(1, 1), param(1, 2), m);
        idx = idx(1:m, 1);
        idx = idx';
    case 'FMIUFS'
        idx = FMIUFS(X, param(1,1));
        idx = idx(1, 1:m);
    case 'IUFS'
        idx = iufs(X, m);
        idx = idx';
    case 'PROP'
        idx = proposed(X, m);
        idx = idx';
end
end

