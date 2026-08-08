source("preparacaoDados.R")

dados <- prepararDados()

#de onde vem as subversoes
table(dados$resultado, dados$subversao)

#influencia do mandante
table(dados$mandante, dados$subversao)

#influencia de expulsoes
table(dados$vermelho, dados$subversao)

#concentracao de subversoes no campeonato
dados[, c("rodada","subversao")]

#maiores razoes
head(dados[order(-dados$razao), ],5)

#menores razoes
head(dados[order(dados$razao), ],5)

#porcentagem de subversao
prop.table(table(dados$resultado, dados$subversao), 1)
