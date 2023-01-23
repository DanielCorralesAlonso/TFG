function V = V_gt1(X,muu,nuu,beta,T)
    n = length(X(:,1));
    for i = 1:n
        V(i,1) = sum( pow_pos((1/beta)*( phifunction(X(i,:), 1:T ,T)' * muu + ones(T,1)*nuu(i)) + ones(T,1) , beta) );   
    end
end