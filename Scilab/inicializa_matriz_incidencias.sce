// Esse script inicializa e imprime uma variável 'incidencias', com a matriz
// de incidências vinda do script 'entrada.sce'.

// Caminho completo para o diretorio no qual se encontram os
// scripts do scilab
diretorio = 'C:\Users\Convidado\Downloads\'

// Entrada do programa
exec(diretorio+'entrada.sce', -1);

// Funções de tratamento de dados
exec(diretorio+'pre-processamento.sce', -1);

// Funções de criação e manipulação da matriz de incidências
exec(diretorio+'matriz_incidencias.sce', -1);


///////////// Pré-processamento /////////////
textos = normaliza_caixa_baixa(textos);
termos = tokeniza(textos, separadores);
termos = remove_stopwords(termos, stopwords);

///// Geração da matriz de incidências  /////
incidencias = gera_matriz_incidencias(termos, textos);

// Nossos textos não têm nome, portanto vamos chamá-los de 'texto i'
s = size(textos);
nomes_textos = [];
for i = 1:s(1)
    nomes_textos = [nomes_textos, 'texto ' + string(i)];
end

// Imprimindo a matriz de incidências
imprime_matriz_inc(incidencias, termos, nomes_textos);
