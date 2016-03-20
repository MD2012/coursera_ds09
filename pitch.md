Nasdaq Returns 2012-16
========================================================
author: MD
date: 20.3.2016

Idea
========================================================
We would like to find out about the stock
price distribution of the NASDAQ index.
Hence **we** will conduct the following analysis:

- Get the data from finance.yahoo.com
- Clean & transform the price to return data (i.e. our dataset of interest)
- create a server.R shinyApp backend component to return data for specific time ranges
- cretae a UI.r shinyApp frontend component to let the user select time ranges of interest

to finally create an interactive histogram chart of the nasdaq index returns.

Get the data
========================================================

On finance.yahoo.com we find out, that the Nasdaq Composite Index (ticker symbol **IXIC**) historical prices can be downloaded.
Hence, we store the respective url (**ndq_data_url**)


```r
ndq_data_url = "http://real-chart.finance.yahoo.com/table.csv?s=%5EIXIC&d=2&e=20&f=2016&g=d&a=1&b=5&c=1971&ignore=.csv"
ndq_data = read.csv(ndq_data_url)
```

Clean & Transform Data
========================================================

![plot of chunk unnamed-chunk-2](pitch-figure/unnamed-chunk-2-1.png)

Server Side Program
========================================================

![plot of chunk unnamed-chunk-3](pitch-figure/unnamed-chunk-3-1.png)

Client Side Program
========================================================

![plot of chunk unnamed-chunk-4](pitch-figure/unnamed-chunk-4-1.png)
