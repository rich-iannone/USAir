library(dplyr)
library(magrittr)

# Read in hourly meteorology files, change
# to `tbl_df`, modify column names, do some joining,
# save as .rdata file with bzip2 compression
for (i in 1990:2015){
  wind <- 
    read.csv(
      paste0("~/Downloads/hourly_WIND_", i, ".csv"),
      stringsAsFactors = FALSE)
  
  temp <- 
    read.csv(
      paste0("~/Downloads/hourly_TEMP_", i, ".csv"),
      stringsAsFactors = FALSE)
  
  rh_dp <- 
    read.csv(
      paste0("~/Downloads/hourly_RH_DP_", i, ".csv"),
      stringsAsFactors = FALSE)
  
  pressure <- 
    read.csv(
      paste0("~/Downloads/hourly_PRESS_", i, ".csv"),
      stringsAsFactors = FALSE)
  
  wind_hourly <- 
    wind %>%
    tbl_df()
  
  rm(wind)
  
  wind_wd_hourly <-
    wind_hourly %>%
    filter(Units.of.Measure == "Degrees Compass") %>%
    select(state = State.Name,
           county = County.Name,
           site = Site.Num,
           lat = Latitude,
           lon = Longitude,
           date_local = Date.Local,
           time_local = Time.Local,
           wd = Sample.Measurement,
           datum = Datum,
           date_gmt = Date.GMT,
           time_gmt = Time.GMT,
           state_code = State.Code,
           county_code = County.Code)
  
  wind_ws_hourly <-
    wind_hourly %>%
    filter(Units.of.Measure == "Knots") %>%
    select(state = State.Name,
           county = County.Name,
           site = Site.Num,
           lat = Latitude,
           lon = Longitude,
           date_local = Date.Local,
           time_local = Time.Local,
           ws_knots = Sample.Measurement,
           datum = Datum,
           date_gmt = Date.GMT,
           time_gmt = Time.GMT,
           state_code = State.Code,
           county_code = County.Code) %>%
    mutate(ws = ws_knots * 0.514444)
  
  temp_hourly <- 
    temp %>%
    tbl_df() %>%
    select(state = State.Name,
           county = County.Name,
           site = Site.Num,
           lat = Latitude,
           lon = Longitude,
           date_local = Date.Local,
           time_local = Time.Local,
           temp_f = Sample.Measurement,
           datum = Datum,
           date_gmt = Date.GMT,
           time_gmt = Time.GMT,
           state_code = State.Code,
           county_code = County.Code) %>%
    mutate(temp = (temp_f - 32) * (5/9))
  
  temp_hourly$temp <- round(temp_hourly$temp, 1)
  
  rm(temp)
  
  rh_dp_hourly <- 
    rh_dp %>%
    tbl_df()
  
  rm(rh_dp)
  
  rh_hourly <-
    rh_dp_hourly %>%
    filter(Units.of.Measure == "Percent relative humidity") %>%
    select(state = State.Name,
           county = County.Name,
           site = Site.Num,
           lat = Latitude,
           lon = Longitude,
           date_local = Date.Local,
           time_local = Time.Local,
           rh = Sample.Measurement,
           datum = Datum,
           date_gmt = Date.GMT,
           time_gmt = Time.GMT,
           state_code = State.Code,
           county_code = County.Code)
  
  dp_hourly <-
    rh_dp_hourly %>%
    filter(Units.of.Measure == "Degrees Fahrenheit") %>%
    select(state = State.Name,
           county = County.Name,
           site = Site.Num,
           lat = Latitude,
           lon = Longitude,
           date_local = Date.Local,
           time_local = Time.Local,
           dp_f = Sample.Measurement,
           datum = Datum,
           date_gmt = Date.GMT,
           time_gmt = Time.GMT,
           state_code = State.Code,
           county_code = County.Code) %>%
    mutate(dp = (dp_f - 32) * (5/9))
  
  dp_hourly$dp <- round(dp_hourly$dp, 1)
  
  pressure_hourly <- 
    pressure %>%
    tbl_df() %>%
    select(state = State.Name,
           county = County.Name,
           site = Site.Num,
           lat = Latitude,
           lon = Longitude,
           date_local = Date.Local,
           time_local = Time.Local,
           pres = Sample.Measurement,
           datum = Datum,
           date_gmt = Date.GMT,
           time_gmt = Time.GMT,
           state_code = State.Code,
           county_code = County.Code)
  
  rm(pressure)
  
  join_cols <- 
    c("state", "county", "state_code", "county_code",
      "site", "lat", "lon", "datum",
      "date_local", "time_local",
      "date_gmt", "time_gmt")
  
  met_hourly <-
    full_join(wind_ws_hourly, 
              wind_wd_hourly,
              join_cols) %>% 
    full_join(., temp_hourly,
              join_cols) %>%
    full_join(., rh_hourly,
              join_cols) %>%
    full_join(., dp_hourly,
              join_cols) %>%
    full_join(., pressure_hourly,
              join_cols) %>%
    select(state, county, site,
           lat, lon, date_local, time_local,
           ws, wd, temp, rh, dp, pres,
           datum, date_gmt, time_gmt,
           state_code, county_code)
  
  save(met_hourly,
       file = paste0("data/met_hourly_", i, ".rdata"),
       compress = "bzip2")
}
