function [rev]=revocacao(relevantes, recuperados)
    intersecao = intersect(recuperados, relevantes);
    
    [s_rel, bin] = size(relevantes);
    [bin, s_int] = size(intersecao);

    rev = s_int/s_rel;
endfunction

function [p]=precisao(relevantes, recuperados)
    intersecao = intersect(recuperados, relevantes);
    
    [s_rec, bin] = size(recuperados);
    [bin, s_int] = size(intersecao);
    
    p = s_int/s_rec;
endfunction

function [f]=medida_f(rev, p, Beta)
    f = ((1 + (Beta^2)) * p * rev) / (((Beta^2) * p) + rev);
endfunction

function [f1]=medida_f1(rev, p)
    f1 = medida_f(rev, p, 1);
endfunction
