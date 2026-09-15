# ============================================================
# GutR
# Resumo da dieta
# ============================================================

resumir_dieta <- function(dados, por_grupo = TRUE) {
  
  # ----------------------------------------------------------
  # Resumo por grupo e categoria de presa
  # ----------------------------------------------------------
  
  if (por_grupo) {
    
    resumo <- dplyr::group_by(
      dados,
      grupo,
      presa
    )
    
    resumo <- dplyr::summarise(
      resumo,
      N = dplyr::n(),
      V = sum(V, na.rm = TRUE),
      F = dplyr::n_distinct(individuo),
      .groups = "drop"
    )
    
  } else {
    
    resumo <- dplyr::group_by(
      dados,
      presa
    )
    
    resumo <- dplyr::summarise(
      resumo,
      N = dplyr::n(),
      V = sum(V, na.rm = TRUE),
      F = dplyr::n_distinct(individuo),
      .groups = "drop"
    )
  }
  
  
  # ----------------------------------------------------------
  # Retornar resultado
  # ----------------------------------------------------------
  
  return(resumo)
}