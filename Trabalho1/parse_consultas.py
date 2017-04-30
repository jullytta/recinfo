#!/usr/bin/env python3

import xml.etree.ElementTree as ET

# parser = ET.XMLPullParser(['start', 'end'])
parser =  ET.XMLParser(encoding="latin_1")

parser.feed("<root>")
with open("./consultas.txt", mode="r", encoding="latin_1") as f:
  parser.feed(f.read())
parser.feed("</root>")

root = parser.close()

for top in root:
  for title in i.iterfind("PT-title"):
    print(j.text)

# print(parser.root())