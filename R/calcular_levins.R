# ============================================================
# GutR
# Índice de amplitude de nicho de Levins
# ============================================================

calcular_levins <- function(resultado, proporcao = "Vp") {
  
  # ----------------------------------------------------------
  # Verificar se a proporção escolhida é válida
  # ----------------------------------------------------------
  
  if (!proporcao %in% c("Np", "Vp")) {
    
    stop(
      "Erro: a proporção deve ser 'Np' ou 'Vp'."
    )
  }
  
  
  # ----------------------------------------------------------
  # Verificar se a coluna existe
  # ----------------------------------------------------------
  
  if (!proporcao %in% names(resultado)) {
    
    stop(
      paste(
        "Erro: a coluna",
        proporcao,
        "não foi encontrada no resultado."
      )
    )
  }
  
  
  # ----------------------------------------------------------
  # Agrupar por grupo
  # ----------------------------------------------------------
  
  levins <- dplyr::group_by(
    resultado,
    grupo
  )
  
  
  # ----------------------------------------------------------
  # Calcular proporções e número de categorias
  # ----------------------------------------------------------
  
  levins <- dplyr::summarise(
    levins,
    
    p = list(
      .data[[proporcao]] / 100
    ),
    
    n = dplyr::n(),
    
    .groups = "drop"
  )
  
  
  # ----------------------------------------------------------
  # Calcular B e Ba
  # ----------------------------------------------------------
  
  levins <- dplyr::rowwise(
    levins
  )
  
  levins <- dplyr::mutate(
    levins,
    
    # Índice original de Levins
    B = 1 / sum(p^2),
    
    # Índice padronizado de Levins
    Ba = ifelse(
      n > 1,
      (B - 1) / (n - 1),
      NA_real_
    )
  )
  
  
  # ----------------------------------------------------------
  # Remover agrupamento
  # ----------------------------------------------------------
  
  levins <- dplyr::ungroup(
    levins
  )
  
  
  # ----------------------------------------------------------
  # Selecionar resultados finais
  # ----------------------------------------------------------
  
  levins <- dplyr::select(
    levins,
    grupo,
    B,
    Ba
  )
  
  
  # ----------------------------------------------------------
  # Arredondar resultados
  # ----------------------------------------------------------
  
  levins <- dplyr::mutate(
    levins,
    B = round(B, 4),
    Ba = round(Ba, 4)
  )
  
  
  # ----------------------------------------------------------
  # Retornar resultados
  # ----------------------------------------------------------
  
  return(levins)
}
