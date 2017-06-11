// Dataset exemplo para buscas personalizadas, cujo escopo é a pasta de e-mails
// pessoal de Jane Doe.
// Cada linha representa um e-mail recebido/enviado.
// Padrão: 'De: @exemplo.com Para: @exemplo.com Título: Mensagem: Anexo: '
textos = ['De: banco@exemplo.com Para: jane.doe@exemplo.com Título: A fatura do seu cartão está fechada Mensagem: Olá, Jane! Informamos que sua fatura com vencimento em 20 de abril está fechada. Anexamos um boleto com o valor total da fatura para pagamento. Você pode pagar o boleto no seu internet banking, em lotéricas ou qualquer agência bancária ou em caixa eletrônicos. Abraços, Seu Banco Anexo: boleto_abril.pdf';
'De: chefe@exemplo.com Para: jane.doe@exemplo.com Título: URGENTE! Erro ao acessar banco de dados Mensagem: Jane, nosso cliente reportou um erro na última funcionalidade que você implementou no sistema (acesso ao banco de dados). Estou mandando em anexo a tela de erro. Por favor entre em contato o mais rápido possível para que possamos averiguar a situação. Anexo: erro_banco.jpg';
'De: mãe@exemplo.com Para: jane.doe@exemplo.com Título: [Sem título] Mensagem: JANE QUERIDA VEJA ESSES LINDOS GIFS DE FILHOTES PARA ANIMAR SEU DIA BEIJOS MAMÃE Anexo: pugs.gif fofura.gif gatinhos.gif';
'De: empresa@exemplo.com Para: jane.doe@exemplo.com Título: Pagamento Referente ao Mês de Abril Mensagem: Cara Jane, Informamos que seu pagamento para o mês de abril já foi depositado na sua conta bancária. Caso não receba o pagamento dentro de 3-5 dias úteis, favor entrar em contato. Anexo: '];


// Lista de Stopwords
// Retirada de: https://gist.github.com/alopes/5358189
stopwords = ['de', 'a', 'o', 'que', 'e', 'do', 'da', 'em', 'um', 'para', 'é', 'com', 'não', 'uma', 'os', 'no', 'se', 'na', 'por', 'mais', 'as', 'dos', 'como', 'mas', 'foi', 'ao', 'ele', 'das', 'tem', 'à', 'seu', 'sua', 'ou', 'ser', 'quando', 'muito', 'há', 'nos', 'já', 'está', 'eu', 'também', 'só', 'pelo', 'pela', 'até', 'isso', 'ela', 'entre', 'era', 'depois', 'sem', 'mesmo', 'aos', 'ter', 'seus', 'quem', 'nas', 'me', 'esse', 'eles', 'estão', 'você', 'tinha', 'foram', 'essa', 'num', 'nem', 'suas', 'meu', 'às', 'minha', 'têm', 'numa', 'pelos', 'elas', 'havia', 'seja', 'qual', 'será', 'nós', 'tenho', 'lhe', 'deles', 'essas', 'esses', 'pelas', 'este', 'fosse', 'dele', 'tu', 'te', 'vocês', 'vos', 'lhes', 'meus', 'minhas', 'teu', 'tua', 'teus', 'tuas', 'nosso', 'nossa', 'nossos', 'nossas', 'dela', 'delas', 'esta', 'estes', 'estas', 'aquele', 'aquela', 'aqueles', 'aquelas', 'isto', 'aquilo', 'estou', 'está', 'estamos', 'estão', 'estive', 'esteve', 'estivemos', 'estiveram', 'estava', 'estávamos', 'estavam', 'estivera', 'estivéramos', 'esteja', 'estejamos', 'estejam', 'estivesse', 'estivéssemos', 'estivessem', 'estiver', 'estivermos', 'estiverem', 'hei', 'há', 'havemos', 'hão', 'houve', 'houvemos', 'houveram', 'houvera', 'houvéramos', 'haja', 'hajamos', 'hajam', 'houvesse', 'houvéssemos', 'houvessem', 'houver', 'houvermos', 'houverem', 'houverei', 'houverá', 'houveremos', 'houverão', 'houveria', 'houveríamos', 'houveriam', 'sou', 'somos', 'são', 'era', 'éramos', 'eram', 'fui', 'foi', 'fomos', 'foram', 'fora', 'fôramos', 'seja', 'sejamos', 'sejam', 'fosse', 'fôssemos', 'fossem', 'for', 'formos', 'forem', 'serei', 'será', 'seremos', 'serão', 'seria', 'seríamos', 'seriam', 'tenho', 'tem', 'temos', 'tém', 'tinha', 'tínhamos', 'tinham', 'tive', 'teve', 'tivemos', 'tiveram', 'tivera', 'tivéramos', 'tenha', 'tenhamos', 'tenham', 'tivesse', 'tivéssemos', 'tivessem', 'tiver', 'tivermos', 'tiverem', 'terei', 'terá', 'teremos', 'terão', 'teria', 'teríamos', 'teriam'];

// Separadores utilizados na tokenização
separadores = [' ', ',', '.', ';', ':', '!', '?', '(', ')', '[', ']', '{', '}', '@', '_', '-', '0', '1', '2', '3', '4', '5', '6', '7', '8', '9'];

