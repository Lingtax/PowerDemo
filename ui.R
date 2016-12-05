library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Demonstration of Power"),
  
  # Sidebar with a slider input for the number of bins
  sidebarLayout(
    sidebarPanel(
      sliderInput("n",
                  "Participants per group:",
                  min = 1,
                  max = 100,
                  value = 10),
      sliderInput("d",
                  "Mean difference:",
                  min = 0,
                  max = 4,
                  step = 0.05,
                  value = 0),
      sliderInput("plotmax",
                  "Upper value in plot:",
                  min = .05,
                  max = 1,
                  value = 1),
      submitButton("Update plot")
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      plotOutput("distPlot")
    )
  )
))