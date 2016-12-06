library(shiny)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  
  out <- data.frame()
  
  output$distPlot <- renderPlot({
    
    for(i in 1:2500){
      c <- c(rep(1, input$n), rep(2, input$n))
      x <- c(rnorm(input$n, mean=0), rnorm(input$n, mean=input$d))
      t <- t.test(x~c)
      
      out[i,1] <<- t$statistic
      out[i,2] <<- t$parameter
      out[i,3] <<- t$p.value 
      out[i,4] <<- t$estimate[2] - t$estimate[1] # How much higher is group 2 than group 1
    }
    
    names(out) <<- c("t", "df", "pval", "x2-x1")

    # draw the histogram with the specified number of bins
    hist(out$pval[out$pval<=input$plotmax], breaks = 20, xlim=c(0, input$plotmax), col = 'darkgray', border = 'white', 
         main = paste("Histogram of p values in 2500 t-tests \nwith a true mean difference of ", input$d, "and ", 
                      input$n, " cases per group."), xlab = "p value", ylab= "Number of trials")
    abline(v=input$crit, col="red")
  })
  
  output$text1 <- renderText({
    if (input$d==0){
      paste("In 2500 simulated trials, sampling two groups of ", input$n, " individuals from a single population of mean = 0, ",
            sum(out$pval<input$crit), " statistically significant mean differences (", (sum(out$pval<input$crit)/2500)*100, 
            "% of trials) were observed (alpha = ", input$crit  ,").", sep="")
    } else {
          paste("In 2500 simulated trials, sampling two groups of ", input$n, " individuals each from populations of mean = 0 and ", 
                input$d, ", ",  sum(out$pval<input$crit), " statistically significant mean differences (", 
                (sum(out$pval<input$crit)/2500)*100, "% of trials) were observed (alpha = ", input$crit  ,").", sep="") 
    }
    })
})
