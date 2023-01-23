function h_vect = predMRCdeter(opt_mu,X_test, T)
    n = length(X_test(:,1)); 
    d = length(X_test(1,:));
    %m = T*d;
    m = d;
    %I = eye(T);
    h_vect = zeros(n,1);

    for i = 1:n
        phi1 = zeros(m,1);
        phi2 = zeros(m,1);

        phi1(:,1) = -X_test(i,:)' /2;
        phi2(:,1) = X_test(i,:)' /2;
        %phi1(:,1) = kron(I(:,1), X_test(i,:)');
        %phi2(:,1) = kron(I(:,2),X_test(i,:)');

        if (phi1 - phi2)'*opt_mu < 0
            h_vect(i,1) = 1;
        else
            h_vect(i,1) = -1;
        end
    end
end