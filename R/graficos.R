source("preparacaoDados.R")
library(ggplot2)
library(dplyr)

dados <- prepararDados()

dados_grafico <- dados %>%
  count(subversao, resultado) %>%
  group_by(subversao) %>%
  mutate(
    porcentagem = n / sum(n)
  )


#SUBVERSAO DAS EXPECTATIVAS DO MERCADO
grafico1 <- ggplot(dados, aes(x = subversao, fill = subversao)) +
  
  #tamanho das barras
  geom_bar(width = 0.3) +
  
  #legenda de cima das barras
  geom_text(
    stat = "count",
    aes(
      label = paste0(
        after_stat(count),
        " (",
        round(after_stat(prop) * 100, 1),
        "%)"
      ),
      group = 1,
      fill = NULL
    ),
    vjust = -0.5
  ) +
  
  #cor das barras
  scale_fill_manual(
    values = c("FALSE" = "#D9534F", "TRUE" = "#00A249")
  ) +
  
  #alterando true e false
  scale_x_discrete(
    labels = c(
      "FALSE" = "Nao subverteu",
      "TRUE" = "Subverteu"
    )
  )+

  #legenda do grafico e dos eixos
  labs(
    title = "Subversão das Expectativas do Mercado",
    x = "Ocorrencia de subversao",
    y = "Quantidade de jogos"
  ) +

  theme_minimal(base_size = 14)+
  theme(
    #remocao da legenda redundante
    legend.position = "none",
    
    #cor de fundo
    plot.background = element_rect(fill = "#FFF8E7", color = NA),
    panel.background = element_rect(fill = "#FFF8E7", color = NA),
    
    #negrito na legenda
    axis.text.x = element_text(face = "bold"),
    
    #remocao das linhas de fundo
    panel.grid.minor = element_blank(),
    panel.grid.major.x = element_blank(),
    
    #centralizacao do titulo e negrito
    plot.title = element_text(
      face = "bold",
      hjust = 0.5
    )
  )

#DISTRIBUICAO DE SUBVERSOES

grafico2 <- ggplot(dados_grafico, aes(x = resultado, y = n, fill = subversao)) +
  
  # Barras lado a lado
  geom_col(position = "dodge", width = 0.6) +
  
  # Valores em cima das barras
  geom_text(
    aes(
      label = paste0(
        n,
        " (",
        round(porcentagem * 100, 1),
        "%)"
      ),
      hjust = ifelse(subversao, 0.2, 0.8)
    ),
    position = position_dodge(width = 0.6),
    vjust = -0.5
  ) +
  
  # Cores
  scale_fill_manual(
    values = c("FALSE" = "#D9534F", "TRUE" = "#00A249"),
    labels = c("Não subverteu", "Subverteu")
  ) +
  
  # Renomeando os resultados
  scale_x_discrete(
    labels = c(
      "V" = "Vitória",
      "E" = "Empate",
      "D" = "Derrota"
    )
  ) +
  
  labs(
    title = "Resultados por Ocorrência de Subversão",
    x = "Resultado",
    y = "Quantidade de jogos",
    fill = "Subversão"
  ) +
  
  coord_cartesian(clip = "off") +
  
  theme_minimal(base_size = 14) +
  theme(
    plot.background = element_rect(fill = "#FFF8E7", color = NA),
    panel.background = element_rect(fill = "#FFF8E7", color = NA),
    
    panel.grid.minor = element_blank(),
    panel.grid.major.x = element_blank(),
    
    plot.title = element_text(
      face = "bold",
      hjust = 0.5
    )
  )


#IMPLICANCIA
grafico3 <- ggplot(dados, aes(x = rodada, y = razao, color = subversao)) +
  
  #Pontos no grafico
  geom_point(
    size = 3.5,
    alpha = 0.85
  ) +
  
  #Linha da razão
  geom_hline(
    yintercept = 1,
    linetype = "dashed",
    color = "gray40"
  ) +
  
  #Cores dos pontos
  scale_color_manual(
    values = c(
      "FALSE" = "#D9534F",
      "TRUE" = "#00A249"
    ),
    labels = c(
      "Não subverteu",
      "Subverteu"
    )
  ) +
  
  #Eixo X
  scale_x_continuous(
    breaks = seq(1, 38, by = 5),
    limits = c(1, 38)
  ) +
  
  #Eixo Y
  scale_y_continuous(
    breaks = c(0, 0.5, 1, 1.5, 2, 3, 4, 5),
    expand = expansion(mult = c(0.03, 0.08))
  ) +
  
  #Titulos e legendas
  labs(
    title = "Vasco é implicante?",
    subtitle = "As subversões aparecem tanto quando o Vasco é favorito quanto quando é azarão!",
    x = "Rodada",
    y = "Razão das odds",
    color = "Comportamento"
  ) +
  theme_minimal(base_size = 14) +
  
  #Fundo, remoção das linhas de fundo, configurações do negrito no eixo x, titulo e subtitulo
  theme(
    plot.background = element_rect(
      fill = "#FFF8E7",
      color = NA
    ),
    
    panel.background = element_rect(
      fill = "#FFF8E7",
      color = NA
    ),
    
    panel.grid.minor = element_blank(),
    panel.grid.major.x = element_blank(),
    
    axis.text.x = element_text(
      face = "bold"
    ),
    
    plot.title = element_text(
      face = "bold",
      hjust = 0.5,
      size = 18
    ),
    
    plot.subtitle = element_text(
      hjust = 0.5,
      size = 12
    ),
    
    legend.position = "top"
  )

#criacao dos graficos em png
ggsave(
  "../plots/grafico1.png",
  plot = grafico1,
  width = 8,
  height = 6,
  dpi = 300
)
ggsave(
  "../plots/grafico2.png",
  plot = grafico2,
  width = 8,
  height = 6,
  dpi = 300
)
ggsave(
  "../plots/grafico3.png",
  plot = grafico3,
  width = 8,
  height = 6,
  dpi = 300
)

