function [ clas ] = decision_knn(test, classe_origine, k, x)
    
    clas = zeros(1,length(x));
    for i=1:length(x)
        
        %Calcul des distances pour le point x(i) avec les points de test
        dist_vec = dist_pt(x(:,i), test);
        
        %Récupération des voisins k les plus proches
        ngb_k = neighbor_k(dist_vec, k);
        
        %Calcul du vote des voisins
        vec_vote = zeros(1,max(classe_origine));
        for j=1:k
            vec_vote(classe_origine(ngb_k(j))) = vec_vote(classe_origine(ngb_k(j))) + 1;
        end
        
        %Affectation du point x(i) 
        [MAX, clas(i)] = max(vec_vote);
    end

end

