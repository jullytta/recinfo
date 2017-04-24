// A variavel diretorio esta instanciada em entrada.sce
// Opcionalmente, pode ser instanciada manualmente antes de executar este programa 

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

function [consulta_melhor]=realimentacao(pesos_consulta, pesos_docs, relevantes, Alpha=1, Beta=0.75, Gama=0.15)

endfunction
