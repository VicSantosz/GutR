# ============================================================
# GutR
# Índice de Importância Relativa (IRI)
# ============================================================

calcular_IRI <- function(resultado) {
  
  resultado <- dplyr::mutate(
    resultado,
    IRI = (Np + Vp) * Fp
  )
  
  
  # ----------------------------------------------------------
  # IRI percentual dentro de cada grupo
  # ----------------------------------------------------------
  
  resultado <- dplyr::group_by(
    resultado,
    grupo
  )
  
  resultado <- dplyr::mutate(
    resultado,
    IRI_perc = (IRI / sum(IRI)) * 100
  )
  
  resultado <- dplyr::ungroup(
    resultado
  )
  
  
  # ----------------------------------------------------------
  # Arredondar
  # ----------------------------------------------------------
  
  resultado <- dplyr::mutate(
    resultado,
    dplyr::across(
      where(is.numeric),
      ~ round(.x, 2)
    )
  )
  
  
  return(resultado)
}

