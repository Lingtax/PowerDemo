# Power Demo #

# This is a simulation to demonstrate the relationship between N and p-values
# obtained to demonstrate the principles of statistical power

n <-10 # number of cases per group
d <- 0 #  Mean difference between group 1 and 2, when d= 0, 2 * n cases will be drawn from the same distribution with mean = 0, sd = 1
reps <- 5000 # number of simulated samples
plotmax <- 1 #maximum p-value that will be plotted

out <- data.frame()
for(i in 1:reps){
  c <- c(rep(1, n), rep(2, n))
  x <- c(rnorm(n, mean=0), rnorm(n, mean=d))
  t <- t.test(x~c)
  
  out[i,1] <- t$statistic
  out[i,2] <- t$parameter
  out[i,3] <- t$p.value 
  out[i,4] <- t$estimate[2] - t$estimate[1] # How much better is group 2 than group 1
  out[i,5] <- ifelse(t$p.value<.001, "***", 
                     ifelse(t$p.value<.01, "**", 
                            ifelse(t$p.value<.05, "*", "")))
  
}

names(out) <- c("t", "df", "p.value", "x2-x1", "sig.flag")

paste("In ", reps, " simulated trials, ", sum(out$p.value<.05), " statistically significant (p<.05) mean differences (", sum(out$p.value<.05)/reps,") were observed.", sep="") # This will give a summary of the simulations.


for(i in sort(sample(1:reps, 10))){
  if(out$sig.flag[i]==""){cat(
    "Boo! In trial number ", i, ", no significant difference was found between groups,\n t(", out$df[i], ") = ",  out$t[i], ", p = ", out$p.value[i], ". Observed mean difference was ", out$`x2-x1`[i], ".\n\n", sep="")
  } else {
    cat("Hooray! In trial number ", i, ", a significant difference was found between groups,\n t(", out$df[i], ") = ",  out$t[i], ", p = ", out$p.value[i], ". Observed mean difference was ", out$`x2-x1`[i], ".\n\n", sep="") 
  }
}


hist(out$p.value[out$p.value<=plotmax], breaks=20, xlim=c(0, plotmax), 
     main=paste("Histogram of p values \nin ", reps, 
            " t-tests with a true mean difference of ", d, "and ", n, " cases per group.", sep=""),
     xlab = "p value", ylab= "Number of trials")
abline(h= reps*.05,v=0.05, col="red")

