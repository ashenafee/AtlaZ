# Ensure Shiny is installed
if (!require(shiny)) {
    install.packages("shiny")
}
if (!require(plotly)) {
    install.packages("plotly")
}

library(shiny)

# Define the stages
stages <- c(
    "blastula 128-cell",
    "blastula 1k-cell",
    "blastula dome",
    "cleavage 2-cell",
    "gastrula 50%-epiboly",
    "gastrula 75%-epiboly",
    "gastrula shield",
    "hatching long-pec",
    "larval day 4",
    "larval day 5",
    "larval protruding mouth",
    "pharyngula prim-15",
    "pharyngula prim-25",
    "pharyngula prim-5",
    "segmentation 1-4 somites",
    "segmentation 14-19 somites",
    "segmentation 20-25 somites",
    "zygote"
)

selectedStages <- reactive(stages)

ui <- fluidPage(
    titlePanel("Gene Expression Analysis"),
    sidebarLayout(
        sidebarPanel(
            fileInput("fileUpload", "Upload Data File"),
            actionButton("loadData", "Load Default Data"),

            # Display the path of the current data file
            textOutput("dataFilePath"),

            # Conditional UI elements that are enabled only after data is loaded
            uiOutput("conditionalInputs")
        ),
        mainPanel(
            plotly::plotlyOutput("expressionPlot"),
            verbatimTextOutput("selectedInfo"),
            conditionalPanel(
                condition = "output.pointSelected",
                div(
                    style = "display: flex; height: 100%;",
                    fluidRow(
                        div(
                            style = "
                                height: 200px;
                                overflow-y: scroll;
                            ",
                            h3("Selected Point Information"),
                            uiOutput("selectedGeneInfo"),
                            uiOutput("selectedStageInfo"),
                            uiOutput("selectedExpressionInfo")
                        ),
                        div(
                            style = "
                                height: 200px;
                                overflow-y: scroll;
                            ",
                            h3("Anatomy Information"),
                            uiOutput("anatomyInfo")
                        ),
                        div(
                            style = "
                                height: 200px;
                                overflow-y: scroll;
                            ",
                            h3("Ontology Information"),
                            uiOutput("ontologyInfo")
                        )
                    )
                )
            ),
        )
    )
)

#' Extract Selected Data from Plotly Object
#'
#' This function extracts selected data from a Plotly object. It first converts
#' the Plotly object to JSON, then extracts the data and filters it to remove
#' duplicae entries. It matches the x and y values of the point that was clicked
#' to the x and y values in the data. This data is then processed and returned
#' as a dataframe with columns for Stage, Expression, and Gene.
#'
#' @param plotlyObject A function that returns a Plotly object.
#' @param eventData A list containing x and y values to match in the data.
#' @return A dataframe containing the selected data, with columns for Stage,
#' Expression, and Gene.
#' @importFrom jsonlite fromJSON
#' @importFrom dplyr rename
#' @export
extractPlotlyData <- function(plotlyObject, eventData) {
    # Get the plotly object in JSON string format
    plotlyJson <- plotly_json(plotlyObject(), FALSE)

    # Convert the JSON string to a list
    plotlyJson <- jsonlite::fromJSON(plotlyJson)

    # Get the data from the JSON object
    plotlyData <- plotlyJson$data

    # Keep only the entries that are mode = "markers"
    plotlyData <- plotlyData[plotlyData$mode == "markers", ]

    # Create a new list of dataframes in the following format:
    plotlyData <- lapply(seq_along(plotlyData$x), function(i) {
        data.frame(
            x = plotlyData$x[[i]],
            y = plotlyData$y[[i]],
            text = plotlyData$text[[i]]
        )
    })

    # Find if there is any sub-dataframes in plotlyData with the same x and y
    # values as the eventData
    selectedData <- lapply(plotlyData, function(df) {
        df[df$x == eventData$x & df$y == eventData$y, ]
    })

    # Remove any dataframes in selectedData that are empty
    selectedData <- selectedData[sapply(selectedData, nrow) > 0]

    # Get the text from the data
    plotlyText <- selectedData[[1]]$text

    # Separate the text into a dataframe
    plotlyText <- strsplit(plotlyText, "<br />", fixed = TRUE)

    # Convert the text into a dataframe
    plotlyText <- data.frame(
        do.call(rbind, plotlyText),
        stringsAsFactors = FALSE
    )

    # Remove the DevelopmentalStage: , ExpressionValue: , and GeneName: prefixes
    plotlyText <- lapply(plotlyText, function(x) {
        gsub("DevelopmentalStage: |ExpressionValue: |GeneName: ", "", x)
    })

    # Turn plotlyText into a dataframe with the following format
    # Developmental Stage | Expression Value | Gene Name
    plotlyText <- data.frame(
        do.call(rbind, plotlyText),
        stringsAsFactors = FALSE
    )
    plotlyText <- as.data.frame(t(plotlyText))
    plotlyText <- plotlyText %>%
        # Rename the columns for clarity
        rename(Stage = X1, Expression = X2, Gene = X3)
    # Remove the row names
    rownames(plotlyText) <- NULL

    return(plotlyText)
}

# Define server logic
server <- function(input, output) {
    plotlyObject <- reactiveVal()

    pointSelected <- reactiveVal(FALSE)
    output$pointSelected <- reactive({
        pointSelected()
    })

    geneInfo <- reactiveVal(NULL)
    output$geneInfo <- reactive({
        geneInfo()
    })

    # Placeholder reactive value for data
    data <- reactiveVal(NULL)
    longData <- reactiveVal(NULL)
    dataFilePath <- reactiveVal("No data loaded")

    # Update text output for the data file path
    output$dataFilePath <- renderText({
        dataFilePath()
    })

    # Observe event for loading default data
    observeEvent(input$loadData, {
        dataFilePath(
            "Default data loaded from ../extdata/ERAD_query_results.tsv"
        )
        # Load default data
        data(readr::read_tsv(
            "../extdata/ERAD_query_results.tsv",
            skip = 4,
            show_col_types = FALSE
        ))
    })

    # Observe event for file upload
    observeEvent(input$fileUpload, {
        req(input$fileUpload)
        dataFilePath(paste("Data uploaded:", input$fileUpload$name))
        # Load uploaded data
        # if tsv use read_tsv, if csv use read_csv
        if (grepl(".tsv$", input$fileUpload$name)) {
            data(readr::read_tsv(
                input$fileUpload$datapath,
                show_col_types = FALSE
            ))
        } else if (grepl(".csv$", input$fileUpload$name)) {
            data(readr::read_csv(
                input$fileUpload$datapath,
                show_col_types = FALSE
            ))
        }
    })

    # Render conditional UI elements based on whether data is loaded
    output$conditionalInputs <- renderUI({
        if (!is.null(data())) {
            list(
                checkboxInput("useLog", "Use Log Scale", value = FALSE),
                textAreaInput("geneInput", "Enter Gene Names:",
                    placeholder =
                        "Enter comma-separated gene names (e.g., rho, trpv1)"
                ),
                selectInput("stageSelect", "Select Developmental Stages:",
                    choices = stages, multiple = TRUE
                ),
                actionButton("analyzeBtn", "Analyze")
            )
        } else {
            # Return NULL or an informative message if data is not loaded yet
            h5("Please load data to enable analysis options.")
        }
    })

    # Observe event for the Analyze button
    observeEvent(input$analyzeBtn, {
        # Parse the input gene names
        geneNames <- unlist(strsplit(input$geneInput, ",", fixed = TRUE))
        geneNames <- sapply(geneNames, trimws)

        # Check for single gene or multiple genes
        if (length(geneNames) == 1) {
            output$expressionPlot <- plotly::renderPlotly({
                p <- plotGeneExpression(
                    data(),
                    geneNames[1],
                    input$stageSelect,
                    input$useLog
                )
                longData <- p$longData
                plt <- p$plot
                plt <- plotly::ggplotly(
                    plt,
                    tooltip = c("group", "x", "y")
                ) %>%
                    layout(dragmode = "select")
                plotlyObject(plt)
                plotlyObject()
            })
        } else {
            output$expressionPlot <- plotly::renderPlotly({
                p <- plotMultipleGeneExpression(
                    data(),
                    geneNames,
                    input$stageSelect,
                    input$useLog
                )

                # Set longData to the long data
                longData <- longData(p$longData)

                plt <- p$plot
                plt <- plotly::ggplotly(
                    plt,
                    tooltip = c("group", "x", "y")
                ) %>%
                    layout(dragmode = "select")
                plotlyObject(plt)
                plotlyObject()
            })
        }

        # Fetch information from Ensembl for the selected genes
        g <- getGeneInfo(geneNames)
        if (length(g) == 0) {
            # Show a modal dialog if no genes were found
            showModal(modalDialog(
                title = "No Genes Found",
                "No genes were found for the given gene names.",
                easyClose = TRUE,
                footer = NULL
            ))
            return()
        }

        geneInfo(g)

        # Use event_data to capture click events
        observe({
            eventData <- event_data("plotly_click")

            if (!is.null(eventData)) {
                # Set pointSelected to TRUE
                pointSelected(TRUE)

                # Extract the selected data
                plotlyText <- extractPlotlyData(plotlyObject, eventData)

                # Get the selected gene, stage, and expression
                selectedGene <- plotlyText$Gene
                selectedStage <- plotlyText$Stage
                selectedExpression <- plotlyText$Expression

                # Update the UI elements
                output$selectedGeneInfo <- renderUI({
                    tags$div(
                        tags$h4("Selected gene:"),
                        tags$p(
                            selectedGene,
                            style = "font-weight: bold; color: blue;"
                        )
                    )
                })
                output$selectedStageInfo <- renderUI({
                    tags$div(
                        tags$h4("Selected stage:"),
                        tags$p(
                            selectedStage,
                            style = "font-weight: bold; color: blue;"
                        )
                    )
                })
                output$selectedExpressionInfo <- renderUI({
                    tags$div(
                        tags$h4("Expression value:"),
                        tags$p(
                            selectedExpression,
                            style = "font-weight: bold; color: blue;"
                        )
                    )
                })

                # Get the gene information
                selectedExtraInfo <- geneInfo()[[selectedGene]]

                # Get the anatomy information
                selectedAnatomyInfo <- selectedExtraInfo@anatomy@anatomy

                output$anatomyInfo <- renderUI({
                    anatomyItems <- lapply(selectedAnatomyInfo, function(item) {
                        wellPanel(
                            h3(item@label),
                            p(item@id),
                            p(item@description)
                        )
                    })

                    # Wrap the anatomy items in a fluidRow
                    column(
                        12,
                        anatomyItems
                    )
                })

                # Get the ontology information
                selectedOntologyInfo <- selectedExtraInfo@ontology@ontologies

                output$ontologyInfo <- renderUI({
                    ontologyItems <- 
                        lapply(selectedOntologyInfo, function(item) {
                            wellPanel(
                                h3(item@name),
                                p(item@id),
                                p(item@definition)
                            )
                        })

                    # Wrap the ontology items in a fluidRow
                    column(
                        12,
                        ontologyItems
                    )
                })
            } else {
                pointSelected(FALSE)
            }
        })

        # Validate gene names
        validationMessage <- validateGeneNames(geneNames, data())
        if (!is.null(validationMessage)) {
            showModal(modalDialog(
                title = "Invalid Input",
                validationMessage,
                easyClose = TRUE,
                footer = NULL
            ))
            return()
        }
    })

    outputOptions(output, "pointSelected", suspendWhenHidden = FALSE)
    outputOptions(output, "geneInfo", suspendWhenHidden = FALSE)
}

# Run the application
shinyApp(ui = ui, server = server)
