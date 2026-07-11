# HK building technology efficiency assumptions for 2025

## Scope

This package changes only the **2025 new-vintage technical-efficiency parameters** in the HK building service sectors. It does not directly retrofit the 2021 building stock and does not change building shell conductance.

The XML follows the structure of `HK_bld_tech_eff_2025.xml`, removes the historical 2020 periods, and applies the same residential assumptions to deciles d1-d10.

## Conversion rule

GCAM technical efficiency is service output divided by energy input. For an assumed 2025 energy-intensity ratio `R` relative to 2005:

`efficiency_2025 = efficiency_2005 / R`

Thus, a ratio of 0.82 means that a 2025 new technology requires 82% of the 2005 energy input per unit of building service, equivalent to an 18% reduction in service energy intensity.

## Default 2025 interpolation

For comparison, the default 2025 values in the assumptions CSV are calculated using GCAM's logistic s-curve between 2021 and 2035, with default steepness 10 and interval midpoint 2028. The resulting 2025 interpolation weight on the 2021-to-2035 change is `0.105000585` (about 10.50%), rather than the linear weight of 28.57%.

## Central intensity assumptions

- Residential cooling: 0.65 ordinary / 0.72 high-efficiency.
- Commercial cooling: 0.72 ordinary / 0.80 high-efficiency.
- Residential lighting: 0.60; commercial lighting: 0.65 ordinary / 0.75 fluorescent.
- Appliances: 0.82.
- Gas/fuel hot water and cooking: generally 0.82-0.90.
- Combustion heating: generally 0.85-0.95, with conservative treatment because heating is minor in Hong Kong.
- Resistance technologies and technical placeholders: generally 1.00 where further conversion-efficiency improvement is not well supported.

These are central scenario assumptions, not measured stock-average energy intensities. The more aggressive cooling and lighting values deliberately fall below the initially proposed 0.75-0.88 band because Hong Kong's equipment standards and technology transition indicate larger improvements for these end uses.
