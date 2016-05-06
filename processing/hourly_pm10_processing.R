library(dplyr)
library(magrittr)

# Read in hourly PM10 Mass files, change
# to `tbl_df`, modify column names, save as .rdata
# file with bzip2 compression
for (i in 1990:2015){
  raw <- 
    read.csv(
      paste0("~/Downloads/hourly_81102_", i, ".csv"),
      stringsAsFactors = FALSE)
  
  pm10_hourly <- 
    raw %>%
    tbl_df() %>%
    select(state = State.Name,
           county = County.Name,
           site = Site.Num,
           lat = Latitude,
           lon = Longitude,
           param = Parameter.Name,
           date_local = Date.Local,
           time_local = Time.Local,
           value = Sample.Measurement,
           unit_meas = Units.of.Measure,
           poc = POC,
           mdl = MDL,
           uncert = Uncertainty,
           qual = Qualifier,
           method_type = Method.Type,
           method_name = Method.Name,
           datum = Datum,
           date_gmt = Date.GMT,
           time_gmt = Time.GMT,
           param_code = Parameter.Code,
           method_code = Method.Code,
           state_code = State.Code,
           county_code = County.Code,
           date_last_chg = Date.of.Last.Change)
  
  pm10_hourly$param <- "pm10"
  pm10_hourly$unit_meas <- "ug_m3"
  
  save(pm10_hourly,
       file = paste0("data/pm10_hourly_", i, ".rdata"),
       compress = "bzip2")
}
