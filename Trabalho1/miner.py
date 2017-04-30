#!/usr/bin/env python3

from pathlib import Path
from re import match
from globais import dir_dados as default_dir

# Esta função foi feita com MUITA boa fé
# Os arquivos tem que estar formatados perfeitamente
def find_all(file):
  y = {}
  _text = []
  reading = False
  for line in file:
    
    if line.startswith("<DOCID>"):
      y["id"] = match("<DOCID>(?P<_ID>.*)</DOCID>",line).group('_ID')

    elif line.strip() == "<TEXT>":
      reading = True

    elif line.strip() == "</TEXT>":
      reading = False
      y["text"] = "".join(_text)    
      _text.clear()

    elif reading:
      _text.append(line)

    if "id" in y and "text":
      yield y
      y = {}


def parse_arquivos(dir=default_dir):
  # assumindo que dir seja um diretorio contendo arquivos de entrada 
  for file in Path(dir).iterdir():
    with open(str(file), mode='r', encoding="latin_1") as f:
      for doc in find_all(f):
        yield doc


if __name__ == '__main__':
  for doc in parse_arquivos():
    print(doc)