
#' Hent tabell
#'
#' @param tabell 
#' @param fiks_dato
#' @param ... 
#'
#' @return
#' @importFrom PxWebApiData ApiData
#' @export
#'
#' @examples
hent_tabell <- function(tabell, fiks_dato = TRUE, ...) {
  
  table_url <- file.path("http://data.ssb.no/api/v0/en/table", tabell)
  
  data <- PxWebApiData::ApiData(table_url, ...)[[1]]
  
  if (fiks_dato) {
    data <- fiks_dato(data)
  }
  
  data
  
}


#' Fiks dato
#'
#' @param data 
#'
#' @return
#' @importFrom lubridate ymd
#' @importFrom stringr str_sub 
#' @import magrittr
#' @import dplyr
#' @export
#'
#' @examples
fiks_dato <- function(data) {
  
  data %>%
    mutate(
      year = stringr::str_sub(quarter, 1, 4),
      q = stringr::str_sub(quarter, 6),
      md = 
        case_when(q == 1 ~ "03-31",
                  q == 2 ~ "06-30",
                  q == 3 ~ "09-30",
                  q == 4 ~ "12-31"),
      date = paste0(year, "-", md) %>% lubridate::ymd()) %>% 
    select(-c(year, q, md, quarter))
  
  
}


