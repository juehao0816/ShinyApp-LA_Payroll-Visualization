library(shiny)
library(ggplot2)
library(tidyverse)

#Import data#
LAtotpayroll <- readRDS("LAtotpayroll.rds")
LAEarnmost <- readRDS("LAEarnmost.rds")
LAEarnDepMean <- readRDS("LAEarnDepMean.rds")
LAEarnDepMed <- readRDS("LAEarnDepMed.rds")
LAempsalary <- readRDS("LAempsalary.rds")


ui <- fluidPage(
   titlePanel("LA City Employee Payroll"),
   navlistPanel(
     tabPanel("Total Payroll by LA City",
              titlePanel("Total Payroll by LA City"),
              plotOutput(outputId = "Total")
     ),
     tabPanel("Who earned most",
              titlePanel("Who earned most"),
              sidebarLayout(
                sidebarPanel(
                  selectInput(inputId = "Year",
                              label = "Choose a year:",
                              choices = c("2013", "2014", "2015", "2016", "2017"),
                              selected = "2017"),
                  numericInput(inputId = "Employee",
                               label = "Number of observations in employee:",
                               value = 10)
                ),
                mainPanel(tableOutput(outputId = "Earnmostemp"))
              )),
     tabPanel("Which departments earn most",
              titlePanel("Which departments earn most"),
              sidebarLayout(
                sidebarPanel(
                  selectInput(inputId = "Year2",
                              label = "Choose a year:",
                              choices = c("2013", "2014", "2015", "2016", "2017"),
                              selected = "2017"),
                  numericInput(inputId = "Departmentn1",
                               label = "Number of observations in department:",
                               value = 5),
                  radioButtons("Method",
                                     h3("Comparing by method:"),
                                     choices = c("Mean", "Median"), 
                               selected = "Median")
                ),
                mainPanel(tableOutput(outputId = "Earnmostdep"))
              )),
     tabPanel("Which departments cost most",
              titlePanel("Which departments cost most"),
              sidebarLayout(
                sidebarPanel(
                  selectInput(inputId = "Year3",
                              label = "Choose a year:",
                              choices = c("2013", "2014", "2015", "2016", "2017"),
                              selected = "2017"),
                  numericInput(inputId = "Departmentn2",
                               label = "Number of observations in department:",
                               value = 5)
                ),
                mainPanel(tableOutput(outputId = "Costmostdep"))
              )),
     tabPanel("Which employee has most projected annual salary",
     sidebarLayout(
       sidebarPanel(
         selectInput(inputId = "Year4",
                     label = "Choose a Year:",
                     choices = c("2013", "2014", "2015", "2016", "2017"),
                     selected = "2017"),
         numericInput(inputId = "Job",
                      label = "number of observations in employee:",
                      value = 5)
       ),
       mainPanel(tableOutput(outputId = "Salary"))
     ))
     
   )
)

#server#
server <-function(input, output) {
  #Total payment plot
  output$Total <- renderPlot({
    ggplot(data = LAtotpayroll, aes(x = Year, y = Amount, fill = Type)) +
      geom_bar(stat = "identity")
  })
  
  #Who earn most table#
  output$Earnmostemp <- renderTable({
    LAEarnmost$Year <- format(LAEarnmost$Year, digits = 0)
    LAEarnmost %>% filter(Year == input$Year) %>%
      head(input$Employee)
  })
  
  #Which department earn most table#
  output$Earnmostdep <- renderTable({
    LAEarnDepMean$Year <- format(LAEarnDepMean$Year, digits = 0)
    LAEarnDepMed$Year <- format(LAEarnDepMed$Year, digits = 0)
    if (input$Method == "Mean") {
      LAEarnDepMean %>% filter(Year == input$Year2) %>%
        head(input$Departmentn1)
    } else {
      LAEarnDepMed %>% filter(Year == input$Year2) %>%
        head(input$Departmentn1)
    }
    
  })
  
  #Which department cost most table
  output$Costmostdep <-renderTable({
    LAcostpayroll$Year <- format(LAcostpayroll$Year, digits = 0)
    LAcostpayroll %>% filter(Year == input$Year3) %>%
      head(input$Departmentn2)
  })
  
  #Which employee has the most projected annual salary
  output$Salary <-renderTable({
    LAempsalary$Year <- format(LAempsalary$Year, digits = 0)
    LAempsalary %>% filter(Year == input$Year4) %>%
      head(input$Job)
  })

}

 


   
shinyApp(ui = ui, server = server)   

