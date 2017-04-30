#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import json
import sys
import xapian

class stopper_pt(xapian.Stopper):
  stop_words = set()

  def __init__(self):
    with open("lista_stopwords.txt", mode='r') as file:
      for line in file:
        stop_words.add(line.strip())

  def __call__(self, termo):
    # Deve retornar true caso 'termo' seja uma stopword
    return termo in stopwords

  def get_description(self):
    return "Stopper customizado em Português"