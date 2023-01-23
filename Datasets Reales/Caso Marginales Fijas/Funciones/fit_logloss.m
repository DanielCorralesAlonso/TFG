function [opt, opt_mu] = fit_logloss(X,Y)

    T = max(Y);
    d = length(X(1,:));

    m = T*d;
    n = length(Y);
    tau_vect = zeros(m,n);
    M = cell(n,1);

    for i = 1:n
        for j = 1:T
            M{i}(j,:) = phifunction(X(i,:),j,T);
        end
        tau_vect(:,i) =  phifunction(X(i,:),Y(i), T);
    end
    tau = mean(tau_vect,2);
    lambda = 0.3*std(tau_vect,0,2)/sqrt(n); 
    
    cvx_expert true %This suppresses the warning relating the successive approximation method.
    cvx_begin quiet
        variable muu(m)
        minimise(- tau'*muu + varphilog(M,muu,Y) + (lambda'*abs(muu))) 
    cvx_end

    opt = cvx_optval;
    opt_mu = muu;
end

