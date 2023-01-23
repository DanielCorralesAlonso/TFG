function h = pred_alphaloss(opt_mu,opt_nu, alpha, X_test, T)   
    beta = alpha / (alpha - 1);
    n = length(X_test(:,1));        
    h = zeros(n,T);
    if alpha > 1
        for i = 1:n 
            C = sum(( pos( (phifunction(X_test(i,:),1:T, T)'*opt_mu + opt_nu) / beta + 1 ) ) .^(beta));
            for j = 1:T
                h(i,j) = (( pos( (phifunction(X_test(i,:),j, T)'*opt_mu + opt_nu) / beta + 1 ) ) ^(beta)) / C ;
            end
        end
    elseif alpha < 1
        for i = 1:n
            C = sum(( pos( (phifunction(X_test(i,:),1:T, T)'*opt_mu + opt_nu) / beta + 1 ) ) .^(beta));
            for j = 1:T
                h(i,j) = (( pos( (phifunction(X_test(i,:),j, T)'*opt_mu + opt_nu) / beta + 1 ) ) ^(beta)) / C;
            end
        end
    end
end
