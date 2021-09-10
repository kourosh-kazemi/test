library(shiny)

shinyUI(fluidPage(

    shiny::tagList(tags$head(tags$link(rel = "stylesheet", type = "text/css", href = "esaShinyApp.css"))),
    
    shiny::tags$div(
        class = "titleBand",
        p(id = "title", "Application Shiny Master ESA Jenny")    
    ),
    fluidRow(
        column(3, shiny::tags$div(class = "titleBand", list(selectizeInput("depChoice", "Département", choices = c(1:95), selected = 45, multiple = T),
                                                            selectInput("sexeChoice", "Sexe", choices = c("Tous" = 0, "Femme" = 1, "Homme" = 2), selected = 0),
                                                            dateRangeInput("datesRange", "Dates", start = "2020-03-18", end = Sys.Date()-1, min = "2020-03-18", max = Sys.Date()-1, format = "dd/mm/yyyy", language = "fr"),
                                                            hr(),
                                                            actionButton("launchGraph", "Lancer !")))),
        column(9, shiny::tags$div(plotOutput("hospPlot")))
    )
))
