function [X1,Y1] = mixtura_gaussiana

muu{1} = [0 0];
sigmaa{1} = cat(3, [], [0.1 0.7]);

muu{2} = [0 0];
sigmaa{2} = cat(3,[],[0.5 0.2]);

T = 2;

p = [1/2 1/2];
w{1} = 1;
w{2} = 1;

num_points = 1000;

X1 = zeros(num_points,2);
Y1 = zeros(num_points,1);
for k = 1:num_points
    rng(k)
    Y1(k,1) = mnrnd(1,p,1)*(1:T)';
    j_vect = mnrnd(1,w{Y1(k,1)},1);
    r = length(j_vect(1,:));
    j = j_vect*(1:r)';
    X1(k,:) = mvnrnd(muu{Y1(k,1)}(j,:),diag(sigmaa{Y1(k,1)}(1,:,j)));
end

hold on 
gscatter(X1(:,1), X1(:,2),Y1,'rgb','.')