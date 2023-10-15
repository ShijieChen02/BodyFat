library(shiny)

fluidPage(
  titlePanel("Body Fat Predictor"),
  sidebarLayout(
    sidebarPanel(
      numericInput("height", "Height:", value = 175),
      selectInput("unit_height", "Unit for Height:",
                  choices = c("cm", "in"), selected = "cm"),
      numericInput("abdomen", "Abdomen Circumference:", value = 80),
      selectInput("unit_abdomen", "Unit for Abdomen Circumference:",
                  choices = c("cm", "in"), selected = "cm"),
      numericInput("age", "Age:", value = 30),
      selectInput("sex", "Sex:",
                  choices = c("Male", "Female"), selected = "Male"),
      actionButton("calculate", "Predict Body Fat"),
      br(),
      helpText("Note: Please enter the height and abdomen circumference, and select the corresponding units.")
    ),
    mainPanel(
      h3("Predicted Body Fat Percentage:"),
      verbatimTextOutput("bodyfat_result"),
      br(),
      plotOutput("bodyfat_plot"),
      br(),
      h3("Health Information:"),
      verbatimTextOutput("health_info_result"),
      br(),
      h3("Contact Info:"),
      HTML("<p>Email: schen935@wisc.edu")
    )
  )
)

