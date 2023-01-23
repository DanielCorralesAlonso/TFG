function h = pred_01loss(opt_mu, opt_nu, X_test,  T)   
    n = length(X_test(:,1));        
    h = zeros(n,T);
    
    for i = 1:n
        C = sum(pos(phifunction(X_test(i,:), 1:T, T)'*opt_mu + opt_nu + 1));
        if C == 0
            h(i,:) = 1 / T;
        else
            for j = 1:T
                h(i,j) = (pos(phifunction(X_test(i,:), j, T)'*opt_mu + opt_nu + 1)) / C  ;
            end
        end
    end
end