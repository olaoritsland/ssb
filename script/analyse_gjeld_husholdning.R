# pakker
devtools::load_all()


# hent gjeldsdata

df_gjeld <- hent_tabell(
  tabell = "10706", 
  Sektor = "Households", 
  Motsektor = "Sum all sectors",
  Tid = all(),
  ContentsCode = "Stocks",
  Finanspost = "Sum liabilities (G)"
) %>% 
  select(date, item, value) %>% 
  tidyr::pivot_wider(values_from = value, names_from = item) %>% 
  janitor::clean_names() %>% 
  arrange(date) %>% 
  mutate(gjeldsvekst = sum_liabilities_g / lag(sum_liabilities_g) - 1)

# hent disponibel inntekt

transactions <- c("- Consumption",
                  "= DISPOSABLE INCOME",
                  "= SAVING")

df_innt <- hent_tabell(
  tabell = "11020",
  Tid = all(),
  Sektor = "Households",
  Transaksjoner = transactions,
  ContentsCode = "Revenue and expenditure. Unadjusted figures (NOK million)"
) %>% 
  select(date, transaction, value) %>% 
  tidyr::pivot_wider(values_from = value, names_from = transaction) %>% 
  janitor::clean_names()


# join data

df <- df_gjeld %>% 
  left_join(df_innt, by = "date") %>% 
  rename(total_gjeld = sum_liabilities_g) %>% 
  mutate(gjeldsrate = total_gjeld / disposable_income)

df %>% 
  ggplot(aes(x = date, y = gjeldsrate)) +
  geom_line()
