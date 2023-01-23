clear all
close all 

%addpath('C:\Users\danie\Documents\dani\Universidad\TFG\Código\cvx')
%cvx_setup
%cvx_solver mosek
%cvx_save_prefs
addpath('C:\Users\danie\Documents\dani\Universidad\TFG\Código\Caso General Dataset Sintético\Funciones')

T = 2;
d = 2;
sigma_u = sqrt(d/2);
D = 500; %500;

[X1,Y1] = mixtura_gaussiana;

X1_norm = zscore(X1);

psi_X = rnd_fou_feat(X1_norm,D,d);
%alpha_list = [0.5, 0.8, 1, 1.2, 1.5, 2, 5, 10,20, 50, 75, Inf];
alpha_list = [0.8, 1, 2,5,10, Inf];
alpha_list = [5,10,Inf];
err_list = [];
opt_val_list = [];



for r = 1:length(alpha_list)
        clear figures
        alpha = alpha_list(r);
        if alpha == Inf 
            [opt_val, opt_mu, opt_nu] = fit_01loss(psi_X,Y1);
        elseif alpha == 1
            [opt_val, opt_mu] = fit_logloss(psi_X,Y1);
        else
            [opt_val, opt_mu, opt_nu] = fit_alphaloss(psi_X,Y1,alpha);
        end
        
        cont = 0;
        x = -3:0.2:3;
        y = -3:0.2:3;
        [Xm,Ym] = meshgrid(x,y);
        X_input = zeros(length(Xm(:,1))*length(Xm(1,:)), 2);
        for i = 1:length(Xm(:,1))
            for j = 1:length(Xm(1,:))
                cont = cont + 1;
                X_input(cont,:) = [Xm(i,j) Ym(i,j)];
            end
        end
        
        X_input_norm = zscore(X_input);
        psi_X_input = rnd_fou_feat(X_input_norm,D,d);
        
        if alpha == Inf 
            [h_pred] = pred_01loss(opt_mu,opt_nu, psi_X_input, T);
            Z1 = reshape(h_pred(:,1),length(Ym(1,:)),[])';
            [h_nLevels, h_cmap] = num_contours(h_pred(:,1));

            figure(1)
            hold on
            gscatter(X1(:,1), X1(:,2),Y1,['r','g','w'],'.')
            hold off
            
            figure(2)
            hold on
            colormap(h_cmap)
            [~, hCont] = contourf(Xm,Ym,Z1,h_nLevels);
            gscatter(X1(:,1), X1(:,2),Y1,['r','g','w'],'.');
            text = 'h_{01}(1|x) ';%  train error = ', num2str(error)];
            tit = title(text,'interpreter','tex');
            tit.FontSize = 10;
            hold off
            contourLegend(hCont)
           
            saveas(figure(2),sprintf('fig_h_loss01_D_%d',D))
            saveas(figure(2),sprintf('fig_h_loss01_D_%d',D),'jpeg')

        elseif alpha == 1

            [h_pred] = pred_logloss(opt_mu, psi_X_input, T);
            Z1 = reshape(h_pred(:,1),length(Ym(1,:)),[])';
            [h_nLevels, h_cmap] = num_contours(h_pred(:,1));

            p_vect = h_pred;
            Z2 = reshape(p_vect(:,1),length(Ym(1,:)),[])';
            [p_nLevels, p_cmap] = num_contours(p_vect(:,1));


            figure(1)
            hold on
            gscatter(X1(:,1), X1(:,2),Y1,['r','g','w'],'.')
            hold off
            
            figure(2)
            hold on
            colormap(h_cmap)
            [~, hCont] = contourf(Xm,Ym,Z1,h_nLevels);
            gscatter(X1(:,1), X1(:,2),Y1,['r','g'],'.')
            text = 'h_{log}(1|x) ';%  train error = ', num2str(error)];
            tit = title(text,'interpreter','tex');
            tit.FontSize = 10;
            hold off
            contourLegend(hCont)
            
            figure(3)
            hold on 
            colormap(p_cmap)
            [~, hCont] = contourf(Xm,Ym,Z2,p_nLevels);
            gscatter(X1(:,1), X1(:,2),Y1,['r','g','w'],'.');
            text = 'p_{log}(1|x)';
            tit = title(text,'interpreter','tex');
            tit.FontSize = 10;
            hold off
            contourLegend(hCont)
            

	        saveas(figure(2),sprintf('fig_h_%d_D_%d',r,D))
            saveas(figure(2),sprintf('fig_h_%d_D_%d',r,D),'jpeg')

            saveas(figure(3),sprintf('fig_p_%d_D_%d',r,D))
            saveas(figure(3),sprintf('fig_p_%d_D_%d',r,D),'jpeg')

        else
            [h_pred] = pred_alphaloss(opt_mu,opt_nu,alpha, psi_X_input, T);

            Z1 = reshape(h_pred(:,1),length(Ym(1,:)),[])';
            [h_nLevels, h_cmap] = num_contours(h_pred(:,1));

            h_pwr = h_pred.^(1/alpha);
            p_vect = (h_pwr)./ sum(h_pwr,2);
            Z2 = reshape(p_vect(:,1),length(Ym(1,:)),[])';
            [p_nLevels, p_cmap] = num_contours(p_vect(:,1));

            figure(1)
            hold on
            gscatter(X1(:,1), X1(:,2),Y1,['r','g','w'],'.');
            hold off
           

            figure(2)
            hold on
            colormap(h_cmap)
            [~,hCont] = contourf(Xm,Ym,Z1,h_nLevels);
            gscatter(X1(:,1), X1(:,2),Y1,['r','g','w'],'.');
            text = ['h_{\alpha}(1|x) for \alpha = ',num2str(alpha)];%,'   train error = ', num2str(error)];
            tit = title(text,'interpreter','tex');
            tit.FontSize = 10;
            hold off
            contourLegend(hCont)
            
            figure(3)
            hold on 
            colormap(p_cmap)
            [~, hCont] = contourf(Xm,Ym,Z2,p_nLevels);
            gscatter(X1(:,1), X1(:,2),Y1,['r','g','w'],'.');
            text = ['p_{\alpha}(1|x) for \alpha = ',num2str(alpha)];
            tit = title(text,'interpreter','tex');
            tit.FontSize = 10;
            hold off
            contourLegend(hCont)

            
            saveas(figure(2),sprintf('fig_h_%d_D_%d',r,D))
            saveas(figure(2),sprintf('fig_h_%d_D_%d',r,D),'jpeg')

            saveas(figure(3),sprintf('fig_p_%d_D_%d',r,D))
            saveas(figure(3),sprintf('fig_p_%d_D_%d',r,D),'jpeg')
        end
end
save('variables.mat','alpha_list', 'err_list', 'opt_val_list')
