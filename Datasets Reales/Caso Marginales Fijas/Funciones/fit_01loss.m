function [opt, opt_mu] = fit_01loss(X,Y)
    T = max(Y);
    d = length(X(1,:));

    m = T*d;
    n = length(Y);
    tau_vect = zeros(m,n);
    
    for i = 1:n
        tau_vect(:,i) =  phifunction(X(i,:),Y(i), T);
    end

    tau = mean(tau_vect,2); 
    lambda = 0.3*std(tau_vect,0,2)/sqrt(n); 
 
    S = subsetsY(T);

    M = cell(n,1);
    for i = 1:n
        for j = 1:length(S)
            M{i}(j,:) = sum(phifunction(X(i,:),cell2mat(S(j)),T),2)' / length(cell2mat(S(j)) );
        end
    end

    l = zeros(length(S),1);
    for i = 1:length(S)
        l(i) = 1 / length(cell2mat(S(i)));
    end
    
    cvx_begin quiet
        variable muu(m)
        minimise(-tau'*muu + 1 + (1/n)*summax(M,l,muu) + (lambda'*abs(muu))) 
    cvx_end

    opt = cvx_optval;
    opt_mu = muu;
end

