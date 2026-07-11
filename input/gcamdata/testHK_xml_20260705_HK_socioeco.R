rm(list = ls())
gc()
# library(devtools)
# load_all()
#
# renv::status()

require(rstudioapi)
setwd(dirname(rstudioapi::getActiveDocumentContext()$path))

renv::deactivate()
library(devtools)
load_all()
options(gcamdata.use_java = TRUE)
# ?driver_drake

# driver(write_outputs = TRUE, xmldir = 'xml_test/', outdir = 'outputs_test/')

driver_drake(xmldir = 'xml_test1/', memory_strategy = "autoclean")

# Debug: module_gcamchina_L100.Socioeconomics_preliminary ================

driver_drake(xmldir = 'xml_test1/', memory_strategy = "autoclean", stop_before = "module_gcamchina_L100.Socioeconomics_preliminary")

L1L2Data <- load_from_cache(inputs_of("module_gcamchina_L100.Socioeconomics_preliminary"))
Region <- province.name <- Year <- GDP <- Population <- Sum <- Difference <- . <- `National Total` <- `Adjusted Population` <-
  SSP1 <- SSP2 <- SSP3 <- SSP4 <- SSP5 <- `SSP Growth Rate` <- `Growth Rate` <- `SSP National Projection` <-
  GDPperC_currentCNY <- `GDP deflator` <- GDPperC_constant2010CNY <- GDPperCadj <- GDPfinal <- GDP_deflator_CNY_WB <-
  National_GDP_perC <- GDPperCprojections <- GDPperC <- GDPbyCalcSum <- SSP2_HK <- NULL # silence package check.

population_to_1999 <- L1L2Data$`gcam-china/China_Compendium_of_Statistics` # the data in this CSV will be used for 1975 - 1999
population_to_2019 <- L1L2Data$`gcam-china/China_Statistics_Yearbook` # the data in this CSV will be used for 2000 - 2019
population_growth_rate <- L1L2Data$`gcam-china/Population_Growth_Rates` # the data in this CSV will be used for 2020 - 2100
SSP_pop <- L1L2Data$`gcam-china/SSPS_Population` # IIASA-WiC POP Region R32CHN

GDP_raw <- L1L2Data$`gcam-china/GDP_raw` # CNKI data extractor (China Statistics Yearbook and China Compendium of Statistics (60-year statistics))
GDP_deflator_raw <- L1L2Data$`gcam-china/GDP_deflator` # https://data.worldbank.org/indicator/NY.GDP.DEFL.ZS?locations=CN
IMF_growth_rates <- L1L2Data$`gcam-china/IMF_growth_rates` # IMF GDP per capita growth rates-World Economic Outlook (April 2020)
SSP_gdp <- L1L2Data$`gcam-china/SSPS_GDP` # OECD Env-Growth Region R32CHN

GDP_deflator_raw_hk <- L1L2Data$`gcam-china/GDP_deflator_HK` # https://data.worldbank.org/indicator/NY.GDP.DEFL.ZS?locations=HK
IMF_growth_rates_hk <- L1L2Data$`gcam-china/IMF_growth_rates_HK` # IMF GDP per capita growth rates-World Economic Outlook (April 2020)
SSP_pop_HK <- L1L2Data$`gcam-china/SSPS_Population_HK`
SSP_gdp_HK <- L1L2Data$`gcam-china/SSPS_GDP_HK`



L100.population_province_SSP <- load_from_cache("L100.population_province_SSP")$L100.population_province_SSP
L100.gdp_province_SSP <- load_from_cache("L100.gdp_province_SSP")$L100.gdp_province_SSP
