# ============================================================
# GutR
# Carregamento dos pacotes
# ============================================================

carregar_pacotes <- function() {
  
  pacotes <- c(
    "readxl",
    "dplyr",
    "ggplot2",
    "openxlsx",
    "tidyr"
  )
  
  faltantes <- pacotes[
    !pacotes %in% rownames(installed.packages())
  ]
  
  if (length(faltantes) > 0) {
    
    stop(
      paste0(
        "Os seguintes pacotes precisam ser instalados: ",
        paste(faltantes, collapse = ", "),
        "\n\nUse install.packages() para instalá-los."
      )
    )
  }
  
  invisible(
    lapply(
      pacotes,
      library,
      character.only = TRUE
    )
  )
}
