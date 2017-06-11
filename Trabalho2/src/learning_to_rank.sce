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
        end
        
        perda = perda + perda_parcial;
    end
endfunction
