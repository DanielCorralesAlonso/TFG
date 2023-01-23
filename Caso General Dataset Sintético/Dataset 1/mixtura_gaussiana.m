function [X1,Y1] = mixtura_gaussiana

muu{1} = [1.5 0; 0 -1.5; -1.5 0; 0 1.5];
s1 = [0.2 0.5;0.5 0.2; 0.2 0.5; 0.5 0.2];
sigmaa{1} = [];
for i = 1:4
    sigmaa{1} = cat(3, sigmaa{1}, s1(i,:));
end

muu{2} = [0 0];
sigmaa{2} = cat(3,[],[0.3 0.3]);

T = 2;
p = [4/5 1/5];
w{1} = [1/4 1/4 1/4 1/4];
w{2} = 1;

num_ejemplos = 1000;

X1 = zeros(num_ejemplos,2);
Y1 = zeros(num_ejemplos,1);
for k = 1:num_ejemplos
    rng(k)
    Y1(k,1) = mnrnd(1,p,1)*(1:T)';
    j_vect = mnrnd(1,w{Y1(k,1)},1);
    r = length(j_vect(1,:));
    j = j_vect*(1:r)';
    X1(k,:) = mvnrnd(muu{Y1(k,1)}(j,:),diag(sigmaa{Y1(k,1)}(1,:,j)));
end

hold on 
gscatter(X1(:,1), X1(:,2),Y1,'rgb','.')