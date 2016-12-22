# server.R

library(maps)
library(mapproj)
counties <- readRDS("data/counties.rds")
source("helpers.R")
library("shinyURL")

shinyServer(
  function(input, output, session) {
    output$map <- renderPlot({
      data <- switch(input$var, 
                     "Percent White" = counties$white,
                     "Percent Black" = counties$black,
                     "Percent Hispanic" = counties$hispanic,
                     "Percent Asian" = counties$asian)
      
      title <- switch(input$var, 
                      "Percent White" = "% White",
                      "Percent Black" = "% BLack",
                      "Percent Hispanic" = "% Hispanic",
                      "Percent Asian" = "% Asian")

      
      percent_map(var = data, 'darkgreen', title, max = input$range[2], min = input$range[1])
    })
    output$text <- renderText({
      
      title <- switch(input$var, 
                      "Percent White" = "% White",
                      "Percent Black" = "% BLack",
                      "Percent Hispanic" = "% Hispanic",
                      "Percent Asian" = "% Asian")
      paste(var = title)
    })
    
    ntext <- eventReactive(input$goButton, {
      input$n
    })
    
    
    
    output$nText <- renderText({
      paste0("N = ", ntext())
    })
    
    shinyURL.server()
  }
)
enableBookmarking("url")