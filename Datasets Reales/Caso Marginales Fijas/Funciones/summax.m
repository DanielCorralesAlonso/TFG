function s = summax(M,l,mu)
    s = 0;
    for i = 1:length(M)
        s = s + max(M{i}*mu - l);
    end
end