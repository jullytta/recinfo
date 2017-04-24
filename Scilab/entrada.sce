// Diretorio padrao onde todos os arquivos costumam estar
// diretorio = 'C:\Users\Convidado\Downloads\'
diretorio = '~/recinfo/Scilab' // --gab

// Vetor coluna onde cada linha representa o texto de um documento.
textos = ['O peã e o caval são pec de xadrez. O caval é o melhor do jog.';
          'A jog envolv a torr, o peã e o rei.';
          'O peã lac o boi';
          'Caval de rodei!';
          'Polic o jog no xadrez.'];

// Vetor linha onde o elemento em cada coluna armazena uma stopword.
stopwords = ['a', 'o', 'e', 'é', 'de', 'do', 'no', 'são'];

// String contendo os termos da consulta.
consulta = 'xadrez peã caval torr';

// Vetor linha onde o elemento em cada coluna representa um separador
// a ser utilizado na tokenização dos documentos.
separadores = [' ', ',', '.', '!', '?', ';'];

// Identificador dos documentos relevantes para a consulta.
R = [1; 2];
