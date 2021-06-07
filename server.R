server <- function(input, output){
  dataSetInput <- reactive(
    {
      switch(input$dataSet, 
             "qc" =df_quiz, 
             "mr" =df_results,
             "ig"=question_correct_no,
             "qnc" = question_category)
      
    }
  )
  
  output$summary <- renderPrint(
    {
      
      summary(dataSetInput()[1:input$num,])
    }
  )
  output$table <- renderTable(
    {
      
      head(dataSetInput(), n = input$num)
      
    }
  )
  
  output$summary2 <- renderPrint(
    {
      
      summary(dataSetInput()[1:input$num2,])
      
    }
  )
  output$table2 <- renderTable(
    {
      
      head(dataSetInput(), n = input$num2)
      
    }
  )
  output$table3 <- renderTable(
    {
      
      head(dataSetInput(), n = input$num3)
      
    }
  )
  
  
  output$plot <- renderPlot(
    {
      
      question_no <-dataSetInput()$question_no
      correct_no <-dataSetInput()$correct_no
      ggplot(dataSetInput()[1:input$num3,],aes(question_no,correct_no ))+geom_bar(aes(fill = question_no),stat="identity")+ggtitle("Correct Number of Different Questions ")+theme(plot.title = element_text(hjust = 0.5))
      
    }
  )
  output$plot2 <- renderPlot(
    {
      tryCatch(
        tmp <- dataSetInput()[,c(as.numeric(input$num4),31)],
        error = function(e){
          print("wait")
        }
      )
      #tmp <- select(dataSetInput(),c(input$num4,31))
      Question_no <-tmp[,1]
      category <-tmp[,2]
      
      ggplot(tmp,aes(Question_no,category ))+geom_bar(aes(fill = category),stat="identity")+ggtitle("Required Skills for Specific Question")+theme(plot.title = element_text(hjust = 0.5))
      
    }
  )
  
}