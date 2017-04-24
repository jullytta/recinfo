// Encontra o valor binario das incidências para cada
// termo pesquisado.
// Se o termo 1 está presente nos textos 1 e 3, então
// seu valor binário é 101, ou seja, 5.
// Importante para fazer a consulta booleana.
function [bins]=bins_correspondentes(termos_pesquisados, termos, incidencias)
    s = size(incidencias);
    n_textos = s(2);
    
    s = size(termos_pesquisados);
    n_termos_pesquisados = s(1);
    
    // Encontramos a posição dos termos pesquisados na lista de
    // termos, para saber onde estão na matriz de incidência.
    [inc, loc] = members(termos_pesquisados, termos);
    
    bins = [];
    // Para cada termo pesquisado
    for i = 1:n_termos_pesquisados
        linha = loc(i);
        bin_i = 0;
        for j = 1:n_textos
            // O termo i aparece no texto j
            if(incidencias(linha, j) > 0)
                bin_i = bin_i + 2^(j-1);
            end
        end
        bins = [bins, bin_i];
    end    
endfunction

// Retorna um vetor com os índices dos textos recuperados,
// tendo como entrada um valor binário tal que se o i-ésimo
// bit for 1, então i estará no vetor.
function [recuperados]=bin_para_textos(valor_bin, n_textos)
    recuperados = [];
    
    for i = 1:n_textos
        bin_i = 2^(i-1);
        // Se o i-ésimo bit for 1, o resultado será 1.
        resultado = bitand(bin_i, valor_bin);
        if resultado > 0
            recuperados = [recuperados, i];
        end
    end
endfunction

// Consulta na qual são recuperados apenas textos que possuem
// TODOS os termos pesquisados.
function [recuperados]=consulta_conjuntiva(termos_pesquisados, termos, inc)
    s = size(termos_pesquisados);
    n_pesquisados = s(1);
    s = size(inc);
    n_textos = s(2);
    
    // Valores binários que mostram em quais textos cada termo pesquisado está.
    bin_pesquisados = bins_correspondentes(termos_pesquisados, termos, inc);

    // Consulta conjuntiva
    // Elemento neutro do AND: 1
    bin_recuperados = 1;

    // Grande AND entre todos os bins pesquisados.
    // Só ficarão de pé textos que possuem TODOS os termos pesquisados.
    for i = 1:n_pesquisados
        bin_recuperados = bitand(bin_recuperados, bin_pesquisados(i));
    end
    
    recuperados = bin_para_textos(bin_recuperados, n_textos);    
endfunction

// Consulta na qual são recuperados todos os textos que possuem
// QUALQUER UM dos termos pesquisados.
function [recuperados]=consulta_disjuntiva(termos_pesquisados, termos, inc)
    s = size(termos_pesquisados);
    n_pesquisados = s(1);
    s = size(inc);
    n_textos = s(2);
    
    // Valores binários que mostram em quais textos cada termo pesquisado está.
    bin_pesquisados = bins_correspondentes(termos_pesquisados, termos, inc);

    // Consulta disjuntiva
    // Elemento neutro do OR: 0
    bin_recuperados = 0;

    // Grande OR entre todos os bins pesquisados.
    // Ficarão de pé textos que possuem PELO MENOS UM dos termos pesquisados.
    for i = 1:n_pesquisados
        bin_recuperados = bitor(bin_recuperados, bin_pesquisados(i));
    end
    
    recuperados = bin_para_textos(bin_recuperados, n_textos);    
endfunction
