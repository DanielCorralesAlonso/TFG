function phi = phifunction(x,y, T)
    d = length(x);
    m = T*d;
    I = eye(T);
    phi = zeros(m,length(y));
    for j = 1:length(y)
        phi(:,j) = kron(I(:,y(j)),x');
    end
end