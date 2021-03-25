# pakker
devtools::load_all()

# finansposter vi ønsker å hente
poster <- c("Listed shares",
            "Unlisted shares",
            "Deposits",
            "Other deposits",
            "Investment fund shares or units",
            "Life insurance and annuity entitlements",
            "Pension entitlements, of which defined contribution",
            "Sum financial assets (F)")

# hent tabelldata

df <- hent_tabell(
  tabell = "10706", 
  Sektor = "Sum all sectors", 
  Motsektor = "Sum all sectors",
  Tid = all(),
  ContentsCode = "Stocks",
  Finanspost = poster
  )

# preparer data

df_prepped <- prep_husholdningsbalanse(df)

# plot
plot_husholdningsbalanse(df_prepped)




