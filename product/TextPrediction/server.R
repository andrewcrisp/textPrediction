library(shiny)
source("lookupModel.R")

shinyServer(function(input, output) {
  options(DT.options = list(pageLength = 12, dom='t', order = list(list(3,'desc'))))
  
  output$searchTerm <- renderText(input$searchTerm)
  
  output$searchTermLabel <- renderText(paste("Your search term: ", input$searchTerm))
  
  output$textPrediction <- DT::renderDataTable({
     if(input$searchTerm != ""){
       resultTable <- lookupTerm(as.character(input$searchTerm))
       output$mostLikelyLabel <- renderText(paste("Most likely phrase: ", predictMostLikely(resultsTable = resultTable)))
       resultTable
     }
   })
})
