# server.R

library(maps)
library(mapproj)
counties <- readRDS("data/counties.rds")
source("helpers.R")

shinyServer(
  function(input, output) {
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
  }
)
enableBookmarking("url")