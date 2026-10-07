USE CATALOG pr_population_volume;

CREATE OR REFRESH MATERIALIZED VIEW gold.gd_us_population_stats AS
SELECT
  '2013' as From_Year,
  '2018' as To_Year,
  ROUND(AVG(Population), 0) AS Mean_Population,
  ROUND(STDDEV(Population), 0) AS Standard_Deviation_Population  
FROM silver.sv_us_population_flattened
WHERE
Year BETWEEN 2013 AND 2018