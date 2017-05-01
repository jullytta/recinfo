#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import json
import sys
import xapian
from globais import dir_banco, dir_dados
from parsers_entrada import parse_arquivos as parse_sgml
from remove_stopwords import stopper_pt, init_stopwords

def index():
  # Cria (ou abre, se já criado) o banco de dados
  db = xapian.WritableDatabase(dir_banco, xapian.DB_CREATE_OR_OPEN)

  # Configura o gerador de termos
  gerador_termos = xapian.TermGenerator()
  
  # Stemmer em português
  gerador_termos.set_stemmer(xapian.Stem("pt"))
  # Escolhemos a estratégia. A API oferece quatro opções:
  # STEM_NONE: não aplicar stemming
  # STEM_SOME: palavras que começam com letra maiúscula não
  # sofrem stemming; termos que sofreram stemming são
  # indexados com o prefixo 'Z'
  # STEM_ALL: todos os termos sofrem stemming, sem prefixo
  # STEM_ALL_Z: todos os termos sofrem stemming, com o prefixo 'Z'
  gerador_termos.set_stemming_strategy(gerador_termos.STEM_ALL)

  # Inicializa stopwords
  init_stopwords()

  # Remoção de stopwords é feita por um objeto stopper
  stop = stopper_pt()
  # Temos nosso próprio stopper customizado
  gerador_termos.set_stopper(stop)
  # Todas as stopwords são removidas, com stemming ou não
  gerador_termos.set_stopper_strategy(gerador_termos.STOP_ALL)
  
  for campos in parse_sgml():
    # doc_id
    doc_id = campos["id"]
    # TEXT
    texto = campos["text"]

    # Criamos um documento
    doc = xapian.Document()
    # Passamos esse documento para o gerador de termos
    gerador_termos.set_document(doc)

    # Indexamos o texto (e somente o texto!)
    gerador_termos.index_text(texto)

    # Guardamos as informações do documento para recuperá-las
    # no futuro
    doc.set_data(json.dumps(campos))

    # Vamos guardar o ID no banco também, mas só para garantir
    # que não vamos adicionar esse mesmo documento de novo
    doc.add_boolean_term(doc_id)
    # Se for repetido, só vamos atualizar!
    db.replace_document(doc_id, doc)

# Executa a indexação
if __name__ == '__main__':
  index()
