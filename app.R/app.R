library(shiny)

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
                )
              )),
     tabPanel("Which departments earn most",
              titlePanel("Which departments earn most"),
              sidebarLayout(
                sidebarPanel(
                  selectInput(inputId = "Year",
                              label = "Choose a year:",
                              choices = c("2013", "2014", "2015", "2016", "2017"),
                              selected = "2017"),
                  numericInput(inputId = "Departmentn1",
                               label = "Number of observations in department:",
                               value = 5)
                )
              )),
     tabPanel("Which departments cost most",
              titlePanel("Which departments cost most"),
              sidebarLayout(
                sidebarPanel(
                  selectInput(inputId = "Year",
                              label = "Choose a year:",
                              choices = c("2013", "2014", "2015", "2016", "2017"),
                              selected = "2017"),
                  numericInput(inputId = "Departmentn2",
                               label = "Number of observations in department:",
                               value = 5)
                )
              )),
     
   )
)

#server#

   
   

