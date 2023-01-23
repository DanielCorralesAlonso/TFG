function [psi_X] = rnd_fou_feat(X_norm, D, dim)

sigma_u = sqrt(dim/2);
psi_X = zeros(length(X_norm),2*D + 1);
psi_X(:,1) = ones(length(X_norm),1);
for k = 1:length(X_norm)
    for j = 1:D
        rng(j)
        u = mvnrnd(zeros(dim,1), eye(dim)/(sigma_u)^2);
        op = exp(u*X_norm(k,:)'*1i);
        arr = [real(op); imag(op)];
        psi_X(k,(2*j):(2*j+1)) = arr;   
    end
end 