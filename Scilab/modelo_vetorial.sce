// A variavel diretorio esta instanciada em entrada.sce
// Opcionalmente, pode ser instanciada manualmente antes de executar este programa 

// Inicializa matriz 'incidencias'
exec(diretorio+'inicializa_matriz_incidencias.sce', -1);

// Carrega a ponderação de termos
exec(diretorio+'ponderacao_de_termos.sce', -1);

// CÁLCULO DOS PESOS DE CADA DOCUMENTO //
pesos_docs = calcula_pesos(incidencias, n, s_textos(1));

// CÁLCULO DOS PESOS DA CONSULTA //
// necessário saber a frequência de cada termo na consulta
fq = gera_matriz_incidencias(termos, consulta);

pesos_consulta = calcula_pesos(fq, n, s_textos(1));


// VETOR NORMAS //
// guarda a norma de cada documento
normas_docs = [];
for j = 1:s_textos(1)
    pesos_j = pesos_docs(:,j);
    normas_docs = [normas_docs, norm(pesos_j)];
end


// CÁLCULO DOS RANKS //
ranks_vetorial = [];
for j = 1:s_textos(1)
    pesos_j = pesos_docs(:,j);
    rank_j = (pesos_j' * pesos_consulta)/(normas_docs(j)*norm(pesos_consulta));
    ranks_vetorial = [ranks_vetorial, rank_j];
end

//disp(ranks_vetorial);