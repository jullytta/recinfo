#!/usr/bin/env python
# -*- coding: utf-8 -*-

import json
import logging
import sys
import xapian
from globais import dir_banco, nomes_alunos
# TODO(jullytta): substituir pela função real uma vez que
# a mesma esteja pronta.
from stubs import recupera_consultas_stub as recupera_consultas

def busca(consulta_num, consulta_string, offset=0, n_recuperados=100):
  # offset - ponto onde o conjunto resultado se inicia
  # n_recuperados - quantos documentos serão recuperados
  # (nos limitamos a 100 documentos por default devido a
  # especificação do trabalho)

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
  consulta = qp.parse_query(consulta_string)

  # O objeto Enquire vai nos auxiliar a executar a consulta
  pergunta = xapian.Enquire(db)
  pergunta.set_query(consulta)

  # Imprimimos os resultados de cada consulta no formato
  # especificado pelo trabalho
  resultados = []
  for resultado in pergunta.get_mset(offset, n_recuperados):
    campos = json.loads(resultado.document.get_data())
    print(u"{n_consulta} Q0 {doc_id} {rank} {peso:.6f} {nomes}".format(
      n_consulta = consulta_num,
      doc_id = campos.get('id'),
      rank = resultado.rank,
      peso = resultado.weight,
      nomes = nomes_alunos
      ))

# Logs sobre as consultas realizadas
logging.basicConfig(level=logging.INFO)

# Busca sobre todas as consultas
# TODO(jullytta): substituir pelo número real da consulta
contador = 1
for consulta in recupera_consultas():
  busca(contador, consulta)
  contador += 1