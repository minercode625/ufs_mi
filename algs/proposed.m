function res = proposed(X, max_feat)

fcol = size(X,2);
f_ent = zeros(fcol, 1);
ff_ent = zeros(fcol, fcol);

for k = 1:fcol
    f_ent(k,1) = h(X(:,k));
end

for k = 1:fcol
    for m = k:fcol
        if k == m
            ff_ent(k,m) = f_ent(k,1) / 2;
            continue;
        end
        ff_ent(k,m) = h([X(:,k) X(:,m)]);
    end
end

ff_ent = ff_ent + ff_ent'; 

[~, res(1,1)] = max(f_ent);

for k =2:max_feat
    t_rel = zeros(fcol, 1);
    for m=1:fcol
        if ismember(m, res)
            t_rel(m,1) = -inf;
            continue;
        end
        t_rel(m,1) = sum(ff_ent(m, res), 2);
    end
    [~, idx] = max(t_rel); 
    res(end+1,1) = idx;
end
end
