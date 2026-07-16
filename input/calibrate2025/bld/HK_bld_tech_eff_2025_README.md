# HK building technological efficiency assumptions for 2025

## Scenario definition

The XML files modify the technological efficiency of new Hong Kong building-service technologies in the 2025 model period.

- **Conservative:** adjustable technologies target energy input per unit service equal to 90% of the 2005 level.
- **Moderate:** target 85% of the 2005 level. This is the recommended central case.
- **Ambitious:** target 80% of the 2005 level.

Because GCAM technological efficiency is inversely related to energy input intensity, the target efficiency is calculated as:

`target efficiency in 2025 = efficiency in 2005 / target energy-intensity ratio`

The final value is:

`proposed efficiency in 2025 = max(GCAM default efficiency in 2025, target efficiency in 2025)`

This prevents any scenario from making a technology less efficient than the default GCAM trajectory.

## GCAM default 2025 value

The source A44 file provides 2021 and 2035 values. GCAM/gcamdata uses smoothstep interpolation over model periods rather than linear interpolation by calendar year. Between 2021 and 2035, the intermediate periods are 2025 and 2030, so for 2025:

`x = 1/3`

`S(x) = 3x^2 - 2x^3 = 7/27 = 0.259259...`

Therefore:

`default_2025 = value_2021 + (value_2035 - value_2021) * 7/27`

## Technologies retained at the default value

Direct electric furnaces, electric heat pumps, district heat, coal water heaters, high-efficiency electric resistance water heaters, and selected commercial unit-efficiency water-heating technologies retain the GCAM default 2025 value. These are treated as direct-conversion, accounting, or technical-ceiling technologies. Ordinary residential electric resistance water heating is capped at an efficiency of 1.0.

## Scope and interpretation

The 80-90% assumptions apply to the energy input intensity of **new 2025 technology vintages**, not to the average energy consumption of the entire Hong Kong building stock. The model-wide effect will be smaller because existing vintages remain in operation and because service demand, floorspace, climate, and technology shares also affect total energy consumption.

The files cover commercial buildings and all ten Hong Kong urban-residential deciles. Rural residential sectors are excluded.
