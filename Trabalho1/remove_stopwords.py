#!/usr/bin/env python3
# -*- coding: utf-8 -*-

import json
import sys
import xapian

stop_words_pt = set()

def init_stopwords():
  global stop_words_pt
  with open("lista_stopwords.txt", mode='r') as file:
    for line in file:
      stop_words_pt.add(line.strip())

class stopper_pt(xapian.Stopper):  
  def __call__(self, termo):
    global stop_words_pt
    # Deve retornar true caso 'termo' seja uma stopword
    return termo in stop_words_pt

  def get_description(self):
    return "Stopper customizado em Português"

if __name__ == '__main__':
  init_stopwords()