#!/usr/bin/env python3

import xml.etree.ElementTree as ET
from pathlib import Path
import fileinput


def recupera_consultas(fname="consultas.txt"):
  parser =  ET.XMLParser(encoding="latin_1")

  parser.feed("<root>")
  with open(fname, mode="r", encoding="latin_1") as f:
    parser.feed(f.read())
  parser.feed("</root>")

  root = parser.close()

  for top in root:
    yield { 
            "n_consulta" : top.find("num").text.strip(), 
            "string_consulta" : top.find("PT-title").text.strip() 
          }


def recupera_documentos(fname):
  parser =  ET.XMLParser(encoding="latin_1")

  parser.feed("<root>")
  with open(fname, mode="r", encoding="latin_1") as f:
    # because the accursed parser is scared of &s
    for line in f: parser.feed(line.replace('&','&amp;').strip()+' ')
  parser.feed("</root>")

  root = parser.close()

  for doc in root:
    yield {
            "id" : doc.find("DOCID").text.strip(),
            "text" : doc.find("TEXT").text.strip()
          }


def parse_arquivos(dir="colecao_teste/"):
  # idealmente isto deveria estar num try-catch
  folder = Path(dir).iterdir()

  # idealmente testariamos se cada arquivo é de fato um arquivo
  for file in folder:
    for data in recupera_documentos(str(file)):
      yield data


if __name__ == '__main__':
  for consulta in recupera_consultas():
    print(consulta)

  for data in parse_arquivos():
    print(data)