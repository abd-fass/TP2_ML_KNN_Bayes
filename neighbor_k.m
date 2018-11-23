function [ngb_k] = neighbor_k(dist, k)
    
    ngb_k = zeros(1,k);
    
    for i=1:k
        [Min, indice] = min(dist);
        ngb_k(i) = indice;
        dist(indice)=[];
    end

end

