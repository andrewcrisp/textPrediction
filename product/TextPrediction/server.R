library(shiny)
source("lookupModel.R")

shinyServer(function(input, output) {
  options(DT.options = list(pageLength = 12, dom='t', order = list(list(3,'desc'))))
  
  output$textPrediction <- DT::renderDataTable({
     if(input$searchTerm != ""){
       output$searchTermLabel <- renderText(paste("Your search term: ", input$searchTerm))
       
       resultTable <- lookupTerm(as.character(input$searchTerm))
       
       if (nrow(resultTable) == 0){
         output$mostLikelyLabel <- renderText(paste("No results found for the search term."))
         NULL
       } else {
         output$mostLikelyLabel <- renderText(paste("Most likely phrase: ", predictMostLikely(resultsTable = resultTable)))
         resultTable
       }
     }
   })
})
