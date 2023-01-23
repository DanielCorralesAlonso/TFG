function max_m = xmax(M,l,mu)
    for i = 1:length(M)
        m(i) = max(M{i}*mu - l);
    end
    max_m = max(m);
end