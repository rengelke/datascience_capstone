
#
# Server: WoPr [wopper] - The Word Prediction App 
# 


source("utils.R")

# load dataset
dt_all_grams <- readRDS("./data/ngram_dataset.RDS")


# server logic
shinyServer(function(input, output) {
     
     text_reactive <- reactive({
          if (nchar(input$text) > 0){
               predict_word(input$text)
               }
     })
     
     
     output$pred1 <- renderText({
          text_reactive()[1]
     })
     output$pred2 <- renderText({
          text_reactive()[2]
     })
     output$pred3 <- renderText({
          text_reactive()[3]
     })
     
  
})
