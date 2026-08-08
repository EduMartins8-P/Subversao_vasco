prepararDados <- function(){

  dados <- read.csv("../data/oddVasco.csv", header = TRUE)
  
  dados$razao <- round(dados$oddVitoria / dados$oddDerrota, 2)
  
  dados$subversao <- FALSE
  
  #vitoria quando era azarao
  dados$subversao[dados$resultado == 'V' & dados$razao > 1] <- TRUE
  #derrota quando era favorito
  dados$subversao[dados$resultado == 'D' & dados$razao < 1] <- TRUE
  #empate quando era claro favoritismo
  dados$subversao[dados$resultado == "E" & (dados$razao > 2 | dados$razao < 0.5)] <- TRUE
  
  return(dados)
}
