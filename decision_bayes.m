function [ clas ] = decision_bayes(m, sigma, p, x)
    
    clas = zeros(1,length(x));
    [L, C, nbr_clas] = size(sigma);
    for i=1:length(x)
        
        val = zeros(1,nbr_clas);
        for j=1:nbr_clas
            val(1,j) = -(1/2)*((x(:,i) - m(:,j))')*(inv(sigma(:,:,j)))*(x(:,i) - m(:,j)) - (1/2)*log(det(sigma(:,:,j))) + log(p(j));
        end
        [MAX, clas(i)] = max(val);
    end

end

