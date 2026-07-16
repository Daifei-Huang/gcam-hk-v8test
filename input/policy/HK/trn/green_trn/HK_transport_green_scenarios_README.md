# HK green transport scenario parameterization

## Output structure
Each scenario is split into five XML files: bus; non-road freight (domestic ship and freight rail); road freight; international aviation; and international shipping.

## Model limitation: taxis
The supplied GCAM-HK transportation XML has no independent Taxi subsector. Taxis are embedded in the 4W/Car representation together with private cars. Therefore the bus files directly parameterize Bus only; no taxi-specific XML is generated, to avoid changing all private cars.

## Interpretation
- Positive share-weight values open and progressively favor BEV, Electric, FCEV, or Hydrogen technologies. They are not literal sales or activity shares.
- Input-cost discounts represent purchase subsidies / support. Discounts apply at full strength through 2040, at half strength in 2045-2050, and expire after 2050.
- Scenario 1 is cautious and pilot-led; Scenario 2 begins earlier and uses stronger support; Scenario 3 gives FCEV/Hydrogen a much larger preference, especially in buses, heavy road freight, aviation and shipping.
- Aviation BEV/Hydrogen and shipping BEV/FCEV are model proxies for green propulsion/fuels available in the source XML; they should not be interpreted as a claim that all long-haul aircraft or ships are directly battery-powered.

## Loading
Load only the five files for the chosen scenario, together with the separately prepared private-car policy XML. Do not combine S1/S2/S3 files in one run.
