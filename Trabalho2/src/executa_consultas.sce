// Diretório no qual o código feito em aula (que será aproveitado nesse trabalho) está armazenado
diretorio = '~/recinfo/Scilab/';

// Carregamos as funções definidas em outros arquivos que são importantes para
// esse script.
exec(diretorio+'pre-processamento.sce', -1); // normaliza_caixa_baixa, tokeniza, remove_stopwords
exec(diretorio+'matriz_incidencias.sce', -1); // gera_matriz_incidencias, imprime_matriz_inc


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
// Primeira consulta
consulta = ['banco pagamento'];

// Quais documentos são relevantes para a consulta
R = [1];

