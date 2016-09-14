#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  output$searchTerm <- renderText(input$searchTerm)

  output$textPrediction <- DT::renderDataTable({
     if(input$searchTerm != ""){
       resultTable <- lookupTerm(as.character(input$searchTerm))
       resultTable
     }
   })
  source("lookupModel.R")
   
})
