% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/usair_combine.R
\name{usair_combine}
\alias{usair_combine}
\title{Traverse from one or more selected edges toward
adjacent outward nodes}
\usage{
usair_combine(usair_dataset, years)
}
\arguments{
\item{usair_dataset}{the name of the dataset to
use; options are \code{co} (carbon monoxide), 
\code{no2} (nitrogen dioxide), \code{so2} (sulfur 
dioxide), \code{ozone} (ground-level ozone), 
\code{pm10} (particulate matter up to 10 microns in
diameter), \code{pm25_frm} (particulate matter up
to 2.5 microns in diameter, using a Federal 
Reference Method (FRM) instrument or its equivalent
(FEM)), \code{pm25_nfrm} (same as \code{pm25_frm} 
but not using an FRM or FEM instrument ), and 
\code{met} (meteorology).}

\item{years}{a vector of years that represents the
starting and ending years to include in the combined
dataset.}
}
\value{
a dplyr \code{tb_df} data frame with 
combined data for multiple years.
}
\description{
From a graph object of class
\code{dgr_graph} move to adjacent nodes from a
selection of one or more selected edges where the
edges are outward edges to those nodes. This creates
a selection of nodes. An optional filter by node
attribute can limit the set of nodes traversed to.
}
\examples{
\dontrun{
# Get carbon monoxide (CO) data for the years 1992,
# 1993, and 1994 in a single data frame
co_1992_1994 <- usair_combine("co", c(1992, 1994))

# Get a count of records for this dataset
nrow(co_1992_1994)
#> [1] 12584901
}
}

