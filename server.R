
library(lattice) 
library(ggplot2) 

require(stats); require(graphics)

as.factor(CO2$Plant)
as.factor(CO2$Type)
as.factor(CO2$Treatment)

CO2$TT <- interaction(CO2[c(2, 3)], drop=TRUE)

as.factor(CO2$TT)

fmlist <- list()
for (pp in levels(CO2$TT)) {
  fmlist[[pp]] <- glm(uptake ~ conc, data = CO2, subset = TT == pp)
}

x1 <- sapply(fmlist, function(f) summary(f)$coefficients[,1])

shinyServer(
  function(input, output) {

    output$newHist <- renderPlot({
      mu <- input$mu
      xy <- xyplot(uptake ~ conc | TT, data = CO2,
                   show.given = FALSE, type = "a",  col="blue", 
                   layout = c(2, 2),
                   main="Scatterplot by Plant", 
                   ylab="CO2 Uptake", xlab="CO2 Concentration",
                   panel = function(...) {
                   panel.abline(v=mu, lty="dotted", col="red")
                   panel.xyplot(...)}
                   )
      print(xy)
    })
    
  output$uptakeText <- renderText({ 
    mu <- input$mu
    id <- input$id1 

    y <- x1[1,id]+(x1[2,id]*mu)
    
    paste("Predicted Uptake is", y)
  })
  
  }
)
