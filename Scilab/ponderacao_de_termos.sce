// A variavel diretorio esta instanciada em entrada.sce
// Opcionalmente, pode ser instanciada manualmente antes de executar este programa 

// Inicializa matriz 'incidencias'
exec(diretorio+'inicializa_matriz_incidencias.sce', -1);

// CÁLCULO DO Ni //
// TODO: Tornar uma funcao separadas
// ni é o número de documentos nos quais o termo i aparece
n = [];
s_termos = size(termos);
s_textos = size(textos);
// Para cada termo
for i = 1:s_termos(1)
    ni = 0;
    for j = 1:s_textos(1)
        if incidencias(i, j) > 0 then
            ni = ni + 1;
        end
    end
    n = [n, ni];
end

// CÁLCULO DOS PESOS DE CADA DOCUMENTO //
s_inc = size(incidencias);
pesos_docs = zeros(s_inc(1), s_inc(2));
for i = 1:s_inc(1)
    for j = 1:s_inc(2)
        fij = incidencias(i,j);
        if fij > 0 then
            pesos_docs(i, j) = (1 + log2(fij))*log2(s_inc(2)/n(i));
        end
    end
end

// CÁLCULO DOS PESOS DA CONSULTA //
// necessário saber a frequência de cada termo na consulta
fq = gera_matriz_incidencias(termos, consulta);

s = size(fq);
pesos_consulta = zeros(s(1), s(2));
for i = 1:s(1)
    fiq = fq(i);
    if fiq > 0 then
        pesos_consulta(i) = (1 + log2(fiq)) * log2(s_inc(2)/n(i));
    end
end


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
