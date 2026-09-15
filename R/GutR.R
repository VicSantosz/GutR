# ============================================================
# GutR
# Função principal
# ============================================================

GutR <- function(
    arquivo,
    proporcao_levins = "Vp",
    proporcao_pianka = "Vp",
    gerar_graficos = TRUE,
    exportar = TRUE
) {
  
  # ----------------------------------------------------------
  # 1. Carregar pacotes
  # ----------------------------------------------------------
  
  carregar_pacotes()
  
  
  # ----------------------------------------------------------
  # 2. Carregar funções do GutR
  # ----------------------------------------------------------
  
  source("R/importar_dados.R")
  source("R/validar_dados.R")
  source("R/calcular_volume.R")
  source("R/resumir_dieta.R")
  source("R/calcular_metricas.R")
  source("R/calcular_IRI.R")
  source("R/calcular_levins.R")
  source("R/calcular_pianka.R")
  source("R/gerar_graficos.R")
  source("R/exportar_resultados.R")
  
  
  # ----------------------------------------------------------
  # 3. Importar dados
  # ----------------------------------------------------------
  
  message("========================================")
  message("              GutR")
  message("   Análise quantitativa da dieta")
  message("========================================")
  message("")
  
  message("1/7 - Importando dados...")
  
  dados <- importar_dados(arquivo)
  
  message("✓ Dados importados com sucesso.")
  message("")
  
  
  # ----------------------------------------------------------
  # 4. Validar dados
  # ----------------------------------------------------------
  
  message("2/7 - Validando dados...")
  
  validar_dados(dados)
  
  message("")
  
  
  # ----------------------------------------------------------
  # 5. Calcular volume
  # ----------------------------------------------------------
  
  message("3/7 - Calculando volume das presas...")
  
  dados <- calcular_volume(dados)
  
  message("✓ Volume calculado.")
  message("")
  
  
  # ----------------------------------------------------------
  # 6. Resumir dieta
  # ----------------------------------------------------------
  
  message("4/7 - Resumindo dieta por grupo e categoria de presa...")
  
  resumo <- resumir_dieta(
    dados,
    por_grupo = TRUE
  )
  
  message("✓ Dieta resumida.")
  message("")
  
  
  # ----------------------------------------------------------
  # 7. Calcular métricas e IRI
  # ----------------------------------------------------------
  
  message("5/7 - Calculando métricas da dieta...")
  
  resultado <- calcular_metricas(
    dados,
    resumo
  )
  
  resultado_IRI <- calcular_IRI(
    resultado
  )
  
  message("✓ Métricas e IRI calculados.")
  message("")
  
  
  # ----------------------------------------------------------
  # 8. Calcular Levins e Pianka
  # ----------------------------------------------------------
  
  message("6/7 - Calculando índices de nicho...")
  
  levins <- calcular_levins(
    resultado_IRI,
    proporcao = proporcao_levins
  )
  
  pianka <- calcular_pianka(
    resultado_IRI,
    proporcao = proporcao_pianka
  )
  
  message("✓ Levins e Pianka calculados.")
  message("")
  
  
  # ----------------------------------------------------------
  # 9. Gerar gráficos
  # ----------------------------------------------------------
  
  if (gerar_graficos) {
    
    message("7/7 - Gerando gráficos...")
    
    grafico_composicao(
      resultado_IRI
    )
    
    grafico_IRI(
      resultado_IRI
    )
    
    grafico_pianka(
      pianka
    )
    
    message("✓ Gráficos gerados.")
    message("")
  }
  
  
  # ----------------------------------------------------------
  # 10. Exportar resultados
  # ----------------------------------------------------------
  
  if (exportar) {
    
    message("Exportando resultados...")
    
    arquivo_resultados <- exportar_resultados(
      dados = dados,
      resultado_IRI = resultado_IRI,
      levins = levins,
      pianka = pianka,
      arquivo_origem = arquivo
    )
    
    message("✓ Resultados exportados.")
    message("")
  }
  
  
  # ----------------------------------------------------------
  # 11. Mensagem final
  # ----------------------------------------------------------
  
  message("========================================")
  message("       ANÁLISE CONCLUÍDA COM SUCESSO")
  message("========================================")
  
  
  # ----------------------------------------------------------
  # 12. Retornar resultados
  # ----------------------------------------------------------
  
  return(
    list(
      dados = dados,
      resumo = resumo,
      metricas = resultado,
      IRI = resultado_IRI,
      Levins = levins,
      Pianka = pianka
    )
  )
}

