#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(

    # Application title
  titlePanel("Text prediction demonstration"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
      textInput("searchTerm", "Search text")
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      textOutput("warningText"),
      h1("Your search term:"),
      textOutput("searchTerm"),
      
      DT::dataTableOutput("textPrediction")
      #tableOutput("textPrediction")

    )
  )
))
