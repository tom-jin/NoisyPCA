
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://www.rstudio.com/shiny/
#

library(shiny)

shinyUI(fluidPage(

  # Application title
  titlePanel("Principal Component Analysis"),

  # Sidebar with a slider input for number of bins
  sidebarLayout(
   sidebarPanel(
     sliderInput("g", "Groups:", min = 1, max = 20, value = 10),
     sliderInput("n", "Observations:", min = 100, max = 2000, value = 200, step = 100),
     sliderInput("p", "Variables:", min = 100, max = 20000, value = 2000, step = 100),
     sliderInput("e", "Noise:", min = 0, max = 100, value = 0, animate = TRUE),
     sliderInput("s", "Sparsity:", min = 1, max = 10, value = 1)
   ),

  # Show a plot of the generated distribution
  mainPanel(plotOutput("plot", height = 1200))
)))
