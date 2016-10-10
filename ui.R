library(shiny)


shinyUI(fluidPage(
  titlePanel("Calculs Boursiers !"),br(),
  sidebarPanel(
    selectInput(inputId = "nom_valeur", label = "Valeur",
                choices = c("CABC","FTSC","NEIC","NTLC","SEMC","SIVC","SLBC","SMBC","STBC","TTRC","UNLC","CABC","CIEC","ONTBF","SDCC","SNTS","BICC","BOAB","BOABF","BOAC","BOAN","BOAS","ETIT","SAFC","SGBC","SDSC","SVOC","PALC","SICC","SOGC","SPHC","ABJC","BNBC","CFAC","PRSC","SHEC","TTLC","TTLS","STAC"),
                selected = "CABC"),
    numericInput("coursha","Cours achat",52,0,500000,1,width=NULL),
    numericInput("nbre","Nbre d'action",45500,40,100000,1,width=NULL),
    numericInput("coursvte","Cours vente",54,0,500000,1,width=NULL),
    checkboxInput(inputId = "individual_obs",
                  label = strong("Show individual observations"),
                  value = FALSE),
    actionButton("update", "Update Table"),
    downloadButton('downloadData', 'Download')
    
  ),
  
  mainPanel(
    
    tabsetPanel(id = "tabs",
                tabPanel("Paramètres", value = "A", h3("Table de paramétrage"),hr(),br(),
                         fluidRow(
                           column(width=2,numericInput("neg", "Négociation", 0.014, 0, 1, step = 0.001,width = NULL)),
                           column(width=2,numericInput("val", "Valorisation", 0.025, 0,1, step = 0.001,width = NULL)),
                           column(width=2,numericInput("taf", "TAF", 0.17, 0, 1, 0.01,width = NULL)),
                           column(width=2,numericInput("btaf", "Base TAF", 0.011, 0, 1, 0.001,width = NULL))
                         ),
                         fluidRow(column(width=2,numericInput("btdaf", "Deuxième ligne", 0.011, 0, 1, 0.001,width = NULL))),
                         hr(),
                         h4("Troisième ligne"),
                         fluidRow(column(width=3,br(),verbatimTextOutput("resultat"))),
                         hr(),fluidRow(column(width=2,tableOutput("cout_achat")))
                ),
                #fluidRow(
                #column(width=2,nnumericInput("taf", "TAF", 0.17, 0, 1, 0.01,width = NULL))
                #column(width=2,numericInput("btaf", "Base TAF", 0.011, 0, 1, 0.001,width = NULL
                #fluidRow(
                #column(width=2,br(),verbatimTextOutput("rlst"))#,
                #dataTableOutput("tab")
                tabPanel("Simulation", value = "D",hr(),h3("Résultat de la simulation")
                         #fluidRow(column(width=2,tableOutput("cout_achat")))
                ),
                tabPanel("Prévisions", value = "C", hr(),h3("Résultat de la prévision")),
                #fluidRow(
                #column(width=2,numericInput("negF", "Négociation", 0.014, 0, 1, step = 0.001,width = NULL)),
                #column(width=2,verbatimTextOutput("negoc"))
                #)
                tabPanel("Panorama", value = "D",hr(),h3("Portefeuille de valeurs"),
                         tableOutput("table1")),
                #fluidRow(column(width=2,verbatimTextOutput("vachats")))),
                tabPanel("Graphiques", value = "E", br(),br(),plotOutput("pl"))
    )))
