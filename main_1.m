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
plot(test(1,:),test(2,:), 'r*');
str = sprintf('affichage du jeu de données test (%s)', data1_aff);
title(str);
w = waitforbuttonpress;

figure();
affiche_classe(test,oracle_test);
str = sprintf('Visualisation de la classification de test avec testOracle (%s)', data1_aff);
title(str);
w = waitforbuttonpress;

figure();
plot(x(1,:),x(2,:), 'b*');
str = sprintf('affichage du jeu de données x (%s)', data1_aff);
title(str);
w = waitforbuttonpress;

% KNN
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



% Bayes

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

figure();
plot(x(1,:),x(2,:), 'r*');
str = sprintf('affichage du jeu de données x (%s)', data2_aff);
title(str);
w = waitforbuttonpress;


% Bayes

% calcul moyenne, sigma et P
nbr_clas = 3;
moy = zeros(2,nbr_clas);
sigma = zeros(2,2,nbr_clas);
P = zeros(1,nbr_clas);

% Sachant que pour ce cas, la disposition des échantillions par rapport à
% leurs classes n'est pas le même que pour l'exemple précedent (50 1er
%échantillions classe 1, 50 2eme échantillions clase 2,...). De ce fait ne
% devons calculer la moyenne et sigma en fonction des étiquettes de ces
% échnatillions.

% Pour simplifier notre calcul, nous allons réorganiser notre tableau
% d'échnatillions dans un nouveu tableau test_org

test_org = zeros(size(test));

% moyenne
a = 1;
for i=1:nbr_clas
    for j=1:length(test)
        if orig(j) == i
            test_org(:,a) = test(:,j);
            a = a + 1;
        end
    end
end
        
moy(:,1) = mean(test_org(:,1:50)');
moy(:,2) = mean(test_org(:,51:100)');
moy(:,3) = mean(test_org(:,101:150)');

% sigma

sigma(:,:,1) = cov(test_org(:,1:50)');
sigma(:,:,2) = cov(test_org(:,51:100)');
sigma(:,:,3) = cov(test_org(:,101:150)');

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

% KNN
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

%% No Gaussian distribution : unknown distribution

clear all; close all; clc;

data4 = 'td3_d4.mat';
data4_aff = 'td3 d4';
load(data4);

figure();
plot(test(1,:),test(2,:), 'b*');
str = sprintf('affichage du jeu de données test (%s)', data4_aff);
title(str);
w = waitforbuttonpress;

oracle_test = zeros(1,210);

oracle_test(1,1:70) = 1;
oracle_test(1,71:140) = 2;
oracle_test(1,141:210) = 3;

figure();
affiche_classe(test,oracle_test);
str = sprintf('Visualisation de la classification de test avec testOracle (%s)', data4_aff);
title(str);
w = waitforbuttonpress;

figure();
plot(x(1,:),x(2,:), 'r*');
str = sprintf('affichage du jeu de données x (%s)', data4_aff);
title(str);
w = waitforbuttonpress;

% Bayes

% calcul moyenne, sigma et P
nbr_clas = 3;
moy = zeros(2,nbr_clas);
sigma = zeros(2,2,nbr_clas);
P = zeros(1,nbr_clas);

moy(:,1) = mean(test(:,1:70)');
moy(:,2) = mean(test(:,71:140)');
moy(:,3) = mean(test(:,141:210)');

% sigma

sigma(:,:,1) = cov(test(:,1:70)');
sigma(:,:,2) = cov(test(:,71:140)');
sigma(:,:,3) = cov(test(:,141:210)');

% P 
P(1) = 70/210;
P(2) = 70/210;
P(3) = 70/210;

clas_x_Bayes = decision_bayes(moy, sigma, P, x);

er_cl_Bayes_4 = (erreur_classif(clasapp,clas_x_Bayes)/length(clasapp))*100;

figure();
affiche_classe(x, clas_x_Bayes);
str = sprintf('Visualisation de la classification de x avec Bayes (%s) \n erreur clas = %f%%', data4_aff, er_cl_Bayes_4);
title(str);
w = waitforbuttonpress;

% KNN
K = 17;
a = 0;
er_cl_KNN_d4 = zeros(1,8);
for k=1:2:K
    clas_x_Knn = decision_knn(test, oracle_test, k, x);
    
    a = a + 1;
    er_cl_KNN_d4(1,a) = (erreur_classif(clasapp,clas_x_Knn)/length(clasapp))*100;
    
    figure();
    affiche_classe(x, clas_x_Knn);
    str = sprintf('Visualisation de la classification de x avec Knn pour k=%d (%s) \n erreur clas = %f%%', k, data4_aff, er_cl_KNN_d4(1,a));
    title(str);
    w = waitforbuttonpress;
end

figure();
plot([1,3,5,7,9,11,13,15,17], er_cl_KNN_d4);
xlabel('K');
ylabel('erreur class (%)');
str = sprintf('Courbe d erreur clas pour les différentes valeur de k (%s)', data4_aff);
title(str);
w = waitforbuttonpress;

% Close all figures

W = waitforbuttonpress;

if W == 1
    close all;
end










