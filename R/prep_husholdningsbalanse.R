
#' Prep husholdningsbalanse
#'
#' @param data 
#'
#' @return
#' @import dplyr
#' @importFrom janitor clean_names
#' @importFrom tidyr pivot_wider pivot_longer
#' @export
#'
#' @examples
prep_husholdningsbalanse <- function(data) {
  
  data %>% 
    tidyr::pivot_wider(values_from = value,
                       names_from = item) %>% 
    janitor::clean_names() %>%
    mutate(pension_assets = life_insurance_and_annuity_entitlements 
           + pension_entitlements_of_which_defined_contribution) %>% 
    select(-c(sector, 
              counterpart_sector, 
              contents,
              life_insurance_and_annuity_entitlements,
              pension_entitlements_of_which_defined_contribution)) %>%
    rowwise() %>% 
    mutate(other = 
             sum_financial_assets_f -
             sum(dplyr::c_across(deposits:pension_assets), na.rm = TRUE))%>% 
    ungroup() %>% 
    tidyr::pivot_longer(-date)
  
}