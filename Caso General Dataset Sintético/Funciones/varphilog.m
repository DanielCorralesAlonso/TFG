function M = varphilog(M,muu, Y)
    for i = 1:length(Y)
        S(i) = log_sum_exp(M{i}*muu);
    end
    M = max(S);
end