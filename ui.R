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
                  max = 2,
                  step = 0.05,
                  value = 0),
      selectInput("crit",
                  "Critical value:",
                  c("p < .10" = .10,
                    "p < .05" = .05,
                    "p < .01" = .01,
                    "p < .001" = .001),
                   selected = .05),      
      sliderInput("plotmax",
                  "Upper value in plot:",
                  min = .05,
                  max = 1,
                  value = 1),
      submitButton("Update plot")
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      plotOutput("distPlot"),
      textOutput("text1")
    )
  )
))
