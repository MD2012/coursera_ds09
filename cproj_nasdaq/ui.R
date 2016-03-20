library(shiny)

# Define UI for application that draws a timeseries and histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Nasdaq Prices & Returns"),
  
  # Sidebar with a slider input for the number of bins
  sidebarLayout(
    sidebarPanel(
      sliderInput("bins",
                  "Number histogram bins",
                  min = 10,
                  max = 50,
                  value = 30)
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      plotOutput("histPlot")
    )
    
  )
))