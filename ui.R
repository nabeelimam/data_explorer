shinyUI(
  dashboardPage(
    dashboardHeader(title = "Data Explorer"),
    dashboardSidebar(
      sidebarMenu(
        menuItem("Data", tabName = "dashboard", icon = fa("globe")),
        menuItem("Histogram", tabName = "histogram", icon = glyph("stats")),
        menuItem("Boxplot", tabName = "boxplot", icon = glyph("pause")),
        menuItem("Scatter", tabName = "scatter", icon = glyph("equalizer")),
        menuItem("Heatmap", tabName = "heatmap", icon = glyph("th"))
      )
    ),
    dashboardBody(
      tabItems(
        tabItem(tabName = "dashboard",
                fluidRow(
                  column(
                    width = 4,
                    wellPanel(
                      fileInput(inputId = "csv_file", label = "File Upload:",
                                accept = c("csv", ".csv"))
                    )
                  ),
                  column(
                    width = 8,
                    box(p(welcome_message), title = "Welcome!")
                  )
                ),
                fluidRow(
                  column(
                    width = 10,
                    DT::dataTableOutput("table_main")
                  )
                  
                )
        ),
        
        tabItem(tabName = "histogram",
                fluidRow(
                  column(
                    width = 9,
                    plotlyOutput("hist_plot")
                  ),
                  column(
                    width = 3,
                    box("Controls",
                        selectInput("hist_x", "X-axis", choices = NULL, selectize = T),
                        selectInput("hist_color", "Fill", choices = NULL, selectize = T),
                        width = NULL)
                  )
                )
        ),
        tabItem(tabName = "boxplot",
                fluidRow(
                  column(
                    width = 9,
                    plotlyOutput("box_plot")
                  ),
                  column(
                    width = 3,
                    box("Controls",
                        selectInput("box_x", "X-axis", choices = NULL, selectize = T),
                        selectInput("box_y", "Y-axis", choices = NULL, selectize = T),
                        width = NULL)
                  )
                )
        ),
        tabItem(tabName = "scatter",
                fluidRow(
                  column(
                    width = 9,
                    plotlyOutput("scatter_plot")
                  ),
                  column(
                    width = 3,
                    box("Controls",
                        selectInput("scatter_x", "X-axis", choices = NULL, selectize = T),
                        selectInput("scatter_y", "Y-axis", choices = NULL, selectize = T),
                        selectInput("scatter_color", "Color", choices = NULL, selectize = T),
                        width = NULL)
                  )
                )
        ),
        tabItem(tabName = "heatmap",
                fluidRow(
                  column(
                    width = 9,
                    plotlyOutput("heatmap_plot")
                  ),
                  column(
                    width = 3,
                    box("Controls",
                        selectInput("heatmap_x", "X-axis", choices = NULL, selectize = T),
                        selectInput("heatmap_y", "Y-axis", choices = NULL, selectize = T),
                        selectInput("heatmap_color", "Fill", choices = NULL, selectize = T),
                        width = NULL)
                  )
                )
        )
      )
    )
  )
)
 