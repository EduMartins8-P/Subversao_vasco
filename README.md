# Subversao_vasco
  Análise das expectativas pré-jogo e dos resultados do Vasco no Brasileirão 2025 usando R.

## Objetivo

  Neste projeto, analisei uma percepção comum entre nós torcedores do Vasco da Gama: a ideia de que o time costuma contrariar as expectativas pré-jogo, vencendo quando é considerado azarão, tropeçando quando é apontado como favorito e até mesmo empatando quando havia uma expectativa clara de vitória ou derrota.

  Para avaliar essa percepção de forma objetiva, analisei as odds pré-jogo e os resultados dos 38 jogos do Vasco no Campeonato Brasileiro de 2025.


## Dados

  As informações foram coletadas no SofaScore e incluem as odds pré-jogo para vitória, derrota e empate, além do resultado das partidas e outras informações sobre os jogos.

  O conjunto de dados está armazenado no arquivo oddVasco.csv, dentro da pasta data/.

As variáveis presentes no conjunto de dados são:

- `rodada`: rodada do Campeonato Brasileiro.
- `mandante`: indica se o Vasco foi mandante (`S`) ou visitante (`N`).
- `oddVitoria`: odd pré-jogo para vitória do Vasco.
- `oddDerrota`: odd pré-jogo para derrota do Vasco.
- `oddEmpate`: odd pré-jogo para empate.
- `vermelho`: indica a ocorrência de expulsão na partida.
- `resultado`: resultado do Vasco, sendo `V` (vitória), `E` (empate) ou `D` (derrota).

Nesta primeira análise, utilizei principalmente as odds pré-jogo e o resultado das partidas. As informações sobre mando de campo e expulsões foram mantidas no conjunto de dados para possibilitar análises futuras.

## Metodologia

Para comparar as expectativas do mercado com os resultados das partidas, criei a variável razao, calculada a partir da divisão entre a odd de vitória e a odd de derrota do Vasco:

razao = oddVitoria / oddDerrota
Os valores da razao foram arredondados para duas casas decimais.

A interpretação dessa razão é:

- `razao` < 1: o Vasco era considerado favorito, pois sua odd de vitória era menor que a odd de derrota.
- `razao` > 1: o Vasco era considerado azarão, pois sua odd de vitória era maior que a odd de derrota.
- `razao` = 1: as odds de vitória e derrota eram iguais, indicando expectativas equilibradas.

Após calcular a razao, criei a variável subversao, inicialmente definida como FALSE, e classifiquei como TRUE os resultados que contrariaram as expectativas indicadas pelas odds.

Foram consideradas subversões:

- **Vitória quando o Vasco era azarão**: `resultado = V` e `razao > 1`.
- **Derrota quando o Vasco era favorito**: `resultado = D` e `razao < 1`.
- **Empate com expectativa claramente desequilibrada**: `resultado = E` e `razao > 2` ou `razao < 0.5`.

Para os empates, utilizei um critério mais restritivo porque um empate pode ocorrer mesmo quando as expectativas de vitória e derrota são relativamente próximas. Assim, considerei subversão apenas quando uma das odds era mais que duas vezes maior que a outra.

As demais partidas foram classificadas como FALSE, indicando que o resultado não foi considerado uma subversão segundo esses critérios.

A preparação dos dados foi centralizada no arquivo preparacaoDados.R, que realiza a leitura do conjunto de dados e cria as variáveis utilizadas na análise.

Os scripts de análise e visualização utilizam essa função para obter os dados já preparados, evitando a repetição das mesmas etapas em diferentes arquivos.

As visualizações foram desenvolvidas com ggplot2, utilizando os dados preparados para representar a frequência de subversões, sua relação com os resultados das partidas e sua distribuição ao longo das 38 rodadas do campeonato.

## Resultados

## Visualizações

## Limitações

## Conclusão
