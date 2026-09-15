# ============================================================
# GutR
# Índice de sobreposição de nicho de Pianka
# ============================================================

calcular_pianka <- function(resultado, proporcao = "Vp") {
  
  # Verificar proporção
  if (!proporcao %in% c("Np", "Vp")) {
    stop("Erro: a proporção deve ser 'Np' ou 'Vp'.")
  }
  
  # Verificar coluna
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
  # Criar tabela grupo x presa
  # ----------------------------------------------------------
  
  matriz <- dplyr::select(
    resultado,
    grupo,
    presa,
    dplyr::all_of(proporcao)
  )
  
  matriz <- tidyr::pivot_wider(
    matriz,
    names_from = presa,
    values_from = dplyr::all_of(proporcao),
    values_fill = 0
  )
  
  # ----------------------------------------------------------
  # Transformar em matriz numérica
  # ----------------------------------------------------------
  
  grupos <- matriz$grupo
  
  matriz_p <- dplyr::select(
    matriz,
    -grupo
  )
  
  matriz_p <- as.matrix(matriz_p)
  
  rownames(matriz_p) <- grupos
  
  # Converter porcentagem para proporção
  matriz_p <- matriz_p / 100
  
  # ----------------------------------------------------------
  # Matriz de Pianka
  # ----------------------------------------------------------
  
  resultado_pianka <- matrix(
    NA_real_,
    nrow = length(grupos),
    ncol = length(grupos),
    dimnames = list(grupos, grupos)
  )
  
  # ----------------------------------------------------------
  # Cálculo de Pianka
  # ----------------------------------------------------------
  
  for (i in seq_along(grupos)) {
    
    for (j in seq_along(grupos)) {
      
      numerador <- sum(
        matriz_p[i, ] * matriz_p[j, ]
      )
      
      denominador <- sqrt(
        sum(matriz_p[i, ]^2) *
          sum(matriz_p[j, ]^2)
      )
      
      if (denominador == 0) {
        
        resultado_pianka[i, j] <- NA_real_
        
      } else {
        
        resultado_pianka[i, j] <-
          numerador / denominador
      }
    }
  }
  
  # ----------------------------------------------------------
  # Retornar resultado
  # ----------------------------------------------------------
  
  return(
    round(
      resultado_pianka,
      4
    )
  )
}