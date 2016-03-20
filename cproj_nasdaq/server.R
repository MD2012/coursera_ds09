library(shiny)
library(xts)
library(dygraphs)

ndq_data_url = "http://real-chart.finance.yahoo.com/table.csv?s=%5EIXIC&d=2&e=20&f=2016&g=d&a=1&b=5&c=1971&ignore=.csv"
ndq_data = read.csv(ndq_data_url)
ndq_data = ndq_data[ ,c('Date', 'Close')]
head(ndq_data)
ndq_xts = xts(ndq_data[,-1],order.by=as.POSIXct(ndq_data$Date))

ret<-diff(log(ndq_data$Close))

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  
 
  # Expression that generates a histogram. The expression is
  # wrapped in a call to renderPlot to indicate that:
  #
  #  1) It is "reactive" and therefore should re-execute automatically
  #     when inputs change
  #  2) Its output type is a plot
  

  output$header <- renderText({ 
    paste("You selected: ", input$select)
  })
    
  output$pricesPlot <- renderPlot({ 
    dygraph(ndq_xts)
  })
  output$pricesPlot <- renderDygraph({
    dygraph(ndq_xts, main="Nasdaq Prices Timeseries")
  })
  
  output$returnsPlot <- renderPlot({ 
    hist(ret, probability = TRUE, breaks = as.numeric(input$bins),
         xlab = "Log Return", main = "Nasdaq Log Return Distribution", 
         col = 'blue', border = 'white')
  })
      
})