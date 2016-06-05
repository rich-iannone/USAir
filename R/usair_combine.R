#' Traverse from one or more selected edges toward
#' adjacent outward nodes
#' @description From a graph object of class
#' \code{dgr_graph} move to adjacent nodes from a
#' selection of one or more selected edges where the
#' edges are outward edges to those nodes. This creates
#' a selection of nodes. An optional filter by node
#' attribute can limit the set of nodes traversed to.
#' @param usair_dataset the name of the dataset to
#' use; options are \code{co} (carbon monoxide), 
#' \code{no2} (nitrogen dioxide), \code{so2} (sulfur 
#' dioxide), \code{ozone} (ground-level ozone), 
#' \code{pm10} (particulate matter up to 10 microns in
#' diameter), \code{pm25_frm} (particulate matter up
#' to 2.5 microns in diameter, using a Federal 
#' Reference Method (FRM) instrument or its equivalent
#' (FEM)), \code{pm25_nfrm} (same as \code{pm25_frm} 
#' but not using an FRM or FEM instrument ), and 
#' \code{met} (meteorology).
#' @param years a vector of years that represents the
#' starting and ending years to include in the combined
#' dataset.
#' @return a dplyr \code{tb_df} data frame with 
#' combined data for multiple years.
#' @examples
#' \dontrun{
#' # Get carbon monoxide (CO) data for the years 1992,
#' # 1993, and 1994 in a single data frame
#' co_1992_1994 <- usair_combine("co", c(1992, 1994))
#'
#' # Get a count of records for this dataset
#' nrow(co_1992_1994)
#' #> [1] 12584901
#' }
#' @import dplyr
#' @export usair_combine

usair_combine <- function(usair_dataset,
                          years) {
  
  if (!(usair_dataset %in% 
        c("co", "no2", "so2", "ozone",
          "pm10", "pm25_frm", "pm25_nfrm",
          "met"))){
    stop("The specified dataset does not exist.")
  }
  
  dataset_object_name <- paste0(usair_dataset, "_hourly")
  years_expanded <- seq(years[1], years[2], 1)
  
  # Determine which data exists
  if (usair_dataset == "co") {
    filenames <- paste0("co_hourly_", years_expanded, ".rdata")
  } else if (usair_dataset == "no2") {
    filenames <- paste0("no2_hourly_", years_expanded, ".rdata")
  } else if (usair_dataset == "so2") {
    filenames <- paste0("so2_hourly_", years_expanded, ".rdata")
  } else if (usair_dataset == "ozone") {
    filenames <- paste0("ozone_hourly_", years_expanded, ".rdata")
  } else if (usair_dataset == "pm10") {
    filenames <- paste0("pm10_hourly_", years_expanded, ".rdata")
  } else if (usair_dataset == "pm25_frm") {
    filenames <- paste0("pm25_frm_fem_hourly_", years_expanded, ".rdata")
  } else if (usair_dataset == "pm25_nfrm") {
    filenames <- paste0("pm25_non_frm_fem_hourly_", years_expanded, ".rdata")
  } else if (usair_dataset == "met") {
    filenames <- paste0("met_hourly_", years_expanded, ".rdata")
  }
  
  file_locations <- system.file(paste0("data/", filenames), package = "USAir")
  
  if (length(file_locations) == 1) {
    if (file_locations == "") {
      stop("The selected years do not have data.")
    }
  }
  years_expanded
  for (i in 1:length(file_locations)) {
    if (i == 1) {
      load(file_locations[i])
      assign(
        "data", 
        value = get(paste0(
          dataset_object_name, 
          "_", 
          gsub(".*_([0-9][0-9][0-9][0-9]).rdata$", 
               "\\1", file_locations[i]))))
    }
    if (i > 1) {
      load(file_locations[i])
      assign(
        paste0("data_2"), 
        value = get(paste0(
          dataset_object_name, 
          "_", 
          gsub(".*_([0-9][0-9][0-9][0-9]).rdata$", 
               "\\1", file_locations[i]))))
      
      data <- bind_rows(data, data_2)
    }
    if (i == length(file_locations)) {
      rm(data_2)
    }
  }
  
  return(data)
}
