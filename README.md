# PowerDemo
The concepts of statistical power, and error rates in NHST can be difficult for students of statistics to grasp.
One way to illustrate these principles is through simulation of numerous trials. By making changes to parameters of the simulation, the effects of changes in the key variables of effect size (mean difference) and sample size can be demonstrated. 

As a side benefit, these simulations allow for the demonstration of more basic principles in the NHST framework, like type I error rates, and lay the foundation for [explanation of concepts like the p-curve][1]. 

The demonstrations operate through a common, basic routine. 
1. Users input planned mean differences (d), and group size (n)
2. For a specified number of simulated trials, the scripts simulate two samples of size n, from random normally distributed populations with means of 0 and d, and sd of 1. 
3. A Welch test is conducted between the groups in each simulated study, and the p-values are stored.
4. A histogram is generated of the p values obtained from the simulated studies

## Contents of this repository
This repository contains two versions of the power demonstration. 
1. A .R script 
2. A shiny app

### R script - power_demo.R
The R script is a less user friendly (for R novices) implementation, however it is more flexible than the shiny app including allowing for changes in the number of simulated trials, and provides additional outputs such as a saved record of all the trials, a summary of the simulations and a sample of reports. 

### Shiny app - ui.R and server.R
The shiny app is substantially more friendly to non-R users. It requires the installation of the shiny package. But then, if the ui.R and server.R scripts are in the same folder and are opened in RStudio, they can be started using the "run App" button above the script.
Simulations can be adjusted by movement of the sliders and use of the update button. A delay will follow as a function of the need to simulate. 


[1]: http://www.p-curve.com/
