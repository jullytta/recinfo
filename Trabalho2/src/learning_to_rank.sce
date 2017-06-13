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

// Função de perda parecida com o modelo clássico, porém na qual não
// conhecemos quais documentos são mais ou menos relevantes para a
// consulta. A única informação é qual documento foi clicado.
// Não leva em consideração nenhuma tendência.
function perda=calcula_perda_clique(clique, ranks_obtidos)
    s_docs = size(ranks_obtidos);
    s_docs = s_docs(2);
    
    perda = 0;
    for i = 1:s_docs
        // Para todo documento que não foi clicado e tem rank maior
        // do que o documento clicado, vamos calcular a perda.
        // Ou seja, o documento clicado é considerado mais relevante que
        // todos os outros, que são igualmente irrelevantes.
        if i <> clique & ranks_obtidos(clique) < ranks_obtidos(i) then
            perda_parcial = ranks_obtidos(i) - ranks_obtidos(clique);
            perda_parcial = max(0, perda_parcial);
            perda_parcial = perda_parcial^2;
        
            perda = perda + perda_parcial;
        end
    end
endfunction

// Função que escolhe um o valor de beta para BM25 que minimiza perdas,
// considerando um conjunto de consultas e quais documentos foram clicados
// em cada uma delas.
// Não leva em consideração tendências.
function [b, perda]=learn_to_rank_BM25(incidencias, consultas, cliques)
    min_perda = 100000; // infinito
    n_consultas = size(consultas);
    n_consultas = n_consultas(2);

    // Testa diferentes valores de beta
    for temp_b = 0:0.05:1
        perda_total = 0;
        perda_parcial = 0;
        
        // Olha para todas as consultas
        for i = 1:n_consultas
            consulta = consultas(i);
            clique = cliques(i);
            
            ranks = gera_simBM25(incidencias, 1, temp_b);
            
            // Perda da i-ésima consulta
            perda_parcial = calcula_perda_clique(clique, ranks);
            
            // Perda da escolha de b
            perda_total = perda_total + perda_parcial;
        end
        
        // Média sobre todas as consultas
        perda_total = perda_total/n_consultas;
        
        if perda_total < min_perda then
            b = temp_b;
            min_perda = perda_total;
        end
    end
    
    // Retorna a menor perda possível, atingida com o b escolhido.
    perda = min_perda;
endfunction
