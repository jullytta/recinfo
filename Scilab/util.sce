// Recebe os ranks de cada documento e retorna seus índices, em ordem
// do maior rank para o menor, excluindo ranks <= 0.
function [ranking]=gera_ranking(ranks)
    [bin, ranking] = gsort(ranks);
    // bin > 0 retorna um vetor de bool. Elementos maiores que zero são
    // marcados com T. ranking(bin > 0) remove todos que estão marcados
    // com F, ou seja, os menores ou iguais a 0.
    ranking = ranking(bin>0);
endfunction

// CÁLCULO DO Ni //
// n(i) é o número de documentos nos quais o termo i aparece
function [n]=get_n_docs(incidencias)
    n = [];
    
    s = size(incidencias);
    s_termos = s(1);
    s_textos = s(2);

    // Para cada termo
    for i = 1:s_termos(1)
        ni = 0;
        for j = 1:s_textos(1)
            if incidencias(i, j) > 0 then
                ni = ni + 1;
            end
        end
        n = [n, ni];
    end
endfunction
