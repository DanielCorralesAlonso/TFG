function h = pred_alphaloss(opt_mu, alpha, X_test, T)   
    beta = alpha / (alpha - 1);
    n = length(X_test(:,1));        
    h = zeros(n,T);
    if alpha > 1
        for i = 1:n
            cvx_begin quiet
                variable nuu
                maximise(nuu)
                subject to 
                    V_gt1(X_test(i,:), opt_mu, nuu, beta, T) <= 1
            cvx_end
            for j = 1:T
                h(i,j) = (( pos( (phifunction(X_test(i,:),j, T)'*opt_mu + nuu) / beta + 1 ) ) ^(beta)) ;
            end
        end
    elseif alpha < 1
        for i = 1:n
            cvx_begin quiet
                variable nuu
                maximise(nuu)
                subject to 
                    V_lt1(X_test(i,:), opt_mu, nuu, beta, T) <= 1
            cvx_end
            for j = 1:T
                h(i,j) = (( pos( (phifunction(X_test(i,:),j, T)'*opt_mu + nuu) / beta + 1 ) ) ^(beta));
            end
        end
    end
end
