// Normalização (caixa baixa)
// Transforma todo o 'texto' em caixa baixa.
// Importante para que não haja distinção entre
// 'Xadrez' e 'xAdReZ'
function [texto_normalizado]=normaliza_caixa_baixa(texto)
    texto_normalizado = convstr(texto, 'l');
endfunction

// Tokenização
// Retorna uma lista sem repetição e em ordem alfabética
// de termos encontrados em 'textos'.
function [termos]=tokeniza(textos, separadores)
    s = size(textos);
    termos = [];

    for i = 1:s(1)
        termos = [termos; tokens(textos(i), separadores)];
    end

    // Remove repetições
    termos = unique(termos);
    
    // Coloca em ordem léxica
    termos = gsort(termos, 'lr', 'i');
endfunction

// Remoção de stopwords
// Dada uma lista de termos e uma lista de stopwords,
// retorna uma lista com todos os termos que não são
// stopwords. 
function [termos_s_stopwords]=remove_stopwords(termos, stopwords)
    termos_s_stopwords = setdiff(termos, stopwords);
endfunction
