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
    yield { 
            "n_consulta" : top.find("num").text.strip(), 
            "string_consulta" : top.find("PT-title").text.strip() 
          }

if __name__ == '__main__':
  for consulta in recupera_consultas():
    print(consulta)