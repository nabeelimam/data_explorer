shinyServer(
  function(input, output, session) {
    
    dataset <- reactive({
      
      if (is.null(input$csv_file)) {
        return(iris)
      }
      
      if(!is.null(input$csv_file)) {
        file <- input$csv_file
        
        read.csv(csv_file$datapath)
      }
    })
    
    output$table_main <- DT::renderDataTable(
      dataset(), 
      selection = "none",
      options = list(
        searching = TRUE,
        lengthChange = FALSE,
        paginate = TRUE,
        scroller = TRUE,
        scrollX = TRUE
      ))
    
    observeEvent(dataset(), {
      
      inputs_update <- as.vector(
        outer(
          paste0(c("hist", "box", "scatter", "heatmap"), "_"),
          c("x", "y", "color"),
          paste0)
      )
      
      for (i in inputs_update) {
        updateSelectizeInput(session, i,
                             choices = c("", colnames(dataset())),
                             selected = NULL)
      }
    })
    
    output$hist_plot <- renderPlotly({
      
      validate(
        need(!input$hist_x == "",
             "X-axis variable needs to be selected"))
      validate(
        need(is.numeric(dataset()[[input$hist_x]]),
           "X-axis variable needs to be numeric"))
      
      
      make_histogram(data = dataset(),
                     x_name = input$hist_x,
                     col_name = input$hist_color)

    })
    
    output$box_plot <- renderPlotly({
      
      validate(
        need(!"" %in% c(input$box_x, input$box_y),
             "Both x and y axes variables need to be selected"),
        need(!input$box_x == input$box_y,
             "Different variables for x and y axes needed")
      )
      
      make_boxplot(data = dataset(),
                   x_name = input$box_x,
                   y_name = input$box_y)
      
    })
    
    output$scatter_plot <- renderPlotly({
      
      validate(
        need(!"" %in% c(input$scatter_x, input$scatter_y),
             "Both x and y axes variables need to be selected"),
        need(!input$scatter_x == input$scatter_y,
             "Different variables for x and y axes needed")
      )
      
      make_scatterplot(
        data = dataset(),
        x_name = input$scatter_x,
        y_name = input$scatter_y,
        col_name = input$scatter_color
      )
    })
    
    output$heatmap_plot <- renderPlotly({
      
      validate(
        need(!"" %in% c(input$heatmap_x, input$heatmap_y, input$heatmap_color),
             "X- and y-axis variables AND fill needs to be selected"),
        need(is.numeric(dataset()[[input$heatmap_color]]),
             "Fill variable needs to be numeric")
      )
      
      make_heatmap(
        data = dataset(),
        x_name = input$heatmap_x,
        y_name = input$heatmap_y,
        col_name = input$heatmap_color
      )
      
      
    })
    
    
})