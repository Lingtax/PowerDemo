library(shiny)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  
  # Expression that generates a histogram. The expression is
  # wrapped in a call to renderPlot to indicate that:
  #
  #  1) It is "reactive" and therefore should re-execute automatically
  #     when inputs change
  #  2) Its output type is a plot


  pval <- NULL
  
  output$distPlot <- renderPlot({
    for(i in 1:2500){
      c <- c(rep(1, input$n), rep(2, input$n))
      x <- c(rnorm(input$n, mean=0), rnorm(input$n, mean=input$d))
      t <- t.test(x~c)
      pval[i] <- t$p.value 
    }
    
    
    
    # draw the histogram with the specified number of bins
    hist(pval[pval<=input$plotmax], breaks = 20, xlim=c(0, input$plotmax), col = 'darkgray', border = 'white', 
         main = paste("Histogram of p values in 2500 t-tests \nwith a true mean difference of ", input$d, "and ", 
                      input$n, " cases per group."), xlab = "p value", ylab= "Number of trials")
    abline(v=0.05, col="red")
  })
})