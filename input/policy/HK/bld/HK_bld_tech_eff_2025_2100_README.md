# Hong Kong building technological-efficiency pathways, 2025–2100

## Scope

The three XML files retain the previously defined 2025 values and add every five-year GCAM period from 2030 to 2100. They apply to new commercial-building technologies and to all ten urban-residential deciles. Rural residential sectors are excluded.

## Policy interpretation

The pathways are not calibrated to force achievement of the Hong Kong Climate Action Plan 2050 electricity-consumption targets. They represent plausible technology standards for new vintages under: (1) periodic tightening of the Building Energy Code; (2) product-efficiency grading and regrading under MEELS; and (3) wider and more frequent building energy audits from 2026. Policy affects the pace of technology improvement, while physical and engineering limits determine long-run saturation.

## Four phases

- **2025–2035:** implementation of BEC 2024 and continued three-year code reviews; strongest improvement in cooling and lighting.
- **2035–2050:** continued standards tightening and market diffusion, but lower annual improvement than the first phase.
- **2050–2065:** mature technologies approach practical limits; efficiency gains slow further.
- **2065–2100:** asymptotic improvement only; no discontinuous 2100 jump is retained.

## Constraints

- Standard cooling technologies are capped at 95% of the corresponding high-efficiency technology through 2060 and 98% thereafter.
- Standard combustion technologies with a high-efficiency counterpart are capped at 97% through 2060 and 99% thereafter.
- Commercial standard lighting is capped at 90% of fluorescent/high-efficiency lighting through 2060 and 95% thereafter.
- Direct electric furnaces, district heat, coal water heaters, high-efficiency resistance water heaters, and selected accounting-type unit-efficiency technologies remain fixed.
- Ordinary residential electric resistance water heating can approach but cannot exceed 1.0.
- High-efficiency cooling, heat pumps, appliances, lighting and combustion technologies have scenario-specific saturation ceilings.

GCAM `efficiency` is a service-output coefficient and is not universally identical to thermodynamic conversion efficiency. Consequently, a universal ceiling of 1.0 is not imposed on air conditioners, heat pumps or calibrated service technologies; physical consistency is instead enforced through technology-specific limits and counterpart ordering.

## Scenario interpretation

- **Conservative:** minimum standards improve, but implementation and market turnover are gradual.
- **Moderate:** recommended central case; regular code and label tightening continues through mid-century, followed by technological maturation.
- **Ambitious:** faster adoption of high-performance equipment and stronger future standards, but still bounded by practical technical ceilings.

## Official policy sources

- https://www.emsd.gov.hk/beeo/en/mibec_beeo.html
- https://www.emsd.gov.hk/beeo/en/mibec_beeo_codtechguidelines.html
- https://www.emsd.gov.hk/beeo/en/mibec_beeo_amendments.html
- https://www.emsd.gov.hk/en/energy_efficiency/mandatory_energy_efficiency_labelling_scheme/index.html
- https://www.emsd.gov.hk/energylabel/en/upgardsRAC.html
- https://www.info.gov.hk/gia/general/202411/22/P2024112200201.htm

## Files

- `HK_bld_tech_eff_2025_2100_conservative.xml`
- `HK_bld_tech_eff_2025_2100_moderate.xml`
- `HK_bld_tech_eff_2025_2100_ambitious.xml`
- `HK_bld_tech_eff_2025_2100_assumptions.csv`: all technology-period assumptions
- `HK_bld_tech_eff_2025_2100_rate_assumptions.csv`: annual improvement-rate assumptions
- `HK_bld_tech_eff_2025_2100_representative.csv`: representative trajectories
