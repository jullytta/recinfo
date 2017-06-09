// A variavel diretorio esta instanciada em entrada.sce
// Opcionalmente, pode ser instanciada manualmente antes de executar
// este programa

// Funções utilitárias: get_n_docs
exec(diretorio+'util.sce', -1);

// Calcula pesos TF-IDF para um documento/consulta
// Incidencias é a matriz de incidencia desse documento/consulta
// n é um vetor onde a i-esima posição diz em quantos documentos o termo
// i aparece
// n_docs é o número de documentos na coleção
function [pesos]=calcula_pesos(incidencias, n, n_docs)
    s_inc = size(incidencias);
    pesos = zeros(s_inc(1), s_inc(2));
    for i = 1:s_inc(1)
        for j = 1:s_inc(2)
            fij = incidencias(i,j);
            if fij > 0 then
                pesos(i, j) = (1 + log2(fij))*log2(n_docs/n(i));
            end
        end
    end
endfunction

// Retorna um vetor com a norma de cada documento
function normas_docs=gera_normas(s_textos, pesos_docs)
    normas_docs = [];
    for j = 1:s_textos(1)
        pesos_j = pesos_docs(:,j);
        normas_docs = [normas_docs, norm(pesos_j)];
    end
endfunction

function ranks_vetorial=gera_vetorial(incidencias)
    s = size(incidencias);
    s_termos = s(1);
    s_textos = s(2);

    // n(i) é o número de documentos nos quais o termo i aparece
    n = get_n_docs(incidencias);
    
    // CÁLCULO DOS PESOS DE CADA DOCUMENTO //
    pesos_docs = calcula_pesos(incidencias, n, s_textos(1));
    
    // CÁLCULO DOS PESOS DA CONSULTA //
    // necessário saber a frequência de cada termo na consulta
    fq = gera_matriz_incidencias(termos, consulta);
    pesos_consulta = calcula_pesos(fq, n, s_textos(1));
    
    // VETOR NORMAS //
    // guarda a norma de cada documento
    normas_docs = gera_normas(s_textos, pesos_docs);
    
    // CÁLCULO DOS RANKS //
    ranks_vetorial = [];
    for j = 1:s_textos(1)
        pesos_j = pesos_docs(:,j);
        rank_j = (pesos_j' * pesos_consulta)/(normas_docs(j)*norm(pesos_consulta));
        ranks_vetorial = [ranks_vetorial, rank_j];
    end
endfunction

// TESTES //
//exec(diretorio+'inicializa_matriz_incidencias.sce', -1);

//ranks_vetorial = gera_vetorial(incidencias);
//disp(ranks_vetorial);
