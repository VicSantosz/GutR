# ============================================================
# GutR
# Importação dos dados
# ============================================================

importar_dados <- function(arquivo) {
  
  # ----------------------------------------------------------
  # Importar planilha
  # ----------------------------------------------------------
  
  dados <- readxl::read_excel(arquivo)
  
  
  # ----------------------------------------------------------
  # Colunas obrigatórias
  # ----------------------------------------------------------
  
  colunas_obrigatorias <- c(
    "grupo",
    "individuo",
    "presa",
    "comprimento",
    "largura"
  )
  
  
  # ----------------------------------------------------------
  # Verificar colunas ausentes
  # ----------------------------------------------------------
  
  colunas_faltantes <- setdiff(
    colunas_obrigatorias,
    names(dados)
  )
  
  if (length(colunas_faltantes) > 0) {
    
    stop(
      paste0(
        "Erro: as seguintes colunas estão ausentes: ",
        paste(
          colunas_faltantes,
          collapse = ", "
        )
      )
    )
  }
  
  
  # ----------------------------------------------------------
  # Selecionar colunas obrigatórias
  # ----------------------------------------------------------
  
  dados <- dados[
    ,
    colunas_obrigatorias,
    drop = FALSE
  ]
  
  
  # ----------------------------------------------------------
  # Padronizar tipos
  # ----------------------------------------------------------
  
  dados$grupo <- as.character(dados$grupo)
  dados$individuo <- as.character(dados$individuo)
  dados$presa <- as.character(dados$presa)
  dados$comprimento <- as.numeric(dados$comprimento)
  dados$largura <- as.numeric(dados$largura)
  
  
  # ----------------------------------------------------------
  # Retornar dados
  # ----------------------------------------------------------
  
  return(dados)
}
