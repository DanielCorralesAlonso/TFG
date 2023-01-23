function S = subsetsY(n)
    S = {};
    V = [];
    for i = 1:n
        V = cat(2,V,i);
    end

    for k = 1:n
        comb = nchoosek(V,k);
        for j = 1:length(comb(:,1))
            S = cat(2,S,{comb(j,:)});
        end
    end
end