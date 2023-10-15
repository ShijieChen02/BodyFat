library(shiny)
library(ggplot2)

function(input, output) {
  observeEvent(input$calculate, {
    height <- input$height
    abdomen <- input$abdomen
    age <- input$age
    sex <- input$sex
    
    if (input$unit_height == "in") {
      height <- height * 2.54
    }
    if (input$unit_abdomen == "in") {
      abdomen <- abdomen * 2.54
    }
    
    # Calculate body fat
    body_fat <- -77.08 - 41.37 * log(height/2.54) + 60.17 * log(abdomen)
    
    # Calculate ideal body fat based on age and sex
    ideal_body_fat <- ifelse(
      sex == "Male",
      ifelse(
        age < 30, 8,
        ifelse(
          age >= 30 & age < 50, 10,
          12
        )
      ),
      ifelse(
        age < 30, 21,
        ifelse(
          age >= 30 & age < 50, 23,
          25
        )
      )
    )
    
    output$bodyfat_result <- renderText({
      paste("Predicted Body Fat Percentage:", round(body_fat, 2), "%")
    })
    
    # Create a plot of body fat percentage
    output$bodyfat_plot <- renderPlot({
      df <- data.frame(
        Percentage = c(body_fat, ideal_body_fat), 
        Category = c("Predicted Body Fat", "Ideal Body Fat")
      )
      ggplot(df, aes(x = Category, y = Percentage, fill = Category)) +
        geom_bar(stat = "identity", width = 0.5) +
        geom_text(aes(label = paste0(round(Percentage, 2), "%")), 
                  position = position_dodge(width = 0.9), vjust = -0.5, color = "white") +
        theme_bw() +
        theme(text = element_text(size = 16)) +  # Adjust text size
        ylim(0, body_fat + 10) +  # Adjusted upper bound of y-axis
        labs(y = "Percentage (%)") +
        theme(legend.position="none") 
    })
    
    # Additional health information based on body fat percentage
    health_info <- ifelse(
      body_fat < 0 || body_fat > 60, "Please double-check your inputs as the result seems unrealistic.",
      ifelse(
        body_fat < 5, "Very Low Body Fat - Potential health risks.",
        ifelse(
          body_fat >= 5 & body_fat < 20, "Low Body Fat - Generally considered healthy.",
          ifelse(
            body_fat >= 20 & body_fat < 30, "Moderate Body Fat - Moderate health risks.",
            ifelse(
              body_fat >= 30 & body_fat < 40, "High Body Fat - Increased health risks.",
              "Very High Body Fat - Significant health risks. Consult a healthcare professional."
            )
          )
        )
      )
    )
    
    output$health_info_result <- renderText({
      paste("Health Information:", health_info)
    })
  })
}
