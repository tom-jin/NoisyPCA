
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://www.rstudio.com/shiny/
#

library(shiny)
library(elasticnet)
library(pcaPP)

# Constants ----
g <- 6 # Number of groups.
n <- 1000 # Number of samples.
p <- 4 # Number of variables.

shinyServer(function(input, output) {

  output$plot <- renderPlot({

    set.seed(42, kind = NULL, normal.kind = NULL)
    truth <- sample.int(n = g, size = n, replace = TRUE)
    latnt <- matrix(0, nrow = n, ncol = g)
    for (i in 1:n) {
      latnt[i, truth[i]] <- 1
    }
    model <- matrix(rnbinom(n = g * p, size = 40, prob = 0.5), nrow = g,
                    ncol = p)

    noise <- matrix(sample(x = (-1 * input$e):input$e, size = n * p,
                           replace = TRUE), nrow = n, ncol = p)
    obser <- pmax(latnt %*% model + noise, matrix(0, nrow = n, ncol = p)) *
      matrix(rbinom(n * p, size = 1, prob = 1-input$c), nrow = n, ncol = p)

    pca <- prcomp(obser, center = TRUE, scale. = TRUE)
    plot(pca$x[, 1:2], col = truth, xlim = c(-5, 5), ylim = c(-5, 5),
         main = "PCA", xlab = "Component 1", ylab = "Component 2")
  })
})
