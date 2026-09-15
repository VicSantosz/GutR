# ============================================================
# GutR
# Exportação dos resultados
# ============================================================

exportar_resultados <- function(
    dados,
    resultado_IRI,
    levins,
    pianka,
    arquivo_origem = NULL,
    caminho = "resultados"
) {
  
  # ----------------------------------------------------------
  # Criar pasta de resultados
  # ----------------------------------------------------------
  
  if (!dir.exists(caminho)) {
    dir.create(caminho, recursive = TRUE)
  }
  
  
  # ----------------------------------------------------------
  # Definir nome do arquivo de saída
  # ----------------------------------------------------------
  
  if (!is.null(arquivo_origem)) {
    
    nome_base <- tools::file_path_sans_ext(
      basename(arquivo_origem)
    )
    
    nome_arquivo <- paste0(
      nome_base,
      "_GutR.xlsx"
    )
    
  } else {
    
    nome_arquivo <- "resultado.xlsx"
  }
  
  
  arquivo <- file.path(
    caminho,
    nome_arquivo
  )
  
  
  # ----------------------------------------------------------
  # Criar arquivo Excel
  # ----------------------------------------------------------
  
  wb <- openxlsx::createWorkbook()
  
  
  # ----------------------------------------------------------
  # Aba: Dados processados
  # ----------------------------------------------------------
  
  openxlsx::addWorksheet(
    wb,
    "Dados_processados"
  )
  
  openxlsx::writeData(
    wb,
    "Dados_processados",
    dados
  )
  
  
  # ----------------------------------------------------------
  # Aba: IRI
  # ----------------------------------------------------------
  
  openxlsx::addWorksheet(
    wb,
    "IRI"
  )
  
  openxlsx::writeData(
    wb,
    "IRI",
    resultado_IRI
  )
  
  
  # ----------------------------------------------------------
  # Aba: Levins
  # ----------------------------------------------------------
  
  openxlsx::addWorksheet(
    wb,
    "Levins"
  )
  
  openxlsx::writeData(
    wb,
    "Levins",
    levins
  )
  
  
  # ----------------------------------------------------------
  # Aba: Pianka
  # ----------------------------------------------------------
  
  openxlsx::addWorksheet(
    wb,
    "Pianka"
  )
  
  pianka_df <- as.data.frame(pianka)
  
  pianka_df <- cbind(
    grupo = rownames(pianka_df),
    pianka_df
  )
  
  openxlsx::writeData(
    wb,
    "Pianka",
    pianka_df
  )
  
  
  # ----------------------------------------------------------
  # Ajustar largura das colunas
  # ----------------------------------------------------------
  
  for (aba in names(wb)) {
    
    openxlsx::setColWidths(
      wb,
      aba,
      cols = 1:100,
      widths = "auto"
    )
  }
  
  
  # ----------------------------------------------------------
  # Salvar arquivo
  # ----------------------------------------------------------
  
  openxlsx::saveWorkbook(
    wb,
    arquivo,
    overwrite = TRUE
  )
  
  
  # ----------------------------------------------------------
  # Mensagem de confirmação
  # ----------------------------------------------------------
  
  message(
    "Resultados exportados para: ",
    arquivo
  )
  
  
  return(arquivo)
}