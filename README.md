# GutR

# Ferramenta computacional para análise quantitativa de dieta e índices ecológicos

O GutR é uma ferramenta desenvolvida em R para automatizar a análise quantitativa do conteúdo estomacal. O script organiza os dados da dieta, calcula métricas de importância dos itens alimentares e índices de nicho, como Levins e Pianka, e gera automaticamente tabelas e gráficos dos resultados.

# Funcionalidades

O GutR permite realizar:

- cálculo do volume das presas;
- frequência de ocorrência;
- abundância numérica;
- porcentagens de número, volume e frequência;
- Índice de Importância Relativa (IRI);
- Índice de Levins;
- Índice de sobreposição de Pianka;
- geração de gráficos;
- exportação dos resultados para Excel.

# Estrutura do projeto

```text
GutR/
├── R/
├── dados/
├── resultados/
├── graficos/
├── GutR.Rproj
├── Manual/
├── README.md
└── .gitignore

Observação
Um conjunto de dados fictício para demonstração está disponível na pasta dados/.

Exemplo
O usuário pode executar o GutR utilizando um arquivo de dados no formato .xlsx.

Os resultados das análises são exportados para a pasta resultados/ e os gráficos gerados são armazenados em graficos/.

Nota: Os dados disponibilizados neste repositório para demonstração são fictícios e não representam observações biológicas reais.

Tecnologias
R
RStudio
readxl
dplyr
ggplot2
openxlsx

Autoria
Desenvolvido por Victória Gabriely no âmbito de projeto de iniciação tecnológica da Universidade Federal do Amapá (UNIFAP).
