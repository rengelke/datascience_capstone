

# ######################################################################### #
#                                                                           #
# UI: WoPr [wopper] - The Word Prediction App                               #
# Coursera Data Science Capstone Project                                    #
#                                                                           #
# ######################################################################### # 



library(shiny)


# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("WoPr - The Word Prediction App"),
  
  fluidRow(
       column(6,
              h2("Text input"),
              textInput("text", label = "Your input will be evaluated automatically.",
                        value = "")
       ),
       column(6,
              h4("Prediction"),
              p("The most probable word is displayed at the top"),
              textOutput("pred1", h2),
              textOutput("pred2", h4),
              textOutput("pred3", h4)
       )
  )
     
  
))
