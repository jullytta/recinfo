// A variavel diretorio esta instanciada em entrada.sce
// Opcionalmente, pode ser instanciada manualmente antes de executar este programa 

// Precisamos da matriz de incidências
exec(diretorio+'inicializa_matriz_incidencias.sce', -1);

// Precisamos de N e ni, também.
// Idealmente existiria uma função...
exec(diretorio+'ponderacao_de_termos.sce', -1);

// MODELO PROBABILÍSTICO //
// Constantes configuráveis
K1 = 1;
b = 0.75;

s_inc = size(incidencias);
n_termos = s_inc(1);
n_textos = s_inc(2);

media_tamanho = 0;
tamanho_texto = [];
// Calculamos o tamanho dos documentos considerando quantos termos temos neles
for j=1:n_textos
    tam = sum(incidencias(:,j));
    media_tamanho = media_tamanho + tam;
    tamanho_texto = [tamanho_texto, tam];
end
media_tamanho = media_tamanho/n_textos;

B = zeros(n_termos, n_textos);
for i=1:n_termos
    for j=1:n_textos
        fij = incidencias(i, j);
        Bij_upper = (K1 + 1)*fij;
        Bij_lower = K1*( (1-b) + b*(tamanho_texto(j) / media_tamanho) ) + fij;
        B(i, j) = Bij_upper / Bij_lower;
    end
end


inc_consulta = gera_matriz_incidencias(termos, consulta);

// Supondo que ni foi calculado previamente e está no vetor n
N = n_textos;
simBM25 = zeros(1, n_textos);
for j=1:n_textos
    for i=1:n_termos
        // Só termos que estão na consulta e no documento
        if (incidencias(i, j) > 0) & (inc_consulta(i) > 0) then
            simBM25(j) = simBM25(j) + B(i,j) * log2((N - n(i)+0.5)/(n(i) + 0.5));
        end
    end
end

//disp(simBM25);


