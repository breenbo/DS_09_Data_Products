# tuto : https://www.r-bloggers.com/building-shiny-apps-an-interactive-tutorial/ 

require(shiny)
require(ggplot2)

shinyServer(function(input,output) { # function which do something to be printed
                # ------------------------------------------------------------ 
                # side Panel
                # ------------------------------------------------------------ 
                # get and order names of dataset to populate X and Y menus
                name <- reactive({
                    names(data.frame(get(input$dataset)))[order(names(data.frame(get(input$dataset))))]
                })
                # menu to upload .csv file
                output$csv <- renderUI({
                    if(input$dataset=="csv_file"){
                        fileInput("csvFile", "Choose a csv file", accept=".csv")
                    }
                })
                # get name of .csv file to populate scatterplot title
                namesCSV <- reactive({
                    inFile <- input$csvFile
                    if(is.null(inFile)){
                        return(NULL)
                    }
                    names(read.csv(inFile$datapath))
                }) 
                # get the data of the uploaded file
                dataCSV <- reactive({
                    inFile <- input$csvFile
                    if(is.null(inFile)){
                        return(NULL)
                    }
                    read.csv(inFile$datapath)
                }) 
                # create and populate X menu with variables names
                # depending of csv or R dataset
                output$xvar <- renderUI({
                    if(input$dataset=="csv_file" && is.null(input$csvFile)){
                        return()
                    } else if(input$dataset=="csv_file"){
                        radioButtons("xVar", "Choose X var", namesCSV())
                    } else if(input$dataset!="csv_file"){
                        radioButtons("xVar", "Choose X var", name())
                    }
                })
                # create and populate Y menu with variables names
                # depending of csv or R dataset
                output$yvar <- renderUI({
                    if(input$dataset=="csv_file" && is.null(input$csvFile)){
                        return()
                    } else if(input$dataset=="csv_file"){
                        radioButtons("yVar", "Choose Y var", namesCSV())
                    } else if(input$dataset!="csv_file"){
                        radioButtons("yVar", "Choose Y var", name())
                    }
                })
                # ------------------------------------------------------------ 
                # main panel
                # ------------------------------------------------------------ 
                # scatterplot tab
                # ------------------------------------------------------------ 
                # set scatterplot title with .csv name or dataset name
                output$title <- renderUI({
                    if(input$dataset=="csv_file"){
                        h2(input$csvFile["name"])
                    } else {
                        h2(input$dataset)
                    }
                })
                # set variables names studyed in Scatterplot
                output$subtitle <- renderUI({
                    h3(paste(input$yVar, "vs", input$xVar))
                })
                # plot scatterplot
                output$coolPlot <- renderPlot({
                    if(is.null(input$dataset)){
                        return()
                    } else if(input$dataset=="csv_file" && is.null(input$csvFile)){
                        return()
                    } else if(input$dataset=="csv_file"){
                        ggplot(dataCSV(), aes(get(input$xVar),get(input$yVar))) + geom_jitter() + xlab(input$xVar) + ylab(input$yVar)
                    } else {
                        ggplot(data.frame(get(input$dataset)), aes(get(input$xVar),get(input$yVar))) + geom_jitter() + xlab(input$xVar) + ylab(input$yVar)
                    }
                })
                # ------------------------------------------------------------ 
                # Distribution tab
                # ------------------------------------------------------------ 
                # subtitle for X
                output$distSubTitleX <- renderUI({
                    h3(input$xVar)
                })
                # plot histogram for X
                output$distTitle <- renderUI({
                    if(input$dataset=="csv_file"){
                        h2(input$csvFile["name"])
                    } else {
                        h2(input$dataset)
                    }
                })
                output$histPlotX <- renderPlot({
                    if(is.null(input$dataset)){
                        return()
                    } else if(input$dataset=="csv_file" && is.null(input$csvFile)){
                        return()
                    } else if(input$dataset=="csv_file"){
                        ggplot(dataCSV(), aes(get(input$xVar))) + geom_histogram(fill="green", color="black", bins=50) + xlab(input$xVar) + ylab("count")
                    } else {
                        ggplot(data.frame(get(input$dataset)), aes(get(input$xVar))) + geom_histogram(fill="green", color="black", bins=50) + xlab(input$xVar) + ylab("count")
                    }
                })
                # print boxplot of X
                output$sumHistX <- renderPlot({
                    if(input$dataset=="csv_file"){
                        ggplot(dataCSV(), aes(x=input$xVar,y=get(input$xVar))) + geom_boxplot(fill="green", color="black") + xlab(input$xVar) + ylab("")
                    } else {
                        ggplot(data.frame(get(input$dataset)), aes(x=input$xVar,y=get(input$xVar))) + geom_boxplot(fill="green", color="black") + xlab(input$xVar) + ylab("")
                    }
                })
                # subtitle for Y
                output$distSubTitleY <- renderUI({
                    h3(input$yVar)
                })
                # plot histogram for Y
                output$histPlotY <- renderPlot({
                    if(is.null(input$dataset)){
                        return()
                    } else if(input$dataset=="csv_file" && is.null(input$csvFile)){
                        return()
                    } else if(input$dataset=="csv_file"){
                        ggplot(dataCSV(), aes(get(input$yVar))) + geom_histogram(fill="blue", color="black", bins=50) + xlab(input$yVar) + ylab("count")
                    } else {
                        ggplot(data.frame(get(input$dataset)), aes(get(input$yVar))) + geom_histogram(fill="blue", color="black", bins=50) + xlab(input$yVar) + ylab("count")
                    }
                })
                # print boxplot of Y
                output$sumHistY <- renderPlot({
                    if(input$dataset=="csv_file"){
                        ggplot(dataCSV(), aes(x=input$yVar,y=get(input$yVar))) + geom_boxplot(fill="blue", color="black") + xlab(input$yVar) + ylab("")
                    } else {
                        ggplot(data.frame(get(input$dataset)), aes(x=input$yVar,y=get(input$yVar))) + geom_boxplot(fill="blue", color="black") + xlab(input$yVar) + ylab("")
                    }
                })
                # ------------------------------------------------------------ 
                # NA tab
                # ------------------------------------------------------------ 
                # ------------------------------------------------------------ 
                # correlation tab
                # ------------------------------------------------------------ 
                # ------------------------------------------------------------ 
                # summary tab
                # ------------------------------------------------------------ 
                # print head of dataset
                output$sumTitle <- renderUI({
                    if(input$dataset=="csv_file"){
                        h2(input$csvFile["name"])
                    } else {
                        h2(input$dataset)
                    }
                })
                output$head <- renderDataTable({
                    if(input$dataset=="csv_file"){
                        head(dataCSV())
                    } else {
                        head(get(input$dataset))
                    }
                })
                # print tail of dataset
                output$tail <- renderDataTable({
                    if(input$dataset=="csv_file"){
                        tail(dataCSV())
                    } else {
                        tail(get(input$dataset))
                    }
                })
                # print summary of all variables
                # output$sum <- renderPrint({
                output$sum <- renderDataTable({
                    if(input$dataset=="csv_file"){
                        summary(dataCSV())
                    } else {
                        summary(get(input$dataset))
                    }
                })
                # ------------------------------------------------------------ 
                # structure tab
                # ------------------------------------------------------------ 
                # print structure of the dataset
                output$strTitle <- renderUI({
                    if(input$dataset=="csv_file"){
                        h2(input$csvFile["name"])
                    } else {
                        h2(input$dataset)
                    }
                })
                output$dataStr <- shiny::renderDataTable({
                    if(input$dataset=="csv_file"){
                        dataStructure <- capture.output(str(dataCSV()))
                        data.frame(dataStructure)
                    } else {
                    dataStructure <- capture.output(str(get(input$dataset)))
                    data.frame(dataStructure)
                    }
                })
})
