function [dist_vec] = dist_pt(pt_x, test)
    
    dist_vec = zeros(1,length(test));
    
    for i=1:length(test)
        dist_vec(i) = sqrt( (pt_x(1)-test(1,i))^2 + (pt_x(2)-test(2,i))^2 );
    end
        
end

