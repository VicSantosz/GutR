# ============================================================
# GutR
# Cálculo das métricas da dieta
# ============================================================

calcular_metricas <- function(dados, resumo) {
  
  # ----------------------------------------------------------
  # Número total de indivíduos por grupo
  # ----------------------------------------------------------
  
  total_individuos <- dplyr::group_by(
    dados,
    grupo
  )
  
  total_individuos <- dplyr::summarise(
    total_individuos,
    total_ind = dplyr::n_distinct(individuo),
    .groups = "drop"
  )
  
  
  # ----------------------------------------------------------
  # Calcular métricas por grupo e presa
  # ----------------------------------------------------------
  
  resultado <- dplyr::group_by(
    resumo,
    grupo
  )
  
  resultado <- dplyr::mutate(
    resultado,
    Np = (N / sum(N)) * 100,
    Vp = (V / sum(V)) * 100
  )
  
  resultado <- dplyr::ungroup(
    resultado
  )
  
  
  # ----------------------------------------------------------
  # Adicionar número total de indivíduos
  # ----------------------------------------------------------
  
  resultado <- dplyr::left_join(
    resultado,
    total_individuos,
    by = "grupo"
  )
  
  
  # ----------------------------------------------------------
  # Frequência de ocorrência percentual
  # ----------------------------------------------------------
  
  resultado <- dplyr::mutate(
    resultado,
    Fp = (F / total_ind) * 100
  )
  
  
  # ----------------------------------------------------------
  # Remover variável auxiliar
  # ----------------------------------------------------------
  
  resultado <- dplyr::select(
    resultado,
    -total_ind
  )
  
  
  # ----------------------------------------------------------
  # Arredondar resultados
  # ----------------------------------------------------------
  
  resultado <- dplyr::mutate(
    resultado,
    dplyr::across(
      where(is.numeric),
      ~ round(.x, 2)
    )
  )
  
  
  # ----------------------------------------------------------
  # Retornar resultado
  # ----------------------------------------------------------
  
  return(resultado)
}