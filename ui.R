
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
#
# http://shiny.rstudio.com
#

library(shiny)

shinyUI(fluidPage(

  # Application title
  titlePanel("Customer Analytics"),
  tags$style(HTML(".js-irs-0 .irs-single, .js-irs-0 .irs-bar-edge, .js-irs-0 .irs-bar {background: #76eec6}")),
  tags$style(HTML(".js-irs-1 .irs-single, .js-irs-1 .irs-bar-edge, .js-irs-1 .irs-bar {background: #76eec6}")),
  tags$style(".nav-tabs {
  background-color: #76eec6;
             }
             
             .nav-tabs-custom .nav-tabs li.active:hover a, .nav-tabs-custom .nav-tabs li.active a {
             background-color: transparent;
             border-color: transparent;
             }
             
             .nav-tabs-custom .nav-tabs li.active {
             border-top-color: #76eec6;
             }"),
  
  # Sidebar with a slider input for number of bins
  sidebarLayout(
    sidebarPanel(
      sliderInput("bins",
                  "Number of customers:",
                          min = 1,
                  max = 50,
                  value = 30),
      sliderInput("RATING",
                  "Most Recent overall rating:",
                  min = 1,
                  max = 5,
                  value = 4)
    ),
   
    mainPanel (
    tabsetPanel(position = "below",
                tabPanel("Repeated Customer",  plotOutput("distPlot")), 
                tabPanel("Best Feedbacks", plotOutput("distPlot1")), 
                tabPanel("Worst Feedbacks",  plotOutput("distPlot2")),
                tabPanel("Zones",  plotOutput("distPlot3")),
                tabPanel("Services Used",  plotOutput("distPlot4"))
                )
    )

    # Show a plot of the generated distribution
  
  ) 
))
