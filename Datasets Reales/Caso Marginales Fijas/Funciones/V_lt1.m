function V = V_lt1(X,mu,nu,beta,T)
    n = length(X(:,1));
    for i = 1:n
        V(i,1) = sum( pow_p( (1/beta)*( phifunction(X(i,:), 1:T ,T)' * mu + ones(T,1)*nu(i)) + ones(T,1) , beta) );   
    end
end