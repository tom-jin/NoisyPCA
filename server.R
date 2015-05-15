
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://www.rstudio.com/shiny/
#

library(shiny)
library(elasticnet)
library(pcaPP)

shinyServer(function(input, output) {

  output$plot <- renderPlot({

    set.seed(42, kind = NULL, normal.kind = NULL)
    truth <- sample.int(n = input$g, size = input$n, replace = TRUE)
    latnt <- matrix(0, nrow = input$n, ncol = input$g)
    for (i in 1:input$n) {
      latnt[i, truth[i]] <- 1
    }
    model <- matrix(rgeom(n = input$n * input$p, prob = 0.1), nrow = input$g,
                    ncol = input$p)

    par(mfrow=c(3,1))
    noise <- matrix(sample(x = (-1 * input$e):input$e, size = input$n * input$p,
                           replace = TRUE), nrow = input$n, ncol = input$p)
    obser <- pmax(latnt %*% model + noise, matrix(0, nrow = input$n, ncol = input$p))

    pca <- prcomp(obser, center = TRUE, scale. = TRUE)
    plot(pca$x[, 1:2], col = truth, xlim = c(-20, 40), ylim = c(-20, 30),
         main = "PCA", xlab = "Component 1", ylab = "Component 2")

    spca <- arrayspc(obser, K = 2, para = c(10^input$s, 10^input$s))
    plot(obser %*% spca$loadings, col = truth, xlim = c(-100, 400),
         ylim = c(-200, 300), main = "Sparse PCA",
         xlab = paste("Component 1:", sum(spca$loadings[, 1] != 0), "non-zero loadings"),
         ylab = paste("Component 2:", sum(spca$loadings[, 2] != 0), "non-zero loadings"))

    rpca <- PCAgrid(obser, 2)
    plot(obser %*% rpca$loadings, col = truth, xlim = c(-200, 200),
         ylim = c(-200, 200), main = "Robust PCA", xlab = "Component 1", ylab = "Component 2")
  })
})
