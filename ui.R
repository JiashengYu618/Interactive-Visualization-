library(dplyr)
library(ggplot2)
#dataset 1
df_quiz <- read.csv("quiz-categories.csv") 
#dataset 2
df_results <- read.csv("midterm-results.csv")
#dataset 3

df_correct_question <- subset(df_results,select =c(Q1_c:Q30_c))
correct_no<-apply(df_correct_question,2,sum)
question_correct_no<-as.data.frame(correct_no)
question_correct_no$question_no <-c(1:30)
#dataset 4
categories <- c("wrangling","coding","d.trees","sna","nlp","viz","n.nets","googleable","non-googleable","jitl","substantive")
# categories <- c(1,2,3,4,5,6,7,8,9,10,11)
question_category1 <- data.frame(df_quiz,row.names = 1) #use the first column as the row names
question_category1 <- t(question_category1)
question_category2 <- as.data.frame(question_category1,row.names = F)
#names(question_category2)<-seq(1,30,1)
question_category <- as.data.frame(cbind(categories,question_category2))
question_category <- question_category[,c(2:31,1)]
#rownames(question_category) = c(1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,"categories")
# library(tidyr)
# question_category <- question_category %>% gather(questionNo,value,-categories) #pivot



ui <- fluidPage(
  titlePanel("Quiz and Results Table"),
  sidebarLayout(
    
    sidebarPanel(
      selectInput("dataSet","Choose one dataset:",choices = c("quiz-categories" = "qc",
                                                              "midterm-results" = "mr",
                                                              "question_correct"="ig",
                                                              "quizNo_category" = "qnc")),
      br(),
      conditionalPanel(
        condition = "input.dataSet == 'qc'",
        sliderInput("num","Number of observations:",min = 1, max = 30, value = 10),
        
      ),
      conditionalPanel(
        condition = "input.dataSet == 'mr'",
        sliderInput("num2","Number of observations:",min = 1, max = 26, value = 10),
        
      ),
      conditionalPanel(
        condition = "input.dataSet == 'ig'",
        sliderInput("num3","Number of observations:",min = 1, max = 30, value = 10),
        
      ),
      conditionalPanel(
        condition = "input.dataSet == 'qnc'",
        sliderInput("num4","use slider to choose the question number:",min = 1, max = 30,value=1 ),
        
      )
      
    ),
    
    mainPanel(
      
      conditionalPanel(
        condition = "input.dataSet == 'qc'",
        tabsetPanel(
          # type = "tabs",
          tabPanel(
            "Summary",
            verbatimTextOutput("summary")
          ),
          tabPanel(
            "Table",
            tableOutput("table")
          )
        )
      ),
      conditionalPanel(
        condition = "input.dataSet == 'mr'",
        tabsetPanel(
          # type = "tabs",
          
          tabPanel(
            "Summary",
            verbatimTextOutput("summary2")
          ),
          tabPanel(
            "Table",
            tableOutput("table2")
          )
        )
      ),
      conditionalPanel(
        condition = "input.dataSet == 'ig'",
        tabsetPanel(
          
          tabPanel(
            "Table",
            tableOutput("table3")
          ),
          tabPanel(
            "Plot",
            plotOutput("plot")
          )
        )
      ),
      conditionalPanel(
        condition = "input.dataSet == 'qnc'",
        tabsetPanel(
          
          tabPanel(
            "Plot",
            plotOutput("plot2")
          )
        )
      ),
      
    )#mainPanel
  )#sidebarLayout
)#fluidPage