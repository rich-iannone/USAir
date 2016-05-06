library(dplyr)
library(magrittr)

# Read in hourly PM2.5 (non-FRM/FEM Mass) files, change
# to `tbl_df`, modify column names, save as .rdata
# file with bzip2 compression
for (i in 1998:2015){
  raw <- 
    read.csv(
      paste0("~/Downloads/hourly_88502_", i, ".csv"),
      stringsAsFactors = FALSE)
  
  pm25_non_frm_fem_hourly <- 
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
  
  pm25_non_frm_fem_hourly$param <- "pm25"
  pm25_non_frm_fem_hourly$unit_meas <- "ug_cm3"
  
  save(pm25_non_frm_fem_hourly,
       file = paste0("data/pm25_non_frm_fem_hourly_", i, ".rdata"),
       compress = "bzip2")
}
