#!/usr/bin/env python
# -*- coding: utf-8 -*-

import json
import sys
import xapian
from globais import dirBanco, dirDados
# TODO(jullytta): substituir pela função real uma vez que
# a mesma esteja pronta.
from stubs import parse_sgml_stub as parse_sgml

def index():
  # Cria (ou abre, se já criado) o banco de dados
  db = xapian.WritableDatabase(dirBanco, xapian.DB_CREATE_OR_OPEN)

  # Configura o gerador de termos
  geradorTermos = xapian.TermGenerator()
  
  # Stemmer em português
  geradorTermos.set_stemmer(xapian.Stem("pt"))

  for campos in parse_sgml():
    # DOCID
    docID = campos["id"]
    # TEXT
    texto = campos["text"]

    # Criamos um documento
    doc = xapian.Document()
    # Passamos esse documento para o gerador de termos
    geradorTermos.set_document(doc)

    # TODO(jullytta): Possivelmente adicionar remoção de stopwords

    # Indexamos o texto (e somente o texto!)
    geradorTermos.index_text(texto)

    # Guardamos as informações do documento para recuperá-las
    # no futuro
    doc.set_data(json.dumps(campos))

    # Vamos guardar o ID no banco também, mas só para garantir
    # que não vamos adicionar esse mesmo documento de novo
    doc.add_boolean_term(docID)
    # Se for repetido, só vamos atualizar!
    db.replace_document(docID, doc)

# Executa a indexação
index()