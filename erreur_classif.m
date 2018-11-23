function min_diff=erreur_classif(clas,clas2)
    clas=clas(:)';
    clas2=clas2(:)';
    nbre_classe=max(clas2);
    n=length(clas);

    p=perms(1:nbre_classe);
    min_diff=inf;


    for b=1:size(p,1),
        clas_tmp=zeros(1,n);
        for bb=1:nbre_classe,
            clas_tmp=clas_tmp+(clas2==bb)*p(b,bb);
        end
        mdiff=sum(clas_tmp~=clas);
        if mdiff<min_diff
            min_diff=mdiff;
        end
    end
end

