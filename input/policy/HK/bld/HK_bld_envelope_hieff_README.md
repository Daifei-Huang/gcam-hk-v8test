# HK new-building envelope efficiency scenarios, 2030-2100

## Scope

These files modify only `shell-conductance` for new commercial and urban-residential building vintages in Hong Kong. They do not retrofit the existing building stock, change floorspace, change HVAC equipment efficiency, or directly constrain total building electricity use.

## GCAM interpretation

GCAM calculates the thermal load contribution from the envelope as:

`degree-days * shell-conductance * floor-to-surface-ratio`

and then adds internal gains separately. Therefore, a 10% reduction in `shell-conductance` reduces the envelope-driven part of heating/cooling thermal load by 10%, all else equal; it does not reduce total building energy use by 10%.

## Common reference and trajectory

The common 2025 reference is `0.947900`, calculated from the GCAM default 2021-2035 logistic s-curve between 0.95 and 0.93. Scenario divergence begins in 2030.

For each scenario and building type:

`C_t = C_min + (C_2025 - C_min) * 2^(-(t-2025)/H)`

where `C_min` is the practical long-run floor and `H` is the half-life of the remaining improvement potential.

## Scenario parameters

| Scenario | Commercial floor | Commercial H | Residential floor | Residential H |
|---|---:|---:|---:|---:|
| Conservative | 0.79 | 30 years | 0.81 | 30 years |
| Central | 0.69 | 24 years | 0.73 | 26 years |
| Ambitious | 0.58 | 18 years | 0.62 | 20 years |

Commercial envelopes improve slightly faster and reach a lower index because Hong Kong applies statutory OTTV control to commercial and hotel buildings, while residential control is implemented through RTTV requirements, glazing requirements, natural-ventilation design and development/GFA-concession mechanisms.

## Key values

| Scenario | Commercial 2050 | Residential 2050 | Commercial 2100 | Residential 2100 |
|---|---:|---:|---:|---:|
| Conservative | 0.8786 | 0.8874 | 0.8179 | 0.8344 |
| Central | 0.8153 | 0.8419 | 0.7196 | 0.7595 |
| Ambitious | 0.7205 | 0.7579 | 0.6005 | 0.6444 |

## Use

Load only one of the three 2030-2100 XML files in a model run. The ten residential income deciles use identical envelope trajectories. All 15 model periods from 2030 through 2100 are explicitly specified.
