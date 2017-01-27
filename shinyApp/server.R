# tuto : https://www.r-bloggers.com/building-shiny-apps-an-interactive-tutorial/ 

library(shiny)
library(ggplot2)

shinyServer(function(input,output) { # function which do something to be printed
                name <- reactive({
                    names(data.frame(get(input$dataset)))[order(names(data.frame(get(input$dataset))))]
                })
                # output$colNames <- renderPrint({
                    # name()
                # })
                output$csv <- renderUI({
                    if(input$dataset=="csv_file"){
                        fileInput("csvFile", "Choose a csv file", accept=".csv")
                    }
                })
                namesCSV <- reactive({
                    inFile <- input$csvFile
                    if(is.null(inFile)){
                        return(NULL)
                    }
                    names(read.csv(inFile$datapath))
                }) 
                dataCSV <- reactive({
                    inFile <- input$csvFile
                    if(is.null(inFile)){
                        return(NULL)
                    }
                    read.csv(inFile$datapath)
                }) 
                output$xvar <- renderUI({
                    if(input$dataset=="csv_file" && is.null(input$csvFile)){
                        return()
                    } else if(input$dataset=="csv_file"){
                        radioButtons("xVar", "Choose X var", namesCSV())
                    } else if(input$dataset!="csv_file"){
                        radioButtons("xVar", "Choose X var", name())
                    }
                })
                output$yvar <- renderUI({
                    if(input$dataset=="csv_file" && is.null(input$csvFile)){
                        return()
                    } else if(input$dataset=="csv_file"){
                        radioButtons("yVar", "Choose Y var", namesCSV())
                    } else if(input$dataset!="csv_file"){
                        radioButtons("yVar", "Choose Y var", name())
                    }
                })
                output$title <- renderUI({
                    h2(input$dataset)
                })
                output$coolPlot <- renderPlot({
                    if(is.null(input$dataset)){
                        return()
                    } else if(input$dataset=="csv_file" && is.null(input$csvFile)){
                        return()
                    } else if(input$dataset=="csv_file"){
                        ggplot(dataCSV(), aes(get(input$xVar),get(input$yVar))) + geom_jitter() + xlab(input$xVar) + ylab(input$yVar)
                        # attach(dataCSV())
                            # par(fig=c(0,0.8,0,0.87))
                                # plot(get(input$xVar), get(input$yVar), xlab=input$xVar, ylab=input$yVar, pch=16)
                            # par(fig=c(0,0.8,0.53,1), new=T)
                                # boxplot(get(input$xVar), horizontal=T, axes=F, col="green")
                            # par(fig=c(0.7,0.87,0,0.85), new=T)
                                # boxplot(get(input$yVar), axes=F, col="blue")
                        # detach(dataCSV())
                    } else if(input$dataset!="csv_file"){
                        ggplot(data.frame(get(input$dataset)), aes(get(input$xVar),get(input$yVar))) + geom_jitter() + xlab(input$xVar) + ylab(input$yVar)
                        # attach(data.frame(get(input$dataset)))
                            # par(fig=c(0,0.8,0,0.87))
                                # plot(get(input$xVar), get(input$yVar), xlab=input$xVar, ylab=input$yVar, pch=16)
                            # par(fig=c(0,0.8,0.53,1), new=T)
                                # boxplot(get(input$xVar), horizontal=T, axes=F, col="green")
                            # par(fig=c(0.7,0.87,0,0.85), new=T)
                                # boxplot(get(input$yVar), axes=F, col="blue")
                        # detach(data.frame(get(input$dataset)))
                    }
                    # if(input$plotVar=="scatterplot"){
                        # ggplot(data.frame(get(input$dataset)), aes(get(input$xVar),get(input$yVar))) + geom_jitter() + xlab(input$xVar) + ylab(input$yVar)
                    # } else if(input$plotVar=="histogram"){
                        # ggplot(data.frame(get(input$dataset)), aes(get(input$xVar))) + geom_histogram() + xlab(input$xVar) + ylab("count")
                    # } 
                })
                output$coolPlot2 <- renderPlot({
                    if(is.null(input$dataset)){
                        return()
                    } else if(input$dataset=="csv_file" && is.null(input$csvFile)){
                        return()
                    }
                    ggplot(data.frame(get(input$dataset)), aes(get(input$xVar))) + geom_histogram() + xlab(input$xVar) + ylab("count")
                    # attach(data.frame(get(input$dataset)))
                        # par(mfrow=c(1,2))
                            # hist(get(input$xVar), main="", xlab=input$xVar, breaks=20, col="green")
                            # hist(get(input$yVar), main="", xlab=input$yVar, breaks=20, col="blue")
                    # detach(data.frame(get(input$dataset)))
                })
})
