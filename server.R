library(shiny)

shinyServer(function(input, output) {
  
  values <- reactiveValues()
  #Create 0 row data.frame
  values$df <- data.frame(Valeur=numeric(0), Nbre=numeric(0),CoursHa=numeric(0),CoutHa=numeric(0),
                          CoursVte=numeric(0),CoutVte=numeric(0),Resultat=numeric(0))
  newEntry <- observe({
    if(input$update > 0) {
      isolate(values$df[nrow(values$df) + 1,] <- c(input$nom_valeur,input$nbre,input$coursha,coutHa(),input$coursvte,coutVt(),rslt()))
    }
  })
  
  output$table1 <- renderTable({values$df})
  
  output$downloadData <- downloadHandler(
    filename = function() {paste("Portefeuille", '.csv', sep='')},
    content = function(file) {write.csv(values$df, file)})
  
  
  #output$text <- renderText({paste0("You are viewing tab \"", input$tabs, "\"")})
  output$cours <- renderPrint({input$coursha})
  # Extraire la variable réactive
  vachat <- reactive({1 + (input$taf*input$btaf)+ input$neg})
  vvente <- reactive({1 - (input$taf*input$btaf)- input$neg})
  # Extraire les valeurs 
  output$vachats <- renderPrint({vachat()})
  output$vventes <- renderPrint({vvente()})
  output$achat <- renderPrint({input$nbre*input$coursha*(1 + (input$taf*input$btaf)+ input$neg)})
  #output$pl <- renderPlot({plot(input$coursha,input$vente),type="b")})
  rslt <- reactive({({(input$nbre*input$coursvte*vvente())-(input$nbre*input$coursha*vachat())})}) #1.01587
  output$resultat <- renderPrint({rslt()})
  coutHa <- reactive({(input$nbre*input$coursha*vachat())})
  coutVt <- reactive({(input$nbre*input$coursvte*vvente())})
  output$cout_achat <- renderTable(data.frame(valeur=input$nom_valeur,nbre=input$nbre,"cours achat"=input$coursha,coutHa(),input$coursvte,coutVt(),(coutHa()/input$nbre),rslt()))
  #coutVte <- renderPrint({(input$nbre*input$coursvte*vvente())
  output$negoc <- renderPrint({input$negF})
  output$tab <- renderTable(valeurs)
  
})
