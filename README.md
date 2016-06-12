<img src="inst/img/USAir.png">

This **R** package contains data files for criteria gases and particulates, and meteorology on an hourly basis from 1990–2015 from thousands of monitoring stations in the United States.

The data consists of:
- CO (`co_hourly_`)
- NO<sub>2</sub> (`no2_hourly_`)
- SO<sub>2</sub> (`so2_hourly_`)
- ozone (`ozone_hourly_`)
- PM<sub>10</sub> (`pm10_hourly_`)
- PM<sub>2.5</sub> (with FRM or FEM instruments) (`pm25_frm_fem_hourly_`, from 2008 - 2015)
- PM<sub>2.5</sub> (with non-FRM or non-FEM instruments) (`pm25_non_frm_fem_hourly_`, from 1998 - 2015)
- meteorological parameters (e.g., wind speed, wind direction, RH, P, etc.) (`met_hourly_`)

As an example, CO (carbon monoxide) data for 2000 can be accessed by using the following:

```r
data("co_hourly_2000")
```

This results in the `co_hourly_2000` `tbl_df` loaded into the workspace. To display part of this, simply provide the name of the object (`co_hourly_2000`).

```r
co_hourly_2000
#> Source: local data frame [4,109,166 x 24]

#>      state    county  site      lat       lon param date_local time_local value unit_meas
#>      (chr)     (chr) (int)    (dbl)     (dbl) (chr)      (chr)      (chr) (dbl)     (chr)
#> 1  Alabama Jefferson    28 33.52944 -86.85028    co 2000-01-01      00:00   1.0       ppm
#> 2  Alabama Jefferson    28 33.52944 -86.85028    co 2000-01-01      01:00   1.1       ppm
#> 3  Alabama Jefferson    28 33.52944 -86.85028    co 2000-01-01      02:00   1.1       ppm
#> 4  Alabama Jefferson    28 33.52944 -86.85028    co 2000-01-01      03:00   1.4       ppm
#> 5  Alabama Jefferson    28 33.52944 -86.85028    co 2000-01-01      04:00   1.4       ppm
#> 6  Alabama Jefferson    28 33.52944 -86.85028    co 2000-01-01      05:00   0.7       ppm
#> 7  Alabama Jefferson    28 33.52944 -86.85028    co 2000-01-01      06:00   1.0       ppm
#> 8  Alabama Jefferson    28 33.52944 -86.85028    co 2000-01-01      07:00   1.1       ppm
#> 9  Alabama Jefferson    28 33.52944 -86.85028    co 2000-01-01      08:00   1.0       ppm
#> 10 Alabama Jefferson    28 33.52944 -86.85028    co 2000-01-01      09:00   1.0       ppm
#> ..     ...       ...   ...      ...       ...   ...        ...        ...   ...       ...
#> Variables not shown: poc (int), mdl (dbl), uncert (lgl), qual (chr), method_type (chr),
#>   method_name (chr), datum (chr), date_gmt (chr), time_gmt (chr), param_code (int),
#>   method_code (int), state_code (int), county_code (int), date_last_chg (chr)
```

If that's not enough data you can use the included `usair_combine()` function to combine multiple years of data. For example, to get carbon monoxide (CO) data for all the years from 1990 to 2000 into a single object:
```r
co_1990_2000 <- usair_combine("co", c(1990, 2000))
```

Getting a count of rows for this object yields 45,654,962 records:
```r
nrow(co_1990_2000)
#> [1] 45654962
```

## Installation

You can install the development version of **USAir** from **GitHub** using the **devtools** package.

```r
devtools::install_github('rich-iannone/USAir')
```
