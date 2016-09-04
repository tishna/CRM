
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)
require(data.table)
library(maps)
library(mapproj)
library(geosphere)
library(ggmap)
library(plyr)

shinyServer(function(input, output) {

  output$distplot5 <- renderPlot(
    {visited <- c("SFO", "Chennai", "Europe", "Melbourne", "Johannesbury, SA")
    ll.visited <- geocode(visited)
    visit.x <- ll.visited$lon
    visit.y <- ll.visited$lat
      #map("world", proj="albers", param=c(39,45), col="cadetblue4", fill=TRUE, bg="aquamarine3", lwd=0.8)
      map("world", fill=TRUE, col="aquamarine3", bg="white", ylim=c(-60, 90), mar=c(0,0,0,0))
      points(visit.x,visit.y, col="red", pch=16)
      
      
      })

  
  output$distPlot4<- renderPlot({
    x    <- faithful[, 2]
    bins <- seq(min(x), max(x), length.out = input$bins + 1)
    
    data <- read.csv("CUST_VISITS.csv",nrows=input$bins)
    slices <- c(sum(data$SERVICE == "SPA"), sum(data$SERVICE == "POOL"),
                sum(data$SERVICE == "GYM"), sum(data$SERVICE == "SAUNA"),
                sum(data$SERVICE == "SALON")
                
                ) 
    lbls <- c("SPA", "POOL", "GYM", "SAUNA","SALON")
    pct <- round(slices/sum(slices)*100)
    lbls <- paste(lbls, pct) # add percents to labels 
    lbls <- paste(lbls,"%",sep="") # ad % to labels 
    colors <- c("aquamarine3","coral","cadetblue4","coral3","darkgoldenrod3")
    pie(slices,labels = lbls, col=colors,main=" SERVICES USED :")
    
  })
  
  
  output$distPlot2 <- renderPlot({
    x    <- faithful[, 2]
    bins <- seq(min(x), max(x), length.out = input$bins + 1)
    
    data <- read.csv("CUST_VISITS.csv",nrows=input$bins)
    slices <- c(sum(data$WORST_IN == "SERVICE"), sum(data$WORST_IN == "COMFORT"),
                sum(data$WORST_IN == "AMBIENCE"), sum(data$WORST_IN == "HYGIENE")) 
    lbls <- c("SERVICE", "COMFORT", "AMBIENCE", "HYGIENE")
    pct <- round(slices/sum(slices)*100)
    lbls <- paste(lbls, pct) # add percents to labels 
    lbls <- paste(lbls,"%",sep="") # ad % to labels 
    colors <- c("aquamarine3","cadetblue4","coral3","darkgoldenrod3")
    pie(slices,labels = lbls, col=colors,main="Worst Feedbacks :")
    
  })
  
  
  output$distPlot1 <- renderPlot({
    x    <- faithful[, 2]
    bins <- seq(min(x), max(x), length.out = input$bins + 1)
    
    data <- read.csv("CUST_VISITS.csv",nrows=input$bins)
    
    slices <- c(sum(data$BEST_IN == "SERVICE"), sum(data$BEST_IN == "COMFORT"),
                sum(data$BEST_IN == "AMBIENCE"), sum(data$BEST_IN == "HYGIENE")) 
    lbls <- c("SERVICE", "COMFORT", "AMBIENCE", "HYGIENE")
    pct <- round(slices/sum(slices)*100)
    lbls <- paste(lbls, pct) # add percents to labels 
    lbls <- paste(lbls,"%",sep="") # ad % to labels 
    colors <- c("aquamarine3","cadetblue4","coral3","darkgoldenrod3")
    pie(slices,labels = lbls, col=colors,main="Best Feedbacks :")
    
  })
  
  output$distPlot3 <- renderPlot({
    x    <- faithful[, 2]
    bins <- seq(min(x), max(x), length.out = input$bins + 1)
    
    data <- read.csv("CUST_VISITS.csv",nrows=input$bins)
    
    slices <- c(sum(data$ZONE == "A"), sum(data$ZONE == "B"),
                sum(data$ZONE == "C"), sum(data$ZONE == "D")) 
    lbls <- c("A", "B", "C", "D")
    pct <- round(slices/sum(slices)*100)
    lbls <- paste(lbls, pct) # add percents to labels 
    lbls <- paste(lbls,"%",sep="") # ad % to labels 
    colors <- c("aquamarine3","cadetblue4","coral3","darkgoldenrod3")
    pie(slices,labels = lbls, col=colors,main="ZONE :")
    
  })
  
  output$distPlot <- renderPlot({

    # generate bins based on input$bins from ui.R
    x    <- faithful[, 2]
    bins <- seq(min(x), max(x), length.out = input$bins + 1)
    
    data <- read.csv("CUST_VISITS.csv",nrows=input$bins)
    #data <- subset(data,nrows=input$bins)
    #barplot(data$CUST,data$VISITS)
    
  
    
  
   
    
    
    data <- read.csv("CUST_VISITS.csv",nrows=input$bins)
    data <- subset(data,RATING>=input$RATING)
    
    
    barplot(data$VISITS, main="Recurring Customer", 
            xlab="Customers", ylab="Customer Visits", names.arg=data$CUST,
            border="black", col="aquamarine3")
    
    #impordata <- read.csv("skiplines.csv")
    #impordata <- subset(impordata,year>=1985)
    
    
    # draw the histogram with the specified number of bins
    #hist(x, breaks = bins, col = 'darkgray', border = 'white')

  })

})
