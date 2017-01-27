# tuto : https://www.r-bloggers.com/building-shiny-apps-an-interactive-tutorial/ 

# run application with runApp() command in R console
# the files must be in the working dir
require(shiny)

shinyUI(fluidPage(# describe type of page
              titlePanel("Exploratory Machine"),
              sidebarLayout( # page with sidebar for navigation, etc.
                        sidebarPanel(
                                     # dropdown selection menu of the dataset
                                     selectInput("dataset", "Choose a dataset", c("mtcars", "state.x77", "iris", "InsectSprays", "csv_file")),
                                     # menu to upload .csv file, appears only if csv selected
                                     uiOutput("csv"),
                                     # display X and Y on the same line
                                     # X and Y are automaticaly populated when changing the dataset
                                     fluidRow(
                                              column(6,uiOutput("yvar")),
                                              column(6,uiOutput("xvar"))
                                     )
                        ),
                        mainPanel(
                                  tabsetPanel(
                                              tabPanel("Users Manual",
                                                       h3("Welcome to the Exploratory Machine"),
                                                       tags$hr(),
                                                       p("Here you can : "),
                                                       tags$ol(
                                                               tags$li("In the side panel :",
                                                                       tags$ol(
                                                                               tags$ul("- choose a R dataset or upload a .csv file to study"),
                                                                               tags$ul("- choose 2 variables to be ploted")
                                                                               )
                                                                       ),
                                                               tags$li("In the main panel :",
                                                                       tags$ol(
                                                                               tags$ul("- view a scatterplot of the 2 choosen varaibles in the tab 'Scatterplot'"),
                                                                               tags$ul("- view the distribution (histograms and boxplots) of this variables in tab 'Histograms'"),
                                                                               tags$ul("- view a summary of all variables in tab 'Summary'"),
                                                                               tags$ul("- view the structure of the dataset in tab 'Dataset Structure'")
                                                                               )
                                                                       )
                                                               ),
                                                       p("All plots are reactive, and it might be little waiting time for calculation, especially with .csv files."),
                                                       p("It might be some fugitive error messages, but they have no consequences"),
                                                       tags$hr(),
                                                       h4("So you'll have a useful quick overview of the dataset you're studying.")
                                                       ),
                                              tabPanel("Scatterplot",
                                                       # change title and subtitle depending of the variables
                                                      uiOutput("title"),
                                                      uiOutput("subtitle"),
                                                      # plot the scatterplot
                                                      plotOutput("coolPlot")
                                              ),
                                              tabPanel("Histograms",
                                                      h3("Histograms"),
                                                      # plot histo and boxplot on the same line
                                                      fluidRow(
                                                               column(9, plotOutput("histPlotX")),
                                                               column(3, plotOutput("sumHistX"))
                                                       ),
                                                      # plot histo and boxplot on the same line
                                                      fluidRow(
                                                               column(9, plotOutput("histPlotY")),
                                                               column(3, plotOutput("sumHistY"))
                                                       )
                                              ),
                                              tabPanel("Summary", 
                                                      verbatimTextOutput("sum") 
                                                       ),
                                              tabPanel("Dataset Structure",
                                                      shiny::dataTableOutput("dataStr")
                                              )
                                  )
                        )
              )
      )
)
