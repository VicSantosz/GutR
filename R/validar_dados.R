# ============================================================
# GutR
# Validação dos dados de entrada
# ============================================================

validar_dados <- function(dados) {
  
  # ----------------------------------------------------------
  # 1. Verificar se o objeto é um data.frame
  # ----------------------------------------------------------
  
  if (!is.data.frame(dados)) {
    stop(
      "Erro: os dados precisam estar em uma tabela (data.frame)."
    )
  }
  
  
  # ----------------------------------------------------------
  # 2. Verificar colunas obrigatórias
  # ----------------------------------------------------------
  
  colunas_obrigatorias <- c(
    "grupo",
    "individuo",
    "presa",
    "comprimento",
    "largura"
  )
  
  colunas_faltantes <- setdiff(
    colunas_obrigatorias,
    names(dados)
  )
  
  if (length(colunas_faltantes) > 0) {
    
    stop(
      paste0(
        "Erro: as seguintes colunas obrigatórias estão ausentes: ",
        paste(
          colunas_faltantes,
          collapse = ", "
        ),
        "."
      )
    )
  }
  
  
  # ----------------------------------------------------------
  # 3. Verificar valores ausentes
  # ----------------------------------------------------------
  
  problemas <- character(0)
  
  
  # Grupo
  grupo_vazio <- is.na(dados$grupo) |
    trimws(as.character(dados$grupo)) == ""
  
  if (any(grupo_vazio)) {
    
    problemas <- c(
      problemas,
      paste0(
        "A coluna 'grupo' possui ",
        sum(grupo_vazio),
        " valor(es) vazio(s)."
      )
    )
  }
  
  
  # Indivíduo
  individuo_vazio <- is.na(dados$individuo) |
    trimws(as.character(dados$individuo)) == ""
  
  if (any(individuo_vazio)) {
    
    problemas <- c(
      problemas,
      paste0(
        "A coluna 'individuo' possui ",
        sum(individuo_vazio),
        " valor(es) vazio(s)."
      )
    )
  }
  
  
  # Presa
  presa_vazia <- is.na(dados$presa) |
    trimws(as.character(dados$presa)) == ""
  
  if (any(presa_vazia)) {
    
    problemas <- c(
      problemas,
      paste0(
        "A coluna 'presa' possui ",
        sum(presa_vazia),
        " valor(es) vazio(s)."
      )
    )
  }
  
  
  # ----------------------------------------------------------
  # 4. Verificar comprimento
  # ----------------------------------------------------------
  
  comprimento_na <- is.na(dados$comprimento)
  
  if (any(comprimento_na)) {
    
    problemas <- c(
      problemas,
      paste0(
        "A coluna 'comprimento' possui ",
        sum(comprimento_na),
        " valor(es) ausente(s) ou não numérico(s)."
      )
    )
  }
  
  
  comprimento_negativo <- !is.na(dados$comprimento) &
    dados$comprimento <= 0
  
  if (any(comprimento_negativo)) {
    
    problemas <- c(
      problemas,
      paste0(
        "A coluna 'comprimento' possui ",
        sum(comprimento_negativo),
        " valor(es) menor(es) ou igual(is) a zero."
      )
    )
  }
  
  
  # ----------------------------------------------------------
  # 5. Verificar largura
  # ----------------------------------------------------------
  
  largura_na <- is.na(dados$largura)
  
  if (any(largura_na)) {
    
    problemas <- c(
      problemas,
      paste0(
        "A coluna 'largura' possui ",
        sum(largura_na),
        " valor(es) ausente(s) ou não numérico(s)."
      )
    )
  }
  
  
  largura_negativa <- !is.na(dados$largura) &
    dados$largura <= 0
  
  if (any(largura_negativa)) {
    
    problemas <- c(
      problemas,
      paste0(
        "A coluna 'largura' possui ",
        sum(largura_negativa),
        " valor(es) menor(es) ou igual(is) a zero."
      )
    )
  }
  
  
  # ----------------------------------------------------------
  # 6. Verificar se existem problemas
  # ----------------------------------------------------------
  
  if (length(problemas) > 0) {
    
    mensagem <- paste(
      c(
        "❌ Erro na validação dos dados.",
        "",
        "Foram encontrados os seguintes problemas:",
        "",
        paste(
          seq_along(problemas),
          problemas,
          sep = ". "
        ),
        "",
        "Corrija a planilha e execute o GutR novamente."
      ),
      collapse = "\n"
    )
    
    stop(
      mensagem,
      call. = FALSE
    )
  }
  
  
  # ----------------------------------------------------------
  # Dados válidos
  # ----------------------------------------------------------
  
  message(
    "✓ Validação concluída: os dados estão válidos."
  )
  
  return(TRUE)
}

