// Gera uma matriz de incidências termos x textos,
// ou seja, se temos n termos e m textos, o resultado
// é uma matriz n x m na qual incidencias(i, j) é igual
// a quantidade de vezes que o termo i aparece no texto j.
function [incidencias]=gera_matriz_incidencias(termos, textos)
    s = size(textos);
    incidencias = [];
    
    for i = 1:s(1)
        // Para cada texto, procuramos 'termos' dentro dele.
        // Importante separar o texto em tokens antes de fazer a busca.
        [inc, loc] = members(termos, tokens(textos(i),separadores));
        // Concatenamos com o que tínhamos anteriormente
        incidencias = cat(2, incidencias, inc);
    end
endfunction

// Imprime a matriz de incidências usando como legendas do eixo x
// os nomes dos textos/documentos e como legendas do eixo y os
// termos.
function imprime_matriz_inc(incidencias, termos, nomes_textos)
    // Precisamos transformar a matriz numérica de incidências
    // para string para fazer concatenações no futuro.
    tabela = string(incidencias);

    // Legendas do eixo y: termos
    tabela = cat(2, termos, tabela);

    // Legendas do eixo x: textos
    // Precisamos deixar a primeira posição em branco
    // (coluna dos termos)
    nomes_textos = [' ', nomes_textos];
    tabela = [nomes_textos; tabela];
    
    disp(tabela);
endfunction
