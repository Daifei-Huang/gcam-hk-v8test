# HK building-envelope shell-conductance scenarios, 2025–2100

## Scope

The three XML files modify the normalized GCAM `shell-conductance` parameter for Hong Kong commercial buildings and ten urban residential deciles. Lower values represent lower effective heat transfer through the building envelope and therefore higher envelope efficiency. Values are supplied explicitly for every five-year model period from 2025 to 2100.

The parameter is **not** an OTTV, RTTV, U-value, or a directly observable physical conductivity. Consequently, Hong Kong OTTV/RTTV revisions are used to determine the direction and plausible pace of improvement, rather than being converted one-for-one into GCAM values.

## GCAM default and 2025 estimates

The source trajectory is 0.95 in 2021, 0.93 in 2035, 0.89 in 2050, and 0.89 thereafter. With GCAM's smoothstep/Hermite interpolation,

`S(x) = 3x^2 - 2x^3`,

2025 lies at `x = 4/14`, giving a default 2025 value of approximately **0.9448**.

| Scenario | Commercial 2025 | Residential 2025 | Interpretation |
|---|---:|---:|---|
| Conservative | 0.9448 | 0.9448 | Retains the GCAM default because revised Hong Kong requirements take effect for plans submitted at the end of 2025 |
| Moderate | 0.9422 | 0.9430 | Partial early uptake of tightened OTTV/RTTV requirements and better glazing/shading practice |
| Ambitious | 0.9395 | 0.9410 | Rapid adoption by high-performance projects, while remaining a modest change from the 2021 value |

## Policy and standards mapping

Commercial and hotel buildings are subject to statutory OTTV controls. The revised limits are 20 W/m2 for towers, previously 21 W/m2, and 40 W/m2 for podiums, previously 50 W/m2. The revised requirements apply to relevant plans submitted on or after 31 December 2025.

Residential requirements operate differently. For projects seeking specified gross-floor-area concessions, RTTV wall and roof limits are 12.5 and 3.5 W/m2, previously 14 and 4 W/m2. Residential recreational facilities are subject to OTTV limits similar to commercial buildings. The practice note also includes glazing and natural-ventilation provisions, but only the thermal-envelope component is represented by `shell-conductance`.

BEC/EAC are reviewed regularly. This supports continued standards-led improvement, but BEC is primarily a building-services code and is not treated as a direct numerical envelope constraint.

Official sources:

- https://www.bd.gov.hk/doc/en/resources/codes-and-references/practice-notes-and-circular-letters/pnap/APP/APP067.pdf
- https://www.bd.gov.hk/doc/en/resources/codes-and-references/practice-notes-and-circular-letters/pnap/APP/APP156.pdf
- https://www.emsd.gov.hk/beeo/en/mibec_beeo_codtechguidelines.html
- https://www.hkgbc.org.hk/eng/beam-plus/beam-plus-new-buildings/

## Annual compound decline assumptions

| Sector and scenario | 2025–2035 | 2035–2050 | 2050–2065 | 2065–2100 |
|---|---:|---:|---:|---:|
| Commercial conservative | 0.22% | 0.25% | 0.10% | 0.04% |
| Commercial moderate | 0.40% | 0.35% | 0.18% | 0.07% |
| Commercial ambitious | 0.60% | 0.48% | 0.25% | 0.10% |
| Residential conservative | 0.16% | 0.25% | 0.08% | 0.03% |
| Residential moderate | 0.28% | 0.27% | 0.13% | 0.05% |
| Residential ambitious | 0.42% | 0.36% | 0.18% | 0.07% |

Commercial improvement is faster because OTTV is a direct statutory requirement for commercial and hotel building envelopes and commercial buildings are generally more continuously air-conditioned. Residential improvements are slower because RTTV is linked primarily to development concessions, and residential design must balance solar control with daylight and natural ventilation.

## Physical and practical constraints

The trajectories remain positive and approach practical floors rather than zero. Hong Kong high-rise envelopes retain unavoidable heat transfer through glazing, frames, thermal bridges and infiltration. Very low conductance also encounters diminishing returns, moisture and condensation control, daylight and ventilation constraints, façade cost, embodied-carbon trade-offs, and limited retrofit opportunities.

The practical floors used as safeguards are:

| Scenario | Commercial floor | Residential floor |
|---|---:|---:|
| Conservative | 0.86 | 0.87 |
| Moderate | 0.80 | 0.84 |
| Ambitious | 0.75 | 0.80 |

These floors are modelling safeguards, not measured U-values. None of the generated trajectories crosses its floor before 2100.

## Interpretation caution

The XML changes the envelope parameter of new vintages. It does not imply that the entire building stock reaches the listed performance in each period. It also should not be interpreted as the same percentage reduction in total building electricity demand, because cooling demand depends on floor area, climate, occupancy, internal gains, equipment efficiency, technology shares and stock turnover.
