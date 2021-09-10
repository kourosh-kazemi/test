library(shiny)
library(ggplot2)

shinyServer(function(session, input, output) {
    
    database      <- reactiveValues()
    tempDataCovid <- read.csv(file = "https://www.data.gouv.fr/fr/datasets/r/63352e38-d353-4b54-bfd1-f1b3ee1cabd7", sep = ";")
    
    observeEvent(input$launchGraph,{
        
        # Parametres
        departement <- input$depChoice
        sexe        <- input$sexeChoice
        dateDebut   <- input$datesRange[1]
        dateFin     <- input$datesRange[2]
        
        # Execution
        tempData                                       <- tempDataCovid[which(tempDataCovid$dep %in% departement & tempDataCovid$sexe == sexe),]
        tempData[,"jour2"]                             <- as.Date(as.character(tempData$jour), format = "%Y-%m-%d", origin = "1970-01-01")
        tempData[which(is.na(tempData$jour2)),"jour2"] <- as.Date(as.character(tempData$jour[which(is.na(tempData$jour2))]), format = "%d/%m/%Y", origin = "1970-01-01")
        tempData$jour                                  <- tempData$jour2
        tempData                                       <- tempData[,-which(colnames(tempData) == "jour2")]
        tempData                                       <- tempData[which(tempData$jour >= dateDebut & tempData$jour <= dateFin),]
        
        # stockage reactive Value
        database$tempData <- tempData
    })
    
    output$hospPlot <- renderPlot({
        # Graphique
        graph <- ggplot2::ggplot(data = database$tempData, aes(x = jour, y = hosp, color = dep)) +
            geom_line() +
            theme_minimal() +
            labs(x = "Date", y = "Nombre d'hospitalisation")
        
        graph

    })

})
