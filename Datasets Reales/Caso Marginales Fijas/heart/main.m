%addpath('/Documentos de BCAM/MATLAB/cvx') 

%cvx_setup
%cvx_solver mosek
addpath('C:\Users\Almacen2\Documents\dani\Universidad\TFG\Código\Datasets Reales\Caso Marginales\Funciones')

Dataset = readmatrix('heart.csv');
n = length(Dataset(:,1));
d = length(Dataset(1,:)) - 1;
Dataset(isnan(Dataset)) = 0;
fileID = fopen("Error.txt",'w');
num_feat = 300;

instances = Dataset(:,1:d);
normalised_instances = zscore(instances);
psi_X = rnd_fou_feat(normalised_instances, num_feat, d);

labels = (Dataset(:,d+1) + 1)/2 + 1;

c = cvpartition(Dataset(:,d+1), 'Kfold', 10, 'Stratify', true);

alpha_list = [1, 1.5, 2, 3,4, 5,6, 7,8,9,...
       10,12,15,17,20,25,30,35,40,45,50,55,60, Inf];

avg_err_list = [];
avg_det_err_list = [];
avg_opt_val_list = [];
for j = 1:length(alpha_list)
    alpha = alpha_list(j);
    err_list = [];
    det_err_list = [];
    opt_val_list = [];
    for k = 1:10
        X_train = []; X_test = [];
        Y_train = []; Y_test = [];
        indx_train = c.training(k);
        for i = 1:length(indx_train)
            if indx_train(i) == 1
                X_train = cat(1, X_train, psi_X(i,:));
                Y_train = cat(1, Y_train, labels(i));
            else 
                X_test = cat(1, X_test, psi_X(i,:));
                Y_test = cat(1, Y_test, labels(i)) ;
            end
        end

        T = max(Y_train);

        if alpha == 1
            [opt_val, opt_mu] = fit_logloss(X_train,Y_train);
            [h_vect] = pred_logloss(opt_mu, X_test, T);
        elseif alpha == Inf
            [opt_val, opt_mu] = fit_01loss(X_train,Y_train);
            [h_vect] = pred_01loss(opt_mu, X_test, T);
        else
            [opt_val, opt_mu] = fit_alphaloss(X_train, Y_train, alpha);
            [h_vect] = pred_alphaloss(opt_mu, alpha, X_test, T);
        end
        
        s = 0; cont = 0;
        for i = 1:length(X_test(:,1))
            s = s + h_vect(i, Y_test(i));

            if h_vect(i,1) >= h_vect(i,2)
                val = 1;
                cont = cont + double(val == Y_test(i,1));
            else
                val = 2;
                cont = cont + double(val == Y_test(i,1));
            end
        end

        error = 1 - s / length(X_test(:,1));
        det_err = 1 - cont/length(X_test(:,1));

        det_err_list = cat(2,det_err_list,det_err);
        err_list = cat(2,err_list, error);
        opt_val_list = cat(2,opt_val_list,opt_val);
    end

    avg_det_err = mean(det_err_list);
    avg_det_err_list = cat(2, avg_det_err_list, avg_det_err);

    avg_err = mean(err_list);
    avg_err_list = cat(2,avg_err_list, avg_err);

    avg_opt_val = mean(opt_val_list);
    avg_opt_val_list = cat(2,avg_opt_val_list, avg_opt_val);

    if alpha == 1
        fprintf(fileID,'For alpha = %4.2f (log-case) \n', alpha);
    elseif alpha == Inf
        fprintf(fileID,'For alpha = %4.2f (01-case) \n', alpha);
    else
        fprintf(fileID,'For alpha = %4.2f \n', alpha);
    end

    fprintf(fileID,'--> Error is %8.6f \n', avg_err);
    fprintf(fileID, '--> Deterministic error is %8.6f \n', avg_det_err);
    fprintf(fileID,'--> Minimax solution is %8.6f \n', avg_opt_val);
    
end

save('variables.mat', 'alpha_list', 'avg_err_list', 'avg_det_err_list','avg_opt_val_list')


figure;

axes1 = axes;
hold(axes1,'on');

YMatrix = [avg_opt_val_list; avg_err_list; avg_det_err_list];

plot1 = plot(alpha_list,YMatrix);
set(plot1(1),'DisplayName','MRC');
set(plot1(2),'DisplayName','probabilistic error');
set(plot1(3),'DisplayName','deterministic error');

xlabel({'\alpha'});

title({'Heart dataset'});

hold(axes1,'off');
legend(axes1,'show');

saveas(figure(1),sprintf('error_bound'))

