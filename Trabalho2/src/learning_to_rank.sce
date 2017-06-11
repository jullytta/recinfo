diretorio = '~/recinfo/Scilab/';
exec(diretorio+'modelo_probabilistico.sce', -1); // gera_simBM25

// Função de perda dada como exemplo do modelo clássico Learning-to-Rank.
// Penaliza pares fora de ordem.
function perda=calcula_perda(ranking_ideal, ranks_obtidos)
    s = size(ranking_ideal);
    s = s(2);

    perda = 0;
    for i = 1:s-1
        for j = i+1:s
            // Par x_i, x_j onde x_i é mais relevante que x_j
            x_i = ranking_ideal(i);
            x_j = ranking_ideal(j);
            
            // Perda é a diferença dos ranks ao quadrado, ou zero se a
            // dita diferença for negativa
            perda_parcial = ranks_obtidos(x_j) - ranks_obtidos(x_i);
            perda_parcial = max(0, perda_parcial);
            perda_parcial = perda_parcial^2;
        
            perda = perda + perda_parcial;
        end
    end
endfunction

// Função que escolhe um o valor de beta para BM25 que minimiza perdas,
// considerando uma consulta específica.
function b=encontra_beta(incidencias, ranking_ideal)
    min_perda = 10000; // infinito
    for temp_b = 0:0.05:1
        ranks = gera_simBM25(incidencias, 1, temp_b);
        perda = calcula_perda(ranking_ideal, ranks);
        if perda < min_perda then
            b = temp_b;
            min_perda = perda;
        end
    end
endfunction
