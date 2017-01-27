# tuto : https://www.r-bloggers.com/building-shiny-apps-an-interactive-tutorial/ 

# run application with runApp() command in R console
# the files must be in the working dir
library(shiny)

shinyUI(fluidPage(# describe type of page
              titlePanel("Plot Machine"),
              sidebarLayout( # page with sidebar for navigation, etc.
                        sidebarPanel(
                                     selectInput("dataset", "Choose a dataset", c("mtcars", "state.x77", "iris", "InsectSprays", "csv_file")),
                                     # selectInput("plotVar", "Choose type of plot", c("scatterplot", "histogram")),
                                     uiOutput("csv"),
                                     fluidRow(
                                              column(6,uiOutput("yvar")),
                                              column(6,uiOutput("xvar"))
                                              )
                                     ),
                        mainPanel(
                                  uiOutput("title"),
                                  h3("Scatterplot"),
                                  plotOutput("coolPlot"),
                                  h3("Histograms"),
                                  plotOutput("coolPlot2")
                                  )
                        )
                  ))
