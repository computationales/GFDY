# This script runs the model calibration using the cluster Euler from ETHZ

library(dplyr)
library(tibble)
#if(!require(devtools)){install.packages(devtools)}
#devtools::install_github("stineb/rsofun")
library(devtools)
library(rsofun)
library(ggplot2)
library(multidplyr)

#build()
install()

load("inputs_mod/df_drivers_DBH_gs.RData")
load("inputs_mod/ddf_obs.RData")

settings_calib_DBH_gs <- list(
  method              = "gensa",
  targetvars          = c("targets_obs"),
  timescale           = list(targets_obs = "y"),
  maxit               = 2000, 
  sitenames           = "CH-Lae",
  metric              = "rmse",
  dir_results         = "./",
  name                = "ORG",
  par                 = list(phiRL = list(lower=0.5, upper=5, init=3.5),
                             LAI_light = list(lower=2, upper=5, init=3.5),
                             tf_base = list(lower=0.5, upper=1.5, init=1),
                             par_mort = list(lower=0.1, upper=2, init=1),
                             par_mort_under = list(lower=0.1, upper=1, init=1))
)

set.seed(1152)
settings_calib_DBH_gs <- calib_sofun(
  df_drivers = df_drivers,  
  ddf_obs = ddf_obs,
  settings = settings_calib_DBH_gs
)

save(settings_calib_DBH_gs, file = "inputs_mod/settings_calib_DBH_gs_uniq_euler.RData")
