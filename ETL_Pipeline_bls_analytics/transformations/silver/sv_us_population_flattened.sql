USE CATALOG pr_population_volume;

CREATE OR REFRESH STREAMING TABLE silver.sv_us_population_flattened AS
SELECT
  exploded_data.Nation as Nation,
  exploded_data.`Nation ID` as Nation_id,
  CAST(exploded_data.Population AS BIGINT) as Population,
  CAST(exploded_data.Year AS INT) as Year   
FROM STREAM bronze.bz_us_population
LATERAL VIEW explode(data) AS exploded_data;