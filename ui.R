library(shiny)

shinyUI(pageWithSidebar(
  headerPanel("CO2 Uptake Prediction"),
  sidebarPanel(
    p("Usage: "),
    p("1. Select Plant Type and Treatment"),
    p("2. Set the CO2 concentration."), 
    selectInput("id1", "Plant", 
                 c("Quebec Nonchilled"="Quebec.nonchilled",
                   "Quebec Chilled"="Quebec.chilled",
                   "Mississippi Nonchilled"="Mississippi.nonchilled",
                   "Mississippi Chilled"="Mississippi.chilled"
                   )
                  ), 
    sliderInput('mu', 'Guess at the Co2 Concentration',value = 500, min = 0, max = 1000, step = 50,)
  ),
  mainPanel(
    h4("This application predicts CO2 uptake by plant subject based on input of CO2 concentration."), 
    textOutput('uptakeText'),
    plotOutput('newHist')    
  )
))

