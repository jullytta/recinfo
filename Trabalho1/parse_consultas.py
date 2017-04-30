#!/usr/bin/env python3

import xml.etree.ElementTree as ET

def recupera_consultas(fname="./consultas.txt"):
  parser =  ET.XMLParser(encoding="latin_1")

  parser.feed("<root>")
  with open(fname, mode="r", encoding="latin_1") as f:
    parser.feed(f.read())
  parser.feed("</root>")

  root = parser.close()

  for top in root:
    for title in top.iterfind("PT-title"):
      yield title.text

if __name__ == '__main__':
  for consulta in recupera_consultas():
    print(consulta)