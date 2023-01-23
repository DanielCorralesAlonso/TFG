function h = pred_01loss(opt_mu, X_test,  T)   
    n = length(X_test(:,1));        
    h = zeros(n,T);
    S = subsetsY(T);
    
    M = cell(n,1);
    for i = 1:n
        for j = 1:length(S)
            M{i}(j,:) = sum(phifunction(X_test(i,:),cell2mat(S(j)),T),2)' / length(cell2mat(S(j)) );
        end
    end

    l = zeros(length(S),1);
    for i = 1:length(S)
        l(i) = 1 / length(cell2mat(S(i)));
    end
    
    for i = 1:n
        opt_nu = - summax(num2cell(M{i},[1 2]),l, opt_mu) - 1;
        for j = 1:T
            h(i,j) = (pos(phifunction(X_test(i,:), j, T)'*opt_mu + opt_nu + 1)) ;
        end
    end


end