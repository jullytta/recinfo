// Diretório no qual o código feito em aula (que será aproveitado nesse trabalho) está armazenado
diretorio = '~/recinfo/Scilab/';

// Carregamos as funções definidas em outros arquivos que são importantes para
// esse script.
exec(diretorio+'pre-processamento.sce', -1); // normaliza_caixa_baixa, tokeniza, remove_stopwords
exec(diretorio+'matriz_incidencias.sce', -1); // gera_matriz_incidencias, imprime_matriz_inc
exec(diretorio+'modelo_probabilistico.sce', -1); // gera_simBM25
exec(diretorio+'modelo_vetorial.sce', -1); // gera_vetorial
exec(diretorio+'util.sce', -1); // gera_ranking
exec('~/recinfo/Trabalho2/src/learning_to_rank.sce', -1); // calcula_perda, encontra_beta


///////////// Leitura da entrada /////////////
exec('~/recinfo/Trabalho2/src/entrada.sce', -1);

///////////// Pré-processamento /////////////
textos = normaliza_caixa_baixa(textos);
termos = tokeniza(textos, separadores);
termos = remove_stopwords(termos, stopwords);

///// Geração da matriz de incidências  /////
incidencias = gera_matriz_incidencias(termos, textos);

// Vamos nos referir ao i-ésimo e-mail como "e-mail i".
s = size(textos);
nomes_textos = [];
for i = 1:s(1)
    nomes_textos = [nomes_textos, 'e-mail ' + string(i)];
end

// Imprimindo a matriz de incidências
imprime_matriz_inc(incidencias, termos, nomes_textos);



////////////////// Testes  //////////////////
consultas = ['pagamento fatura', 'erro'];

// Qual documento foi clicado pelo usuário na i-ésima consulta.
// Só consideramos queries nas quais aconteceu um clique.
cliques = [1, 2];

n_consultas = size(consultas);
n_consultas = n_consultas(2);

// Observamos diversos valores de b e identificamos qual minimiza
// as perdas para as consultas apresentadas.
// Tendências não consideradas.
[b, perda] = learn_to_rank_BM25(incidencias, consultas, cliques);

// Impressão de resultados para cada consulta.
for i = 1:n_consultas
    str = strcat(["///////// Consulta #", string(i)]);
    str = strcat([str, " /////////"]);
    disp(str);

    consulta = consultas(i);
    clique = cliques(i);

    // Modelo vetorial
    ranks_vetorial = gera_vetorial(incidencias);
    ranking_vet = gera_ranking(ranks_vetorial);
    perda_vet = calcula_perda_clique(clique, ranks_vetorial);
    disp("/////// Modelo vetorial ///////");
    disp("Ranks:");
    disp(ranks_vetorial);
    disp("Ranking:");
    disp(ranking_vet);
    disp("Perda:");
    disp(perda_vet);
    
    // Modelo probabilistico
    ranks_probabilistico = gera_simBM25(incidencias, 1, b);
    ranking_prob = gera_ranking(ranks_probabilistico);
    perda_prob = calcula_perda_clique(clique, ranks_probabilistico);
    disp("//// Modelo probabilístico ////");
    disp("Ranks:");
    disp(ranks_probabilistico);
    disp("Ranking:");
    disp(ranking_prob);
    disp("Perda:");
    disp(perda_prob);
end
