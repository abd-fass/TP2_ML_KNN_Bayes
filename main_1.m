clear all; close all; clc;

%% Pour pouvoir visualiser les résultats sur les figures, 
% il faudrait appuyer sur une touche de clavier qui va permettre de 
% faire défiler les figures une pas une

%%
data1 = 'td3_d1.mat';
data1_aff = 'td3 d1'
load(data1);

oracle_test = [];

oracle_test(1:50) = 1;
oracle_test(51:100) = 2;
oracle_test(101:150) = 3;

figure();
plot(test(1,:),test(2,:), 'b*');
str = sprintf('affichage du jeu de données test (%s)', data1_aff);
title(str);
w = waitforbuttonpress;

figure();
affiche_classe(test,oracle_test);
str = sprintf('Visualisation de la classification de test avec testOracle (%s)', data1_aff);
title(str);
w = waitforbuttonpress;

figure();
plot(x(1,:),x(2,:), 'r*');
str = sprintf('affichage du jeu de données x (%s)', data1_aff);
title(str);
w = waitforbuttonpress;

%% KNN
K = 17;
a = 0;
er_cl_KNN_d1 = zeros(1,8);
for k=1:2:K
    clas_x_Knn = decision_knn(test, oracle_test, k, x);
    
    a = a + 1;
    er_cl_KNN_d1(1,a) = (erreur_classif(clasapp,clas_x_Knn)/length(clasapp))*100;
    
    figure();
    affiche_classe(x, clas_x_Knn);
    str = sprintf('Visualisation de la classification de x avec Knn pour k=%d (%s) \n erreur clas = %f%%', k, data1_aff, er_cl_KNN_d1(1,a));
    title(str);
    w = waitforbuttonpress;

end

figure();
plot([1,3,5,7,9,11,13,15,17], er_cl_KNN_d1);
xlabel('K');
ylabel('erreur class (%)');
str = sprintf('Courbe d erreur clas pour les différentes valeur de k (%s)', data1_aff);
title(str);
w = waitforbuttonpress;



%% Bayes

% calcul moyenne, sigma et P
nbr_clas = 3;
moy = zeros(2,nbr_clas);
sigma = zeros(2,2,nbr_clas);
P = zeros(1,nbr_clas);

% moyenne
moy(:,1) = mean(test(:,1:50)');
moy(:,2) = mean(test(:,51:100)');
moy(:,3) = mean(test(:,101:150)');

% sigma
sigma(:,:,1) = cov(test(:,1:50)');
sigma(:,:,2) = cov(test(:,51:100)');
sigma(:,:,3) = cov(test(:,101:150)');

% P 
P(1) = 50/150;
P(2) = 50/150;
P(3) = 50/150;

clas_x_Bayes = decision_bayes(moy, sigma, P, x);
er_cl_Bayes_d1 = (erreur_classif(clasapp,clas_x_Bayes)/length(clasapp))*100;

figure();
affiche_classe(x, clas_x_Bayes);
str = sprintf('Visualisation de la classification de x avec Bayes (%s) \n erreur clas = %f%%', data1_aff, er_cl_Bayes_d1);
title(str);
w = waitforbuttonpress;


W = waitforbuttonpress;

if W == 1
    close all;
end

%% Training data without expert : use the KMEAN algorithm

clear all; close all; clc;

data2 = 'td3_d2.mat';
data2_aff = 'td3 d2';
load(data2);

figure();
plot(test(1,:),test(2,:), 'b*');
str = sprintf('affichage du jeu de données test (%s)', data2_aff);
title(str);
w = waitforbuttonpress;

figure();
affiche_classe(test,orig);
str = sprintf('Visualisation de la classification de test avec orig (%s)', data2_aff);
title(str);
w = waitforbuttonpress;


%% Bayes

% calcul moyenne, sigma et P
nbr_clas = 3;
moy = zeros(2,nbr_clas);
sigma = zeros(2,2,nbr_clas);
P = zeros(1,nbr_clas);

% moyenne
moy(:,1) = mean(test(:,1:50)');
moy(:,2) = mean(test(:,51:100)');
moy(:,3) = mean(test(:,101:150)');

% sigma
sigma(:,:,1) = cov(test(:,1:50)');
sigma(:,:,2) = cov(test(:,51:100)');
sigma(:,:,3) = cov(test(:,101:150)');

% P 
P(1) = 50/150;
P(2) = 50/150;
P(3) = 50/150;

clas_x_Bayes = decision_bayes(moy, sigma, P, x);

er_cl_Bayes_d2 = (erreur_classif(clasapp,clas_x_Bayes)/length(clasapp))*100;

figure();
affiche_classe(x, clas_x_Bayes);
str = sprintf('Visualisation de la classification de x avec Bayes (%s) \n erreur clas = %f%%', data2_aff, er_cl_Bayes_d2);
title(str);
w = waitforbuttonpress;

%% KNN
K = 17;
a = 0;
er_cl_KNN_d2 = zeros(1,8);
for k=1:2:K
    clas_x_Knn = decision_knn(test, orig, k, x);
    
    a = a + 1;
    er_cl_KNN_d2(1,a) = (erreur_classif(clasapp,clas_x_Knn)/length(clasapp))*100;
    
    figure();
    affiche_classe(x, clas_x_Knn);
    str = sprintf('Visualisation de la classification de x avec Knn pour k=%d (%s) \n erreur clas = %f%%', k, data2_aff, er_cl_KNN_d2(1,a));
    title(str);
    w = waitforbuttonpress;
end

figure();
plot([1,3,5,7,9,11,13,15,17], er_cl_KNN_d2);
xlabel('K');
ylabel('erreur class (%)');
str = sprintf('Courbe d erreur clas pour les différentes valeur de k (%s)', data2_aff);
title(str);
w = waitforbuttonpress;

% Close all figures

W = waitforbuttonpress;

if W == 1
    close all;
end








