library(shiny)
library(shinydashboard)
library(plotly)
library(DT)

welcome_message <- "This Shiny app helps you make plots from your data. 
Each plot has it's own tab in the sidebar menu. You can upload your own 
data (CSV), or work with the default dataset (iris)."

glyph <- function(name) icon(name, lib = "glyphicon")
fa <- function(name) icon(name, lib = "font-awesome")

make_histogram <- function(data, x_name, col_name) {
  
  if (!col_name == "") 
    plot_ly(data = data,
            x = ~.data[[x_name]],
            color = ~.data[[col_name]],
            type = "histogram") %>%
    layout(xaxis = list(title = x_name)) %>% 
    colorbar(title = col_name,
             len = 0.7,
             lenmode = "frac")
  
  else plot_ly(data = data,
               x = ~.data[[x_name]],
               type = "histogram") %>%
    layout(xaxis = list(title = x_name))
}

make_boxplot <- function(data, x_name, y_name) {
  
  plot_ly(data = data,
          x = ~.data[[x_name]],
          y = ~.data[[y_name]],
          type = "box") %>%
    layout(xaxis = list(title = x_name),
           yaxis = list(title = y_name))
}

make_scatterplot <- function(data, x_name, y_name, col_name) {
  
  if (!col_name == "") plot_ly(data = data,
                               x = ~.data[[x_name]],
                               y = ~.data[[y_name]],
                               color = ~.data[[col_name]],
                               type = "scatter", mode = "markers") %>%
    layout(xaxis = list(title = x_name),
           yaxis = list(title = y_name)) %>% 
    colorbar(title = col_name,
             len = 0.7,
             lenmode = "frac")
  
  else plot_ly(data = data,
               x = ~.data[[x_name]],
               y = ~.data[[y_name]],
               type = "scatter", mode = "markers") %>%
    layout(xaxis = list(title = x_name),
           yaxis = list(title = y_name))
}

make_heatmap <- function(data, x_name, y_name, col_name) {
  
  plot_ly(data = data,
          x = ~.data[[x_name]],
          y = ~.data[[y_name]],
          z = ~.data[[col_name]],
          type = "heatmap") %>%
    layout(xaxis = list(title = x_name),
           yaxis = list(title = y_name)) %>% 
    colorbar(title = col_name,
             len = 0.7,
             lenmode = "frac")
}
