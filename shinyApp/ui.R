# tuto : https://www.r-bloggers.com/building-shiny-apps-an-interactive-tutorial/ 

# run application with runApp() command in R console
# the files must be in the working dir
require(shiny)

shinyUI(fluidPage(# describe type of page
                  headerPanel(HTML("<b>Exploratory Machine</b>
                        <i><h3>Change your mind on R</h3></i>
                        "), windowTitle="Exploratory Machine"),
                  tags$head(tags$style(HTML("
                                       body{
                                           background-color:hsl(0,0%,98%);
                                       
                                       }
                                       h1{
                                           padding:10px 0 0px 10px;
                                           margin:10px -15px 0 -15px;
                                           background-color:hsl(280,100%,75%);
                                           border-radius:5px;
                                           box-shadow: 4px 4px 3px 0px rgba(0, 0, 0, 0.2), 4px 4px 3px 0px rgba(0, 0, 0, 0.19);
                                       }
                                       h2{
                                           background-color:hsl(280,50%,83%);
                                           padding:10px 0 10px 10px;
                                           margin-top:0px;
                                           border-radius:5px;
                                           box-shadow: 4px 4px 3px 0px rgba(0, 0, 0, 0.2), 4px 4px 3px 0px rgba(0, 0, 0, 0.19);
                                       }
                                       h3{
                                           background-color:hsl(280,50%,90%);
                                           margin-top:5px;
                                           padding:10px 0 10px 10px;
                                           border-radius:5px;
                                           box-shadow: 2px 2px 1px 0px rgba(0, 0, 0, 0.2), 2px 2px 1px 0px rgba(0, 0, 0, 0.19);
                                       }
                                       .logo{
                                           float:right;
                                           width:3vw;
                                           margin-right:10px;
                                           margin-top:-10px;
                                       }
                                       footer{
                                           background-color:hsl(280,50%,95%);
                                           padding:15px 0 15px 10px;
                                           margin-top:10px;
                                           border-radius:5px;
                                           box-shadow: 1px 1px 1px 0px rgba(0, 0, 0, 0.2), 1px 1px 1px 0px rgba(0, 0, 0, 0.19);
                                       }
                                       ")
                              )
                  ),
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
                                                                               tags$ul("- view the distribution (histograms and boxplots) of this variables in tab 'Distributions'"),
                                                                               tags$ul("- view the head, tail and a summary of all variables in tab 'Summary'"),
                                                                               tags$ul("- view the structure (str() function) of the dataset in tab 'Dataset Structure'")
                                                                               )
                                                                       )
                                                               ),
                                                       p("All plots are reactive, and it might be little waiting time for calculation, especially with .csv files."),
                                                       p("It might be some fugitive error messages, but they have no consequences"),
                                                       h4("So you'll have a useful quick overview of the dataset you're studying.")
                                                       ),
                                              tabPanel("Scatterplot",
                                                       # change title and subtitle depending of the variables
                                                      uiOutput("title"),
                                                      uiOutput("subtitle"),
                                                      # plot the scatterplot
                                                      plotOutput("coolPlot")
                                              ),
                                              tabPanel("Distributions",
                                                       uiOutput("distTitle"),
                                                      # plot histo and boxplot on the same line
                                                       uiOutput("distSubTitleX"),
                                                      fluidRow(
                                                               column(9, plotOutput("histPlotX")),
                                                               column(3, plotOutput("sumHistX"))
                                                       ),
                                                      # plot histo and boxplot on the same line
                                                       uiOutput("distSubTitleY"),
                                                      fluidRow(
                                                               column(9, plotOutput("histPlotY")),
                                                               column(3, plotOutput("sumHistY"))
                                                       )
                                              ),
                                              tabPanel("Summary", 
                                                       uiOutput("sumTitle"),
                                                       h3("Head"),
                                                       dataTableOutput("head"),
                                                       h3("Tail"),
                                                       dataTableOutput("tail"),
                                                       h3("Summary"),
                                                       # verbatimTextOutput("sum") 
                                                       dataTableOutput("sum")
                                               ),
                                              tabPanel("Dataset Structure",
                                                       uiOutput("strTitle"),
                                                       shiny::dataTableOutput("dataStr")
                                              )
                                  )
                        )
              ),
              tags$footer(HTML("
                               <a href='https://bitbucket.org/breenbo' target='_blank'><img class='logo' src='bitbucket.svg' alt='bitbucket logo'></a>
                               <a href='https://github.com/breenbo' target='_blank'><img class='logo' src='github.svg' alt='github logo'></a>
                               <a href='https://fr.linkedin.com/in/brunoberrehuel' target='_blank'><img class='logo' src='in.svg' alt='linkedin logo'></a>
                               Designed and coded by <em>Bruno BERREHUEL</em>.
                               "
                               )
              )
      )
)
