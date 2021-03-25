
#' Plot husholdningsbalanse
#'
#' @param data 
#'
#' @return
#' @import ggplot2
#' @importFrom plotly ggplotly
#' @export
#'
#' @examples
plot_husholdningsbalanse <- function(data) {
  
  p = data %>% 
    ggplot() +
    aes(x = date, y = value, fill = name) +
    geom_area(alpha = .4) +
    scale_fill_brewer(palette = "Set2") +
    labs(title = "",
         subtitle = "",
         caption = "Kilde: SSB (tabell 10706)") +
    scale_x_date(limits = c(min(df_prepped$date), max(df_prepped$date)), expand = c(0,0)) +
    scale_y_continuous(expand = c(0,0)) +
    theme(legend.position = "bottom")
  
  plotly::ggplotly(p, dynamicTicks = TRUE)
  
}