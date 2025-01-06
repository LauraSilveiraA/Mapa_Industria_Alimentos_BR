library(readr)
library(dplyr)
dados <- read_delim("operacoes-financiamento-operacoes-indiretas-automaticas.csv", 
                  delim = ";", escape_double = FALSE, trim_ws = TRUE)

dados <- dados %>%
  filter(subsetor_cnae_agrupado == "Produtos Alimentícios")


dados$data_da_contratacao <- as.Date(dados$data_da_contratacao, format = "%Y-%m-%d")

# Definir as datas de início e fim do intervalo
data_inicio <- as.Date("2023-01-01")
data_fim <- as.Date("2023-12-31")

# Filtrar os dados dentro do intervalo de datas
dados <- dados %>%
  filter(data_da_contratacao >= data_inicio & data_da_contratacao <= data_fim)

  resumo_por_estado <- resumo_por_estado %>%
  arrange(desc(total_desembolsado))

  
  resumo_por_estado <- dados %>%
    group_by(uf) %>%
    summarise(total_desembolsado = sum(valor_desembolsado_reais, na.rm = TRUE))

  write.csv(resumo_por_estado, "resumo_por_estado.csv", row.names = FALSE)  
  
    