-- ============================================
-- 1. Location Data for Map Visualization
--    (Used for: Mapbox / Geographic Plot)
-- ============================================
SELECT 
    latitude,
    longitude,
    `GHG emissions mtons CO2e` AS emissions
FROM emissions_data;



-- ============================================
-- 2. Emissions Per Person (Scatter Plot)
-- ============================================
SELECT
    county_state_name,
    population,
    CAST(REPLACE(`GHG emissions mtons CO2e`, ',', '') AS DOUBLE) /
    NULLIF(CAST(REPLACE(population, ',', '') AS DOUBLE), 0) 
    AS emissions_per_person
FROM emissions_data
ORDER BY emissions_per_person DESC;



-- ============================================
-- 3. Total Emissions by State (Pie Chart)
-- ============================================
SELECT
    state_abbr,
    SUM(CAST(REPLACE(`GHG emissions mtons CO2e`, ',', '') AS DOUBLE)) 
        AS total_emissions
FROM emissions_data
GROUP BY state_abbr
ORDER BY total_emissions DESC
LIMIT 10;



-- ============================================
-- 4. Top 10 Highest-Emitting Counties (Bar Chart)
-- ============================================
SELECT
    county_state_name,
    population,
    CAST(REPLACE(`GHG emissions mtons CO2e`, ',', '') AS DOUBLE)
        AS total_emissions
FROM emissions_data
ORDER BY total_emissions DESC
LIMIT 10;
