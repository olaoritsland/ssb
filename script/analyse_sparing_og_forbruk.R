
# last inn pakke
devtools::load_all()


transactions <- c("- Consumption",
                  "= DISPOSABLE INCOME",
                  "= SAVING") 


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
  select(-c(sector, contents)) %>% 
  mutate(sparerate = saving/disposable_income)


# plot data
p <- df_prepped %>% 
  # select(-sparerate) %>% 
  tidyr::pivot_longer(-date) %>% 
  ggplot(aes(x = date, y = value, color = name)) +
  geom_line()

plotly::ggplotly(p, dynamicTicks = TRUE)
