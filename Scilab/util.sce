// Recebe os ranks de cada documento e retorna seus índices, em ordem
// do maior rank para o menor, excluindo ranks <= 0.
function [ranking]=gera_ranking(ranks)
    [bin, ranking] = gsort(ranks);
    // bin > 0 retorna um vetor de bool. Elementos maiores que zero são
    // marcados com T. ranking(bin > 0) remove todos que estão marcados
    // com F, ou seja, os menores ou iguais a 0.
    ranking = ranking(bin>0);
endfunction
