# this app depends on shiny and dygraphs on the UI
library(shiny)
library(dygraphs)

# Define UI for application that draws a timeseries and histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Nasdaq Prices & Returns"),
  
  # Sidebar with a slider input for the number of bins
  sidebarLayout(
    sidebarPanel(
      
      # we provide a select box 
      # so the user can switch between 'prices' and 'returns' type of analysis
      selectInput("select", label = "Display", 
                  choices = list("Nasdaq Prices" = "Nasdaq Prices", "Nasdaq Returns" = "Nasdaq Returns"), selected = 1),
      
      # using conditional panels
      # we either show the 'prices' Or 'returns' type of user ui selection choices
      conditionalPanel(
        condition = "input.select == 'Nasdaq Prices'"
      ),
      conditionalPanel(
        condition = "input.select == 'Nasdaq Returns'",
        
        sliderInput("bins",
                    "Number histogram bins",
                    min = 40,
                    max = 50,
                    value = 45)
      ),
      
      # should the user have selected 'Nasdaq Prices' we show some description for that analysis in this sidebarpanel
      conditionalPanel(
        condition = "input.select == 'Nasdaq Prices'",
        
        p("First we look at the NASDAQ Composite Index prices as obtained from finance.yahoo.com"),
        code("ndq_data_url = http://real-chart.finance.yahoo.com/table.csv
              ?s=%5EIXIC&d=2&e=20
              &f=2016&g=d&a=1&b=5&c=1971&ignore=.csv
              ndq_data = read.csv(ndq_data_url)"),
        br(),
        p("The chart we produce (conditionally if 'Nasdaq Prices' Select box option is selected) 
          is based on the dygraphs library")
        
      ),
      
      # should the user have selected 'Nasdaq Returns' we show some description for that analysis in this sidebarpanel
      conditionalPanel(
        condition = "input.select == 'Nasdaq Returns'",
        
        br(),
        p("Now that you selected 'Nasdaq Returns' we display the returns' distribution plot 
          of the returns of the loaded Nasdaq Price Timeseries as calculated in server.R."),
        br(),
        p("Using the Sliderbar above, we can interactively change the number of bins used in the histogram.")
      )
      
    ),
    
    # Mainpanel where we show either of 2 charts
    mainPanel(
      
      h4(textOutput("header")),
      
      # should the user have selected 'Nasdaq Prices' we show the dygraph timeseries chart
      conditionalPanel(
        condition = "input.select == 'Nasdaq Prices'",
          dygraphOutput("pricesPlot")
      ),
      
      # should the user have selected 'Nasdaq Returns' we show the histogram of the log price returns
      conditionalPanel(
        condition = "input.select == 'Nasdaq Returns'",
        plotOutput("returnsPlot")
      )
      
    )
    
  )
))