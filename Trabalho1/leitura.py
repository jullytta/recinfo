#!/usr/bin/env python
# -*- coding: utf-8 -*-

import json
import logging
import sys
import xapian
from globais import dir_banco, nomes_alunos
from parsers_entrada import recupera_consultas

def busca(consulta_num, string_consulta, offset=0, n_recuperados=10):
  # Abrimos o banco de dados
  db = xapian.Database(dir_banco)

  # Vamos utilizar um QueryParser para também
  # processar os termos da consulta (aplicar stemming)
  qp = xapian.QueryParser()
  # Stemming em português
  qp.set_stemmer(xapian.Stem("pt"))
  # Usaremos a mesma estratégia usada na indexação dos documentos
  qp.set_stemming_strategy(qp.STEM_ALL)

  # Transformamos a string em consulta
  consulta = qp.parse_query(string_consulta)

  # O objeto Enquire vai nos auxiliar a executar a consulta
  pergunta = xapian.Enquire(db)
  pergunta.set_query(consulta)

  # Imprimimos os resultados de cada consulta no formato
  # especificado pelo trabalho
  resultados = []
  for resultado in pergunta.get_mset(offset, n_recuperados):
    campos = json.loads(resultado.document.get_data().decode("latin_1"))
    print(u"{n_consulta} Q0 {doc_id}\n{texto}".format(
      n_consulta = consulta_num,
      doc_id = campos.get('id'),
      texto = campos.get('text')
      ))

if __name__ == '__main__':
  # Busca sobre todas as consultas
  for consulta in recupera_consultas():
    busca(consulta["n_consulta"], consulta["string_consulta"])
