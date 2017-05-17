// Simples (incompleta) implementação do algoritmo de PageRank

// i,j = 1 se existe uma aresta de j para i
matriz_incidencias = [ 0 0 1 0
                       1 0 0 0
                       1 1 0 1
                       0 0 0 0 
                      ];

num_pags = size(matriz_incidencias);
num_pags = num_pags(1);

for pagina = 1:num_pags
    incidencias = matriz_incidencias(1, :);
    for vizinho = 1:num_pags
        inc = incidencias(vizinho)
        if inc == 1
            disp(vizinho);
        end
    end
end
