function h = pred_logloss(opt_mu, X_test,  T)  
    d = length(X_test(1,:));
    m = T*d;
    n = length(X_test(:,1));        
    h = zeros(n,T);
    tau_vect = zeros(m,n);
    M = cell(n,1);

    for i = 1:n
        for j = 1:T
            M{i}(j,:) = phifunction(X_test(i,:),j,T);
        end
    end
    
    for i = 1:n
        for j = 1:T
            tau_vect(:,i) =  phifunction(X_test(i,:),j, T);
            h(i,j) = 1 / sum( exp( M{i}*opt_mu - tau_vect(:,i)'*opt_mu) ) ;
        end
    end


end