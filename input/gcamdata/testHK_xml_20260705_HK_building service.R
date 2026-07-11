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
# driver(write_outputs = TRUE, xmldir = 'xml/')
# drake::clean(destroy = FALSE)

# driver(write_outputs = TRUE, xmldir = 'xml_adjHKconstdd/', outdir = 'outputs/')
driver_drake(xmldir = 'xml_test1/', memory_strategy = "autoclean",
             stop_after = "module_gcamchina_L144.Building")
driver_drake(xmldir = 'xml_test1/', memory_strategy = "autoclean",
             stop_before = "module_gcamchina_L244.building")

driver_drake(xmldir = 'xml_test1/', memory_strategy = "autoclean")
# driver(write_outputs = TRUE, xmldir = 'xml_test/', outdir = 'outputs_test/')

# replace hk constdd data in zgcamchina_L244.building_CHINA.R (30/05/2026)

## DEBUG: zgcamchina_L144.building_CHINA.R ====================================================================================
L144input <- load_from_cache(inputs_of("module_gcamchina_L144.Building"))

L142.in_EJ_R_bld_F_Yh <- L144input$L142.in_EJ_R_bld_F_Yh
L144.flsp_bm2_R_comm_Yh <- L144input$L144.flsp_bm2_R_comm_Yh
province_names_mappings <- L144input$`gcam-china/province_names_mappings`
calibrated_techs_bld_china <- L144input$`gcam-china/calibrated_techs_bld_china`
cR_BldS_F_U_share_res <- L144input$`gcam-china/cR_BldS_F_U_share_res`
cR_BldS_F_U_share_com <- L144input$`gcam-china/cR_BldS_F_U_share_com`
flsp_m2pc_province_Yh <- L144input$`gcam-china/floorspace_m2_province_Yh`
urban_pop_share_province <- L144input$`gcam-china/urban_pop_share_province`
L101.Pop_thous_province <- L144input$L101.Pop_thous_province
L101.inNBS_Mtce_province_S_F <- L144input$L101.inNBS_Mtce_province_S_F
cR_BldS_F_U_share_res_HK <- L144input$`gcam-china/cR_BldS_F_U_share_res_HK`
cR_BldS_F_U_share_com_HK <- L144input$`gcam-china/cR_BldS_F_U_share_com_HK`

# Silence package checks
GCAM_region_ID <- Rural <- Urban <- Year <- climate.region <- fuel <- pop <- pop.total <-
  pop.urban <- province <- sector <- sector.match <- service <- share <- value <- value.CHINA <-
  value.fuel <- value.province <- value.total <- value.x <- value.y <- year <- NULL

# # *** for HK version *** // Daifei 02/06/2026 Using Hong Kong customized share to split residential and commercial fuel consumption into services
# cR_BldS_F_U_share_res_HK <- data.table::fread("E:/0_HKU_work/2_GCAM/GCAM_china/gcam-china-v7-Windows-Release-Package/input/gcamdata/inst/extdata/gcam-china/cR_BldS_F_U_share_res_HK.csv")
# cR_BldS_F_U_share_com_HK <- data.table::fread("E:/0_HKU_work/2_GCAM/GCAM_china/gcam-china-v7-Windows-Release-Package/input/gcamdata/inst/extdata/gcam-china/cR_BldS_F_U_share_com_HK.csv")
# # *** for HK version *** // Daifei 02/06/2026 Using Hong Kong customized share to split residential and commercial fuel consumption into services

# 运行到 # May 2024, Rongqi ... Apportion fuel by services.
# 开始将能耗分配到 service

L144.cR_S_F_U_share_res <- cR_BldS_F_U_share_res %>%
  tidyr::pivot_longer(
    cols = c("heating modern", "cooling modern",
             "lighting modern", "hot water_cooking modern", "appliances modern"),
    names_to = "service",
    values_to = "share"
  )

L144.cR_S_F_U_share_com <- cR_BldS_F_U_share_com %>%
  tidyr::pivot_longer(
    cols = c("heating", "cooling", "lighting", "hot water_cooking", "appliances"),
    names_to = "service",
    values_to = "share"
  )

# *** for HK version *** // Daifei 02/06/2026 Using Hong Kong customized share to split residential and commercial fuel consumption into services
L144.cR_S_F_U_share_res_HK <- cR_BldS_F_U_share_res_HK %>%
  tidyr::pivot_longer(
    cols = c("heating modern", "cooling modern",
             "lighting modern", "hot water_cooking modern", "appliances modern"),
    names_to = "service",
    values_to = "share"
  )
L144.cR_S_F_U_share_com_HK <- cR_BldS_F_U_share_com_HK %>%
  tidyr::pivot_longer(
    cols = c("heating", "cooling", "lighting", "hot water_cooking", "appliances"),
    names_to = "service",
    values_to = "share"
  )

L144.in_EJ_province_bld_F_U_res <- L144.cR_S_F_U_share_res %>%
  # must use left join, as number of rows is changing
  left_join(province_names_mappings, by = c("climate.region")) %>%
  filter(province != "HK") %>%
  select(climate.region, sector, fuel, service, share, province) %>%
  # must use left join, as number of rows is changing
  left_join(L144.in_EJ_province_bld_F %>%
              filter(grepl('resid', sector)), by = c("province", "sector", "fuel")) %>%
  mutate(value = value * share) %>%
  # replace NA with 0
  mutate(value = if_else(is.na(value), 0, value)) %>%
  mutate(service = paste(sector, service, sep = " ")) %>%
  select(province, sector, fuel, service, year, value) %>%
  na.omit()

L144.in_EJ_province_bld_F_U_res_HK <- L144.cR_S_F_U_share_res_HK %>%
  # must use left join, as number of rows is changing
  left_join(province_names_mappings, by = c("climate.region"))  %>%
  # Set Hong Kong's resid_rural value or share as 0
  mutate(share = if_else(province == "HK" & sector == "resid_rural", 0, share)) %>%
  select(climate.region, sector, fuel, service, share, province) %>%
  # must use left join, as number of rows is changing
  left_join(L144.in_EJ_province_bld_F %>%
              filter(grepl('resid', sector)) %>%
              filter(province == "HK"), by = c("province", "sector", "fuel")) %>%
  mutate(value = value * share) %>%
  # replace NA with 0
  mutate(value = if_else(is.na(value), 0, value)) %>%
  mutate(service = paste(sector, service, sep = " ")) %>%
  select(province, sector, fuel, service, year, value) %>%
  na.omit()

L144.in_EJ_province_bld_F_U_com <- L144.cR_S_F_U_share_com %>%
  # must use left join, as number of rows is changing
  left_join(province_names_mappings, by = c("climate.region")) %>%
  filter(province != "HK") %>%
  select(climate.region, sector, fuel, service, share, province) %>%
  # must use left join, as number of rows is changing
  left_join(L144.in_EJ_province_bld_F %>%
              filter(grepl('comm', sector)), by = c("province", "sector", "fuel")) %>%
  mutate(value = value * share) %>%
  # replace NA with 0
  mutate(value = if_else(is.na(value), 0, value)) %>%
  mutate(service = paste(sector, service, sep = " ")) %>%
  select(province, sector, fuel, service, year, value) %>%
  na.omit()

L144.in_EJ_province_bld_F_U_com_HK <- L144.cR_S_F_U_share_com_HK %>%
  # must use left join, as number of rows is changing
  left_join(province_names_mappings, by = c("climate.region")) %>%
  filter(province == "HK") %>%
  select(climate.region, sector, fuel, service, share, province) %>%
  # must use left join, as number of rows is changing
  left_join(L144.in_EJ_province_bld_F %>%
              filter(grepl('comm', sector)) %>%
              filter(province == "HK"), by = c("province", "sector", "fuel")) %>%
  mutate(value = value * share) %>%
  # replace NA with 0
  mutate(value = if_else(is.na(value), 0, value)) %>%
  mutate(service = paste(sector, service, sep = " ")) %>%
  select(province, sector, fuel, service, year, value) %>%
  na.omit()

L144.in_EJ_province_bld_F_U_pre <- L144.in_EJ_province_bld_F_U_res %>%
  bind_rows(L144.in_EJ_province_bld_F_U_res_HK) %>%
  bind_rows(L144.in_EJ_province_bld_F_U_com) %>%
  bind_rows(L144.in_EJ_province_bld_F_U_com_HK)

# *** for HK version *** // Daifei 02/06/2026 Using Hong Kong customized share to split residential and commercial fuel consumption into services

View(L144.in_EJ_province_bld_F_U_res_HK %>% group_by(service, year) %>% summarise(sum = sum(value)))
View(L144.in_EJ_province_bld_F_U_com_HK %>% group_by(service, year) %>% summarise(sum = sum(value)))

# 这个 chunk 的 outputs
L144output <- load_from_cache(outputs_of("module_gcamchina_L144.Building"))
L144.in_EJ_province_bld_F_U <- L144output$L144.in_EJ_province_bld_F_U
L144.flsp_bm2_province_bld <- L144output$L144.flsp_bm2_province_bld

HK_bld_in_EJ <- L144.in_EJ_province_bld_F_U %>% filter(province == "HK") %>%
  group_by(sector, fuel, year) %>% summarise(sum = sum(value)) %>% ungroup()

## DEBUG: zgcamchina_L244.building_CHINA.R ====================================================================================

# 打开 zgcamchina_L244.building_CHINA.R，开始调试

# 设置小数位数 ####
# *** for HK version *** // Daifei 04/10/2025
# set digits
options(digits = 16)
# *** for HK version *** // Daifei 04/10/2025

# ***** 先准备数据 ***** ---------------
## Silence package checks
GCM <- Scen <- base.building.size <- base.service <- calibrated.value <- comm <-
  degree.days <- efficiency <- efficiency_tech1 <- efficiency_tech2 <- fuel <-
  gcam.consumer <- grid_region <- half_life_new <- half_life_stock <- input.cost <-
  input.ratio <- internal.gains.market.name <- internal.gains.output.ratio <-
  internal.gains.scalar <- market.name <- minicam.energy.input <- multiplier <-
  object <- pcFlsp_mm2 <- pcGDP <- pcflsp_mm2cap <- pop <- region <- resid <-
  satiation.adder <- satiation.level <- sector <- sector.name <- service <- share <-
  share.weight <- share_tech1 <- share_tech2 <- share_type <- state <- steepness_new <-
  steepness_stock <- stockavg <- subsector <- subsector.name <- supplysector <-
  tech_type <- technology <- technology1 <- technology2 <-
  thermal.building.service.input <- to.value <- value <- year <- year.fillout <- . <-
  pop_year <- Sector <- pop_share <- growth <- flsp_growth <- area_gcam <- misc_land_gtdc <-
  area_thouskm2 <- flsp <- pop_thous <- flsp_pc <- tot.dens <- unadjust.satiation <-
  land.density.param <- b.param <- income.param <- gdp_pc <- flsp_est <- base_flsp <-
  bias.adjust.param <- province_name <- NULL
## Load required inputs
inputdata <- inputs_of("module_gcamchina_L244.building") %>%
  load_from_cache()
L244.Supplysector_bld <- inputdata$L244.Supplysector_bld %>% filter(region == gcamchina.REGION)
L144.flsp_param <- inputdata$L144.flsp_param
L144.flsp_bm2_province_bld <- inputdata$L144.flsp_bm2_province_bld
L144.in_EJ_province_bld_F_U <- inputdata$L144.in_EJ_province_bld_F_U
L143.HDDCDD_scen_R_Y <- inputdata$L143.HDDCDD_scen_R_Y
L101.Pop_thous_province <- inputdata$L101.Pop_thous_province
L101.pcGDP_thous90usd_province <- inputdata$L101.pcGDP_thous90usd_province

A44.gcam_consumer_en <- inputdata$`energy/A44.gcam_consumer`
A44.sector_en <- inputdata$`energy/A44.sector`
calibrated_techs_bld_china <- inputdata$`gcam-china/calibrated_techs_bld_china`
province_names_mappings <- inputdata$`gcam-china/province_names_mappings`
A44.bld_shell_conductance <- inputdata$`gcam-china/A44.bld_shell_conductance`
A44.demandFn_flsp <- inputdata$`gcam-china/A44.demandFn_flsp`
A44.demandFn_serv <- inputdata$`gcam-china/A44.demandFn_serv`
A44.gcam_consumer <- inputdata$`gcam-china/A44.gcam_consumer`
A44.satiation_flsp <- inputdata$`gcam-china/A44.satiation_flsp`
A44.sector <- inputdata$`gcam-china/A44.sector`
A44.subsector_interp <- inputdata$`gcam-china/A44.subsector_interp`
A44.subsector_logit <- inputdata$`gcam-china/A44.subsector_logit`
A44.subsector_shrwt <- inputdata$`gcam-china/A44.subsector_shrwt`
A44.globaltech_cost <- inputdata$`gcam-china/A44.globaltech_cost`
A44.globaltech_eff <- inputdata$`gcam-china/A44.globaltech_eff` %>%
  gather_years()
A44.globaltech_eff_avg <- inputdata$`gcam-china/A44.globaltech_eff_avg`
A44.globaltech_shares <- inputdata$`gcam-china/A44.globaltech_shares`
A44.globaltech_intgains <- inputdata$`gcam-china/A44.globaltech_intgains`
A44.globaltech_retirement <- inputdata$`gcam-china/A44.globaltech_retirement`
A44.globaltech_shrwt <- inputdata$`gcam-china/A44.globaltech_shrwt`
A44.globaltech_interp <- inputdata$`gcam-china/A44.globaltech_interp`
A44.demand_satiation_mult <- inputdata$`gcam-china/A44.demand_satiation_mult`
A44.fuelprefElasticity <- inputdata$`gcam-china/A44.fuelprefElasticity`
L144.hab_land_flsp_china <- inputdata$`gcam-china/A44.hab_land_flsp_china`
income_shares <- inputdata$`socioeconomics/income_shares`
L144.prices_bld_gcamchina <- inputdata$`gcam-china/A44.CalPrice_service_gcamchina` %>%
  gather_years()
province_decile_gdp_per_capita_projections <- inputdata$`gcam-china/province_decile_gdp_per_capita_projections`
n_groups <- nrow(unique(inputdata$`socioeconomics/income_shares` %>%
                          select(category)))
urban_pop_share_province <- inputdata$`gcam-china/urban_pop_share_province`
urban_income_share_province <- inputdata$`gcam-china/urban_income_share_province`
A44.demand_satiation_mult_HK <- inputdata$`gcam-china/A44.demand_satiation_mult_HK`

HDDCDD_constdd_noGCM_HK <- inputdata$`gcam-china/HDDCDD_constdd_noGCM_HK`
# HDDCDD_NEX_GDDP_CMIP6_HK <- inputdata$`gcam-china/HDDCDD_NEX_GDDP_CMIP6_HK`
## Add a deflator for harmonizing GDPpc with prices
def9075 <- 2.212

L244output <- outputs_of("module_gcamchina_L244.building") %>%
  load_from_cache()
L244.DeleteConsumer_CHINAbld <- L244output$L244.DeleteConsumer_CHINAbld
L244.DeleteSupplysector_CHINAbld <- L244output$L244.DeleteSupplysector_CHINAbld
L244.SubregionalShares_gcamchina <- L244output$L244.SubregionalShares_gcamchina
L244.PriceExp_IntGains_gcamchina <- L244output$L244.PriceExp_IntGains_gcamchina
L244.Floorspace_gcamchina <- L244output$L244.Floorspace_gcamchina
L244.DemandFunction_serv_gcamchina <- L244output$L244.DemandFunction_serv_gcamchina
L244.DemandFunction_flsp_gcamchina <- L244output$L244.DemandFunction_flsp_gcamchina
L244.Satiation_flsp_gcamchina <- L244output$L244.Satiation_flsp_gcamchina
L244.SatiationAdder_gcamchina <- L244output$L244.SatiationAdder_gcamchin
L244.GenericBaseService_gcamchina <- L244output$L244.GenericBaseService_gcamchina
L244.ThermalServiceSatiation_gcamchina <- L244output$L244.ThermalServiceSatiation_gcamchina
L244.GenericServiceSatiation_gcamchina <- L244output$L244.GenericServiceSatiation_gcamchina

L244.ThermalServiceSatiation_gcamchina_HK <- L244output$L244.ThermalServiceSatiation_gcamchina_HK
L244.GenericServiceSatiation_gcamchina_HK <- L244output$L244.GenericServiceSatiation_gcamchina_HK

L244.Intgains_scalar_gcamchina <- L244output$L244.Intgains_scalar_gcamchina
L244.ShellConductance_bld_gcamchina <- L244output$L244.ShellConductance_bld_gcamchina
L244.Supplysector_bld_gcamchina <- L244output$L244.Supplysector_bld_gcamchina
L244.FinalEnergyKeyword_bld_gcamchina <- L244output$L244.FinalEnergyKeyword_bld_gcamchina
L244.SubsectorShrwt_bld_gcamchina <- L244output$L244.SubsectorShrwt_bld_gcamchina
L244.SubsectorShrwtFllt_bld_gcamchina <- L244output$L244.SubsectorShrwtFllt_bld_gcamchina
L244.SubsectorInterp_bld_gcamchina <- L244output$L244.SubsectorInterp_bld_gcamchina
L244.SubsectorInterpTo_bld_gcamchina <- L244output$L244.SubsectorInterpTo_bld_gcamchina
L244.SubsectorLogit_bld_gcamchina <- L244output$L244.SubsectorLogit_bld_gcamchina
L244.StubTech_bld_gcamchina <- L244output$L244.StubTech_bld_gcamchina
L244.StubTechCalInput_bld_gcamchina <- L244output$L244.StubTechCalInput_bld_gcamchina #***** building service tech calibrated energy consumption *****#
L244.StubTechMarket_bld_gcamchina <- L244output$L244.StubTechMarket_bld_gcamchina
L244.GlobalTechIntGainOutputRatio_gcamchina <- L244output$L244.GlobalTechIntGainOutputRatio_gcamchina
L244.GlobalTechInterpTo_bld_gcamchina <- L244output$L244.GlobalTechInterpTo_bld_gcamchina
L244.GlobalTechEff_bld_gcamchina <- L244output$L244.GlobalTechEff_bld_gcamchina
L244.GlobalTechShrwt_bld_gcamchina <- L244output$L244.GlobalTechShrwt_bld_gcamchina
L244.GlobalTechCost_bld_gcamchina <- L244output$L244.GlobalTechCost_bld_gcamchina
L244.GlobalTechSCurve_bld_gcamchina <- L244output$L244.GlobalTechSCurve_bld_gcamchina
L244.HDDCDD_A2_CCSM3x_China <- L244output$L244.HDDCDD_A2_CCSM3x_China
L244.HDDCDD_constdds_China <- L244output$L244.HDDCDD_constdds_China
L244.GompFnParam_gcamchina <- L244output$L244.GompFnParam_gcamchina
L244.Satiation_impedance_gcamchina <- L244output$L244.Satiation_impedance_gcamchina
L244.GenericServiceImpedance_gcamchina <- L244output$L244.GenericServiceImpedance_gcamchina
L244.GenericServiceCoef_gcamchina <- L244output$L244.GenericServiceCoef_gcamchina
L244.GenericServiceAdder_gcamchina <- L244output$L244.GenericServiceAdder_gcamchina
L244.ThermalServiceImpedance_gcamchina <- L244output$L244.ThermalServiceImpedance_gcamchina
L244.ThermalServiceCoef_gcamchina <- L244output$L244.ThermalServiceCoef_gcamchina
L244.ThermalServiceAdder_gcamchina <- L244output$L244.ThermalServiceAdder_gcamchina
L244.GenericServicePrice_gcamchina <- L244output$L244.GenericServicePrice_gcamchina
L244.ThermalServicePrice_gcamchina <- L244output$L244.ThermalServicePrice_gcamchina
L244.GenericBaseDens_gcamchina <- L244output$L244.GenericBaseDens_gcamchina
L244.ThermalBaseDens_gcamchina <- L244output$L244.ThermalBaseDens_gcamchina
L244.DeleteThermalService_gcamchina <- L244output$L244.DeleteThermalService_gcamchina
L244.DeleteGenericService_gcamchina <- L244output$L244.DeleteGenericService_gcamchina
L244.GenericShares_gcamchina <- L244output$L244.GenericShares_gcamchina
L244.ThermalShares_gcamchina <- L244output$L244.ThermalShares_gcamchina
L244.FuelPrefElast_
L244.DeleteConsumer_HKbld <- L244output$L244.DeleteConsumer_HKbld
L244.DeleteSupplysector_HKbld <- L244output$L244.DeleteSupplysector_HKbld

at <- L244.StubTechCalInput_bld_gcamchina %>% filter(region == "HK", year >= 2010) %>%
  mutate(comm_or_resid = case_when(grepl("comm", supplysector) ~ "comm",
                                   grepl("resid_urban", supplysector) ~ "resid",
                                   TRUE ~ NA_character_)) %>%
  mutate(service = case_when(grepl("electric appliances", stub.technology) ~ "appliances",
                             grepl("air conditioning", stub.technology) ~ "cooling",
                             grepl("air conditioning hi-eff", stub.technology) ~ "cooling",
                             grepl("wood furnace", stub.technology) ~ "heating",
                             grepl("coal furnace", stub.technology) ~ "heating",
                             grepl("electric furnace", stub.technology) ~ "heating",
                             grepl("electric heat pump", stub.technology) ~ "heating",
                             grepl("gas furnace", stub.technology) ~ "heating",
                             grepl("gas furnace hi-eff", stub.technology) ~ "heating",
                             grepl("district heat", stub.technology) ~ "heating",
                             grepl("fuel furnace", stub.technology) ~ "heating",
                             grepl("fuel furnace hi-eff", stub.technology) ~ "heating",
                             grepl("coal water heater", stub.technology) ~ "hot water_cooking",
                             grepl("electric resistance water heater", stub.technology) ~ "hot water_cooking",
                             grepl("electric resistance water heater hi-eff", stub.technology) ~ "hot water_cooking",
                             grepl("gas water heater", stub.technology) ~ "hot water_cooking",
                             grepl("gas water heater hi-eff", stub.technology) ~ "hot water_cooking",
                             grepl("fuel water heater", stub.technology) ~ "hot water_cooking",
                             grepl("fuel water heater hi-eff", stub.technology) ~ "hot water_cooking",
                             grepl("elec light", stub.technology) ~ "lighting",
                             grepl("fluorescent", stub.technology) ~ "lighting",
                             TRUE ~ NA_character_)) %>%
  group_by(year, comm_or_resid, service) %>% summarise(sum = sum(calibrated.value)) %>%
  ungroup() %>% na.omit() %>% View()
