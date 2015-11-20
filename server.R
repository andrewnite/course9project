
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)
library(datasets)
library(ggplot2)
library(stats)


shinyServer(function(input, output) {
  
  predictor_short_names <- c("cyl", "disp", "hp", "drat", "wt", "qsec", "vs", "am", "gear", "carb")
  predictor_long_names <- c("Number of cylinders", "Displacement", "Gross horsepower", "Rear axle ratio", "Weight (lb/1000)", "1/4 mile time", "V/S", "Transmission", "Number of forward gears", "Number of carburetors")
  
  # Drop-down selection box for predictor
  output$choose_dataset <- renderUI({
    selectInput("predictor_option", "Plot by feature", as.list(predictor_long_names))
  })
  
  # Text input for prediction
  output$prediction_input <- renderUI({
    textInput("value_to_predict", "Enter a value to predict", 0)
  })
  
  output$dist_plot <- renderPlot({
    if (is.null(input$predictor_option)){
      return()
    }
    
    # Get the index of the selected feature
    predictor_short_name = predictor_short_names[match(input$predictor_option, predictor_long_names)]
    
    df <- data.frame(mtcars[predictor_short_name], mpg=mtcars$mpg)
    colnames(df)[1]<-"predictor"
    
    ## Now use a linear model to predict a result for the user's input
    if (!is.null(input$value_to_predict)){
      value_to_predict_num <- as.numeric(input$value_to_predict)
      linear_model <- lm(mpg~predictor, data=df)
      res <- predict(linear_model, data.frame(predictor=value_to_predict_num))
      rounded_result <- round(res[[1]], digits = 2)
            
      output$prediction_result <- renderText({ 
        paste("Prediction:", input$predictor_option, "of", value_to_predict_num, "will result in",toString(rounded_result), "miles per gallon")
      })
    }
    
    ggplot(df, aes(x=predictor, y=mpg)) +
      geom_point(shape=1) +
      geom_smooth(method=lm) +
      xlab(input$predictor_option) + 
      ylab("Miles per gallon")
    
  })

})
