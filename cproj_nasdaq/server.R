# this app depends on shiny, xts and dygraphs
library(shiny)
library(xts)
library(dygraphs)

# here we define the url to fetch the csv data from
ndq_data_url = "http://real-chart.finance.yahoo.com/table.csv?s=%5EIXIC&d=2&e=20&f=2016&g=d&a=1&b=5&c=1971&ignore=.csv"

# here we use read.csv to pull data from provided http url into local table data format
ndq_data = read.csv(ndq_data_url)

# we filter for the 2 relevant columns of the dataset: Date and Close
ndq_data = ndq_data[ ,c('Date', 'Close')]

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  
  # prices data as xts timeseries objects
  # so we can use them in dygraphs
  ndq_xts = xts(ndq_data[,-1],order.by=as.POSIXct(ndq_data$Date))
  
  # return data is derived from price series
  # as simple difference of log price values
  ret<-diff(log(ndq_data$Close))

  # here we prepare the selection header label 
  # for the UI
  output$header <- renderText({ 
    paste("You selected: ", input$select)
  })
    
  # this creates the dygraph timeseries pricesPlot 
  # for the UI
  output$pricesPlot <- renderDygraph({
    dygraph(ndq_xts, main="Nasdaq Prices Timeseries")
  })
  
  # this creates the returns histgram
  # using blue bars and white border for the UI
  output$returnsPlot <- renderPlot({ 
    hist(ret, probability = TRUE, breaks = as.numeric(input$bins),
         xlab = "Log Return", main = "Nasdaq Log Return Distribution", 
         col = 'blue', border = 'white')
  })
      
})