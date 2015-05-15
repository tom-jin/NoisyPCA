
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://www.rstudio.com/shiny/
#

library(shiny)

shinyUI(fluidPage(
  # Application title
  titlePanel("Principal Component Analysis: Censored Count Data"),

  # Sidebar with a slider input for number of bins
  sidebarLayout(
   sidebarPanel(
     sliderInput("c", "Censorship:", min = 0, max = 0.99, value = 0, step = 0.01, animate = TRUE),
     sliderInput("e", "Noise:", min = 0, max = 30, value = 0, animate = TRUE)
   ),

  # Show a plot of the generated distribution
  mainPanel(plotOutput("plot"))
)))
