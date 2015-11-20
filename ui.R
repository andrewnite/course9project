
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)

shinyUI(fluidPage(

  # Application title
  titlePanel("Mt Cars Dataset Linear Regression Exploration"),

  # Sidebar with a slider input for number of bins
  sidebarLayout(
    sidebarPanel(
      # Place the drop down on the left hand side
      uiOutput("choose_dataset"),
      uiOutput("prediction_input")
    ),
    
    # Show the bar plot
    mainPanel(
      plotOutput("dist_plot"),
      textOutput("prediction_result"),
      br()
    )
    
  ),
  
  wellPanel(
    p("This application allows you to view scatter plots of each of the attributes in the built in R dataset, mtcars, against the Miles per gallon attribute."),
    p("To use the application, simply use the drop down input to select the attribute you would like to display a scatter plot for."),
    p("Optionalliy: you may use the second input (text box) to enter a value in which you would like a prediction for by using a linear regression model.")
  )
  
))
