function S = varphilog(M,muu, Y)
    S=0;
    for i = 1:length(Y)
        S = S + log_sum_exp(M{i}*muu);
    end
    S = (1/length(Y))*S;
end