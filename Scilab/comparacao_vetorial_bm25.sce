// Caminho completo para o diretorio no qual se encontram os
// scripts do scilab
diretorio = 'C:\Users\Convidado\Downloads\'

// Funções para avaliação da recuperação.
exec(diretorio+'avaliacao_da_recuperacao.sce', -1);

// Funções utilitárias.
exec(diretorio+'util.sce', -1);

// TODO: idealmente os dois execs a seguir seriam chamadas de função
// que retornam os ranks.

// Importamos o rank da ponderação de termos = ranks_vetorial.
exec(diretorio+'ponderacao_de_termos.sce', -1);

// Importamos o rank do modelo probabilístico = simBM25.
exec(diretorio+'modelo_probabilistico.sce', -1);

// Geramos os rankings a partir dos ranks calculados.
ranking_vet = gera_ranking(ranks_vetorial)';
ranking_BM25 = gera_ranking(simBM25)';

disp("Ranking vetorial:");
disp(ranking_vet');
disp("Ranking BM25:");
disp(ranking_BM25');

// Valores de revocação
rev_vet = revocacao(R, ranking_vet);
rev_BM25 = revocacao(R, ranking_BM25);

disp("Revocação vetorial:");
disp(rev_vet);
disp("Revocação BM25:");
disp(rev_BM25);

// Valores de precisão
precisao_vet = precisao(R, ranking_vet);
precisao_BM25 = precisao(R, ranking_BM25);

disp("Precisão vetorial:");
disp(precisao_vet);
disp("Precisão BM25:");
disp(precisao_BM25);

// Medida f1
f1_vet = medida_f1(rev_vet, precisao_vet);
f1_BM25 = medida_f1(rev_BM25, precisao_BM25);

disp("F1 vetorial:");
disp(f1_vet);
disp("F1 BM25:");
disp(f1_BM25);
