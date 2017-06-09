// A variavel diretorio esta instanciada em entrada.sce
// Opcionalmente, pode ser instanciada manualmente antes de executar
// este programa 

// Inicializa matriz 'incidencias'
exec(diretorio+'inicializa_matriz_incidencias.sce', -1);

// Funções de consulta no modo booleano
exec(diretorio+'consultas_booleanas.sce', -1);

///////////////// Consultas /////////////////
termos_pesquisados = tokeniza(consulta, separadores);

// Consultas conjuntiva e disjuntiva
recuperados_conjuntiva = consulta_conjuntiva(termos_pesquisados, termos, incidencias);
recuperados_disjuntiva = consulta_disjuntiva(termos_pesquisados, termos, incidencias);
