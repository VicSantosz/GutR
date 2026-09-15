grafico_composicao <- function(resultado, salvar = TRUE,
                               caminho = "graficos") {
  
  grafico <- ggplot2::ggplot(
    resultado,
    ggplot2::aes(
      x = presa,
      y = Vp,
      fill = grupo
    )
  ) +
    ggplot2::geom_col(
      position = "dodge"
    ) +
    ggplot2::labs(
      title = "Composição da dieta por volume",
      x = "Categoria de presa",
      y = "Volume percentual (Vp)",
      fill = "Grupo"
    ) +
    ggplot2::theme_minimal() +
    ggplot2::theme(
      axis.text.x = ggplot2::element_text(
        angle = 45,
        hjust = 1
      )
    )
  
  # Mostrar gráfico
  print(grafico)
  
  # Salvar se solicitado
  if(salvar) {
    
    if(!dir.exists(caminho)) {
      dir.create(caminho, recursive = TRUE)
    }
    
    ggplot2::ggsave(
      filename = file.path(
        caminho,
        "composicao_dieta_Vp.png"
      ),
      plot = grafico,
      width = 10,
      height = 6,
      dpi = 300
    )
  }
  
  return(grafico)
}



grafico_composicao <- function(resultado, salvar = TRUE,
                               caminho = "graficos") {
  
  grafico <- ggplot2::ggplot(
    resultado,
    ggplot2::aes(
      x = presa,
      y = Vp,
      fill = grupo
    )
  ) +
    ggplot2::geom_col(
      position = "dodge"
    ) +
    ggplot2::labs(
      title = "Composição da dieta por volume",
      x = "Categoria de presa",
      y = "Volume percentual (Vp)",
      fill = "Grupo"
    ) +
    ggplot2::theme_minimal() +
    ggplot2::theme(
      axis.text.x = ggplot2::element_text(
        angle = 45,
        hjust = 1
      )
    )
  
  # Mostrar gráfico
  print(grafico)
  
  # Salvar se solicitado
  if(salvar) {
    
    if(!dir.exists(caminho)) {
      dir.create(caminho, recursive = TRUE)
    }
    
    ggplot2::ggsave(
      filename = file.path(
        caminho,
        "composicao_dieta_Vp.png"
      ),
      plot = grafico,
      width = 10,
      height = 6,
      dpi = 300
    )
  }
  
  return(grafico)
}


# ============================================================
# Gráfico de IRI%
# ============================================================

grafico_IRI <- function(resultado, salvar = TRUE,
                        caminho = "graficos") {
  
  grafico <- ggplot2::ggplot(
    resultado,
    ggplot2::aes(
      x = presa,
      y = IRI_perc,
      fill = grupo
    )
  ) +
    ggplot2::geom_col(
      position = "dodge"
    ) +
    ggplot2::labs(
      title = "Importância relativa das categorias de presa",
      x = "Categoria de presa",
      y = "IRI (%)",
      fill = "Grupo"
    ) +
    ggplot2::theme_minimal() +
    ggplot2::theme(
      axis.text.x = ggplot2::element_text(
        angle = 45,
        hjust = 1
      )
    )
  
  # Mostrar gráfico
  print(grafico)
  
  # Salvar
  if(salvar) {
    
    if(!dir.exists(caminho)) {
      dir.create(caminho, recursive = TRUE)
    }
    
    ggplot2::ggsave(
      filename = file.path(
        caminho,
        "IRI_percentual.png"
      ),
      plot = grafico,
      width = 10,
      height = 6,
      dpi = 300
    )
  }
  
  return(grafico)
}



# ============================================================
# Heatmap do índice de Pianka
# ============================================================

grafico_pianka <- function(pianka, salvar = TRUE,
                           caminho = "graficos") {
  
  # ----------------------------------------------------------
  # Transformar matriz em formato para ggplot
  # ----------------------------------------------------------
  
  dados_pianka <- as.data.frame(as.table(pianka))
  
  names(dados_pianka) <- c(
    "grupo_1",
    "grupo_2",
    "Pianka"
  )
  
  
  # ----------------------------------------------------------
  # Criar gráfico
  # ----------------------------------------------------------
  
  grafico <- ggplot2::ggplot(
    dados_pianka,
    ggplot2::aes(
      x = grupo_1,
      y = grupo_2,
      fill = Pianka
    )
  ) +
    ggplot2::geom_tile(
      color = "white"
    ) +
    ggplot2::geom_text(
      ggplot2::aes(
        label = round(Pianka, 2)
      ),
      size = 5
    ) +
    ggplot2::scale_fill_gradient(
      limits = c(0, 1)
    ) +
    ggplot2::labs(
      title = "Sobreposição de nicho alimentar — Índice de Pianka",
      x = "Grupo",
      y = "Grupo",
      fill = "Pianka"
    ) +
    ggplot2::theme_minimal()
  
  
  # ----------------------------------------------------------
  # Mostrar gráfico
  # ----------------------------------------------------------
  
  print(grafico)
  
  
  # ----------------------------------------------------------
  # Salvar gráfico
  # ----------------------------------------------------------
  
  if(salvar) {
    
    if(!dir.exists(caminho)) {
      dir.create(caminho, recursive = TRUE)
    }
    
    ggplot2::ggsave(
      filename = file.path(
        caminho,
        "pianka_heatmap.png"
      ),
      plot = grafico,
      width = 7,
      height = 6,
      dpi = 300
    )
  }
  
  
  return(grafico)
}