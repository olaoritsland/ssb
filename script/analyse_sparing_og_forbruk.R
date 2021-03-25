
# last inn pakke
devtools::load_all()


transactions <- c("- Personal consumption",
                  "- Interest expenses",
                  "+ Interest income",
                  "+ Property income",
                  "- Consumption",
                  "= DISPOSABLE INCOME",
                  "= Adjusted disposable income",
                  "= SAVING",
                  "MEMO: Savings ratio")


# hent data
df <- hent_tabell(
  tabell = "11020",
  Tid = all(),
  Sektor = "Households",
  Transaksjoner = transactions,
  ContentsCode = "Revenue and expenditure. Unadjusted figures (NOK million)"
  ) 


# prep data
df_prepped <- df %>% 
  tidyr::pivot_wider(values_from = value,
                     names_from = transaction) %>% 
  janitor::clean_names() %>% 
  select(-c(sector, contents)) 

# plot data
p <- df_prepped %>% 
  select(date, consumption, personal_consumption, saving, adjusted_disposable_income) %>% 
  tidyr::pivot_longer(-date) %>% 
  ggplot(aes(x = date, y = value, color = name)) +
  geom_line()

plotly::ggplotly(p, dynamicTicks = TRUE)
