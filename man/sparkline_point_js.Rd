% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/sparkline_point_js.R
\name{sparkline_point_js}
\alias{sparkline_point_js}
\title{Sparkline Point Figure Javascript Render Using Plotly}
\usage{
sparkline_point_js(
  tbl,
  x,
  type = c("cell", "footer", "header"),
  x_lower = NULL,
  x_upper = x_lower,
  xlim = NULL,
  xlab = "",
  y = seq_along(x),
  vline = NULL,
  text = NULL,
  height = 30,
  width = 150,
  color = "gold",
  color_errorbar = color,
  color_vline = "#00000050",
  legend = FALSE,
  legend_label = NULL,
  legend_title = "",
  legend_position = 0,
  legend_type = c("point", "line", "point+line"),
  margin = rep(0, 5)
)
}
\arguments{
\item{tbl}{A data frame}

\item{x}{A vector of variable names in \code{tbl} for value.}

\item{type}{A character for the type of reactable component.}

\item{x_lower}{A vector of variable names in \code{tbl} for lower error difference.}

\item{x_upper}{A vector of variable names in \code{tbl} for upper error difference. Default is the same as \code{x_lower}.}

\item{xlim}{Numeric vectors of length 2, giving the x coordinates ranges.}

\item{xlab}{A character for the x-axis label.}

\item{y}{Numeric vector of y-axis value.}

\item{vline}{Numeric value for the location to draw the vertical reference line.}

\item{text}{Character vector of text information dispalted for each point.}

\item{height}{Numeric value of figure height.}

\item{width}{Numeric value of figure width.}

\item{color}{Character vector of point color name}

\item{color_errorbar}{Character vector of errorbar color name}

\item{color_vline}{Character vector of vertical reference line color name}

\item{legend}{A logical value to display legend.}

\item{legend_label}{A character vector for legend label.}

\item{legend_title}{A character value for legend title.}

\item{legend_position}{A numeric value for legend vertical position.}

\item{legend_type}{A character value for legend type.}

\item{margin}{A vector of length 5 for figure margin at bottom, left, top, right and padding.}
}
\description{
Sparkline Point Figure Javascript Render Using Plotly
}
\examples{
\dontrun{
 
library(reactable)
library(htmltools)

js <- sparkline_point_js(iris, "Sepal.Length")
js <- sparkline_point_js(iris, "Sepal.Length", text = "x")
js <- sparkline_point_js(iris, "Sepal.Length", text = "'count:' + x")
js <- sparkline_point_js(iris, "Sepal.Length", x_lower = "Sepal.Width", 
                         text = "'range:' + x + '(' + x_lower + ',' + x_upper + ')'" )
js <- sparkline_point_js(iris, "Sepal.Length", x_lower = "Sepal.Width")
js <- sparkline_point_js(iris, "Sepal.Length", vline = 6)

js <- sparkline_point_js(iris, 
                         x = c("Sepal.Length", "Sepal.Width"), 
                         x_lower = "Sepal.Width",
                         y = c(1,2),
                         text = c("x[0]", "x[1]"),
                         color = c("gold", "purple") )
cat(js)

col <- colDef(html = TRUE, cell = JS(js), width = 150,
              style="font-size: 0px; padding: 0px; margin: 0px;")
p <- reactable(data = iris[,1:2],
               theme = reactableTheme(cellPadding = "0px 8px"),
               borderless = TRUE,
               highlight = TRUE,
               resizable = TRUE,
               columns = list(Sepal.Length = col))
               
plotly_js <- "https://unpkg.com/react-plotly.js@1.0.2/dist/create-plotly-component.js"
browsable(tagList(
  reactR::html_dependency_react(),
  htmltools::tags$script(src="https://cdn.plot.ly/plotly-latest.min.js"),
  htmltools::tags$script(src=plotly_js),
  p
))

}

}
