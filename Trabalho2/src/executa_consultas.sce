// Diretório no qual o código feito em aula (que será aproveitado nesse trabalho) está armazenado
diretorio = '~/recinfo/Scilab/';

// Carregamos as funções definidas em outros arquivos que são importantes para
// esse script.
exec(diretorio+'pre-processamento.sce', -1); // normaliza_caixa_baixa, tokeniza, remove_stopwords
exec(diretorio+'matriz_incidencias.sce', -1); // gera_matriz_incidencias, imprime_matriz_inc
exec(diretorio+'modelo_probabilistico.sce', -1); // gera_simBM25
exec(diretorio+'modelo_vetorial.sce', -1); // gera_vetorial
exec(diretorio+'util.sce', -1); // gera_ranking


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
///////////// Primeira consulta /////////////
consulta = ['pagamento fatura'];

// Quais documentos são relevantes para a consulta
R = [1];

// Qual o ranking "ideal" para a consulta dada
ranking_ideal = [1];


// Modelo vetorial
ranks_vetorial = gera_vetorial(incidencias);
ranking_vet = gera_ranking(ranks_vetorial);
disp(ranks_vetorial);
disp(ranking_vet);

// Modelo probabilistico
ranks_probabilistico = gera_simBM25(incidencias, 1, 0.75);
ranking_prob = gera_ranking(ranks_probabilistico);
disp(ranks_probabilistico);
disp(ranking_prob);
