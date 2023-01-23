function [opt_val, opt_mu] = fit_alphaloss(X,Y,alpha)

    T = max(Y);
    d = length(X(1,:));

    m = T*d;
    n = length(Y);
    tau_vect = zeros(m,n);
    
    for i = 1:n
        tau_vect(:,i) = phifunction(X(i,:),Y(i), T);
    end

    tau = mean(tau_vect,2); 
    lambda = 0.3*std(tau_vect,0,2)/sqrt(n);
    beta = alpha/(alpha-1);
    
    %When solving the minimization problem, a function representing the
    %restrictions is called. This function depends on the value
    %of alpha.
    
    % V_gt1 --- Function that calculates the restrictions in the case that
    %           alpha > 1.
    % V_lt1 --- Function that calculates the restrictions in the case that
    %           alpha < 1.
    if alpha > 1
        %cvx_precision high
        cvx_begin quiet
        variables muu(m) nuu(n)
        minimise(-tau'*muu - sum(nuu)/n + (lambda'*abs(muu))) 
        subject to 
            V_gt1(X,muu,nuu,beta,T) <= ones(n,1)
        cvx_end
    else
        %cvx_precision high
        cvx_begin quiet
        variables muu(m) nuu(n)
        minimise(-tau'*muu - sum(nuu)/n + (lambda'*abs(muu))) 
        subject to 
           V_lt1(X,muu,nuu,beta,T) <= ones(n,1)
        cvx_end
    end
    opt_val = cvx_optval;
    opt_mu = muu;    
end
